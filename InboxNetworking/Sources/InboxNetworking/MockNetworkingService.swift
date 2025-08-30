//
//  MockNetworkingService.swift
//  InboxNetworking
//
//  Created by User on 30/08/25.
//

import Foundation
import InboxResources

public final class MockNetworkingService: NetworkingService {
    private let resourceName: String

    public init(resourceName: String = "photos-mock") {
        self.resourceName = resourceName
    }

    public func fetchMessages(completion: @Sendable @escaping (Result<[InboxMessage], Error>) -> Void) {
        do {
            let data = try ResourceLoader.data(named: resourceName)
            let items = try JSONDecoder().decode([InboxMessage].self, from: data)
            completion(.success(items))
        } catch {
            completion(.failure(error))
        }
    }
}
