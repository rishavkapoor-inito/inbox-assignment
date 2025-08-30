//
//  DetailView.swift
//  Inbox
//
//  Created by User on 30/08/25.
//

import SwiftUI
import Kingfisher
import InboxKit

struct DetailView: View {
    let message: InboxMessageResult

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(URL(string: message.thumbnailURL))
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .shadow(radius: 4)

                Text(message.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text(message.description)
                    .font(.body)
                    .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Message")
        .navigationBarTitleDisplayMode(.inline)
    }
}
