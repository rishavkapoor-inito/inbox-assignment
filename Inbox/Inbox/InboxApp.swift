//
//  InboxApp.swift
//  Inbox
//
//  Created by User on 29/08/25.
//

import SwiftUI
import InboxKit
import Kingfisher


@main
struct InboxApp: App {
    @MainActor private let persistence = PersistenceController.shared
    init() {
            // Configure Kingfisher cache
            let cache = ImageCache.default
            
            // Memory cache (in RAM)
            cache.memoryStorage.config.totalCostLimit = 50 * 1024 * 1024 // 50 MB
            
            // Disk cache (persisted to files)
            cache.diskStorage.config.sizeLimit = 200 * 1024 * 1024 // 200 MB
            cache.diskStorage.config.expiration = .days(7) // Keep images 7 days
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistence.context)
        }
    }
}
