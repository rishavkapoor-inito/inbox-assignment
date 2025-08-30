//
//  ContentView.swift
//  Inbox
//
//  Created by User on 29/08/25.
//

import SwiftUI
import InboxKit
import InboxNetworking
import Kingfisher

struct ContentView: View {
    @StateObject private var service = InboxService(networking: DefaultNetworkingService())
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Inbox")
        }
        .onAppear {
            service.fetchMessages()
        }
        
    }
    
    @ViewBuilder
    private var content: some View{
        switch service.state {
        case .idle, .loading:
            ProgressView("Loading…")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .error(let message):
            Text("Error: \(message)")
        case .loaded(let messages):
            List(messages) { msg in
                NavigationLink(destination:DetailView(message: msg)) {
                    HStack {
                        KFImage(URL(string: msg.thumbnailURL))
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text(msg.title).font(.headline).lineLimit(1)
                            Text(msg.description).font(.subheadline).lineLimit(2)
                        }
                    }
                }
            }
        }
    }
    
    
    

    
    
}

