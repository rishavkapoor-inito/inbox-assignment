//
//  ContentView.swift
//  Inbox
//
//  Created by User on 29/08/25.
//

import SwiftUI
import InboxNetworking

struct ContentView: View {
    private let networking = MockNetworkingService()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    
    
}

#Preview {
    ContentView()
}
