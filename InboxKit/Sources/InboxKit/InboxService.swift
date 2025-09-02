//
//  InboxService.swift
//  InboxKit
//
//  Created by User on 30/08/25.
//

import Foundation
import Combine
import InboxNetworking
import CoreData
import Kingfisher

@MainActor
public final class InboxService: ObservableObject{
    
    public enum CacheReason {
        case offline
        case apiError(String)
    }
    
    public enum State {
        case idle
        case loading
        case loaded([InboxMessageResult], reason: CacheReason?)
        case error(String)
    }
    
    @Published public private(set) var state: State = .idle
    private let networking: NetworkingService
    
    public init(networking: NetworkingService) {
        self.networking = networking
    }
    
    private let context = PersistenceController.shared.context
    
    public func fetchMessages() {
        state = .loading
        networking.fetchMessages { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dtos):
                    let models = dtos.map { InboxMessageResult(dto: $0) }
                    self?.saveToCache(models)
                    
                    self?.state = .loaded(models, reason: nil)
                case .failure(let error):
                    // load cache
                    let cached = self?.loadFromCache() ?? []
                    if !cached.isEmpty {
                        if let urlError = (error.asAFError?.underlyingError as? URLError),
                           urlError.code == .notConnectedToInternet {
                            self?.state = .loaded(cached, reason: .offline)
                        } else {
                            self?.state = .loaded(cached, reason: .apiError(error.localizedDescription))
                        }
                    } else {
                        self?.state = .error(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func saveToCache(_ messages: [InboxMessageResult]) {
        // remove old data
        let fetch: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CachedInboxMessage")
        let delete = NSBatchDeleteRequest(fetchRequest: fetch)
        _ = try? context.execute(delete)
        
        // insert new
        for msg in messages {
            let cached = CachedInboxMessage(context: context)
            cached.id = Int64(msg.id)
            cached.title = msg.title
            cached.description_ = msg.description
            cached.thumbnailURL = msg.thumbnailURL
        }
        
        try? context.save()
    }
    
    private func loadFromCache() -> [InboxMessageResult] {
        let request: NSFetchRequest<CachedInboxMessage> = CachedInboxMessage.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        guard let results = try? context.fetch(request) else { return [] }
        
        return results.map {
            InboxMessageResult(
                id: Int($0.id),
                title: $0.title ?? "",
                description: $0.description_ ?? "",
                thumbnailURL: $0.thumbnailURL ?? ""
            )
        }
    }
}
