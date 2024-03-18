//
//  ChatView.swift
//  SciianX
//
//  Created by Philipp Henkel on 11.01.24.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct ChatOverViewView: View {
    
    @State var streamChat: StreamChat?
    
    var chatClient: ChatClient = {
        // MARK: HIER API_KEY EINFÜGEN
        var config = ChatClientConfig(apiKey: .init(StreamChatManager.shared.apiKey))
        config.isLocalStorageEnabled = true
        // MARK: HIER IDENTIFIER EINFÜGEN
        config.applicationGroupIdentifier = "group.io.getstream.iOS.ChatDemoAppSwiftUI"

        let client = ChatClient(config: config)
        return client
    }()
    
    init() {
        self.streamChat = StreamChat(chatClient: self.chatClient)
        self.connectUser()
    }
    
    var body: some View {
        if let user = chatClient.currentUserId {
            ChatChannelListView()
        } else {
            Text("Connecting User")
        }
    }
    
    private func connectUser() {
        let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibHVrZV9za3l3YWxrZXIifQ.kFSLHRB5X62t0Zlc7nwczWUfsQMwfkpylC6jCUZ6Mc0")
        
        chatClient.connectUser(userInfo: .init(
            // MARK: HIER USER_ID EINFÜGEN
            id: "luke_skywalker",
            // MARK: HIER USER_REAL_NAME EINFÜGEN
            name: "Luke Skywalker",
            // MARK: HIER USER_IMAGE_URL EINFÜGEN
            imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!
        ), token: token) { error in
            if let error {
                print("Failed connecting user to StreamChat: \(error)")
            }
        }
    }
}

#Preview {
    ChatOverViewView()
}

/*
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
                         destination: DetailChatView(),
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
 */
