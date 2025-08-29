//
//  NetworkingService.swift
//  InboxNetworking
//
//  Created by User on 29/08/25.
//

import Foundation

public protocol NetworkingService {
    func fetchMessages(completion: @escaping (Result<[InboxMessage], Error>) -> Void)
}
