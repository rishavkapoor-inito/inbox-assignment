//
//  DefaultNetworkingService.swift
//  InboxNetworking
//
//  Created by User on 30/08/25.
//

import Foundation
import Alamofire

public final class DefaultNetworkingService: NetworkingService {
    
    
    private let session: Session
    private let baseURL: URL
    
    init(session: Session, baseURL: URL) {
        self.session = session
        self.baseURL = baseURL
    }
    
    public func fetchMessages(completion: @Sendable @escaping (Result<[InboxMessage], any Error>) -> Void) {
        let endpoint = baseURL.appendingPathComponent("photos")
        
        session.request(endpoint)
                    .validate()
                    .responseDecodable(of: [InboxMessage].self) { response in
                        switch response.result {
                        case .success(let items): completion(.success(items))
                        case .failure(let error): completion(.failure(error))
                        }
                    }
        
        
    }
    
    
    
    
}
