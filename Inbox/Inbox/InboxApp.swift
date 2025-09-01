//
//  InboxApp.swift
//  Inbox
//
//  Created by User on 29/08/25.
//

import SwiftUI
import InboxKit

@main
struct InboxApp: App {
    @MainActor private let persistence = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistence.context)
        }
    }
}
