//
//  InboxMessageResult.swift
//  InboxKit
//
//  Created by User on 30/08/25.
//


import Foundation
import InboxNetworking

public struct InboxMessageResult: Identifiable, Codable {
    public let id: Int
    public let title: String
    public let description: String
    public let thumbnailURL: String

    
    public init(dto: InboxMessage) {
        self.id = dto.id
        self.title = dto.title
        self.description = dto.title
        
        var url = dto.thumbnailUrl

        let parts = url.split(separator: "/")

        if parts.count >= 2 {
            let size = parts[parts.count - 2]   // "150"
            let color = parts[parts.count - 1]  // "92c952"
            
            let converted = "https://dummyimage.com/\(size)x\(size)/\(color)/ffffff"
            url = converted
        }
        self.thumbnailURL = url
       
    }
}



