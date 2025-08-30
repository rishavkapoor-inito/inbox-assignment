//
//  ResourceLoader.swift
//  InboxResources
//
//  Created by User on 30/08/25.
//

import Foundation

public enum ResourceLoader {
    public static func data(named name: String, ext: String = "json") throws -> Data {
        guard let url = Bundle.module.url(forResource: name, withExtension: ext) else {
            throw NSError(domain: "InboxResources", code: 1,
                          userInfo: [NSLocalizedDescriptionKey: "Resource not found: \(name).\(ext)"])
        }
        return try Data(contentsOf: url)
    }
}

