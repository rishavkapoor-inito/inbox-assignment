//
//  InboxService.swift
//  InboxKit
//
//  Created by User on 30/08/25.
//

import Foundation
import Combine
import InboxNetworking

@MainActor
public final class InboxService: ObservableObject{
    public enum State {
        case idle
        case loading
        case loaded([InboxMessageResult])
        case error(String)
    }

    @Published public private(set) var state: State = .idle
    private let networking: NetworkingService

    public init(networking: NetworkingService) {
        self.networking = networking
    }

    public func fetchMessages() {
        state = .loading
        networking.fetchMessages { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dtos):
                    let models = dtos.map { InboxMessageResult(dto: $0) }
                    self?.state = .loaded(models)
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
}
