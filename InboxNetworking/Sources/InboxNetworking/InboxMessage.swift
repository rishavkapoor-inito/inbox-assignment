//
//  InboxMessage.swift
//  InboxNetworking
//
//  Created by User on 29/08/25.
//

import Foundation


public struct InboxMessage: Codable, Identifiable, Sendable {

    public let id: Int
    public let title: String
    public let url: String
    public let thumbnailUrl: String
}



