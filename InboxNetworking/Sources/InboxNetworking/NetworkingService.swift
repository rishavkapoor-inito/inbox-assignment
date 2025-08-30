//
//  NetworkingService.swift
//  InboxNetworking
//
<<<<<<< HEAD
//  Created by User on 29/08/25.
=======
//  Created by User on 30/08/25.
>>>>>>> inboxNetworking
//

import Foundation

public protocol NetworkingService {
<<<<<<< HEAD
    func fetchMessages(completion: @escaping (Result<[InboxMessage], Error>) -> Void)
=======
    func fetchMessages(completion: @Sendable @escaping (Result<[InboxMessage], Error>) -> Void)
>>>>>>> inboxNetworking
}
