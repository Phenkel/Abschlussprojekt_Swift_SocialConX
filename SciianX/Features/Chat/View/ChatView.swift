//
//  ChatView.swift
//  SciianX
//
//  Created by Philipp Henkel on 11.01.24.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundImage()
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0...25, id: \.self) { post in
                                    ProfilePictureSmall()
                                }
                            }
                            .padding()
                        }
                        Divider()
                        
                        ForEach(0...25, id: \.self) { post in
                            NavigationLink(
                                destination: SingleChatView(),
                                label: {
                                    ChatPreviewRow()
                                })
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .navigationTitle("Xversations")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }, label: {
                        Text("Translated Texts")
                            .font(.caption2)
                    })
                }
            }
        }
    }
}

#Preview {
    ChatView()
}
