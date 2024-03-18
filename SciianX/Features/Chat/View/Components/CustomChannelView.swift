//
//  CustomChannelView.swift
//  SciianX
//
//  Created by Philipp Henkel on 18.03.24.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct CustomChannelView: View {
    
    @StateObject private var chatViewModel: ChatChannelViewModel
    
    @State private var channelInfoShown = false
    @State private var messageDisplayInfo: MessageDisplayInfo?
    @State private var isVideoCalling = false
    
    init() {
        _chatViewModel = StateObject(wrappedValue: ChatChannelViewModel(channelController: InjectedValues[\.chatClient].channelController(for: try! ChannelId(cid: "messaging:5A9427AD-E"))))
    }
    
    var body: some View {
        NavigationStack {
            if let channel = chatViewModel.channel {
                VStack {
                    MessageListView(
                        factory: DefaultViewFactory.shared,
                        channel: channel,
                        messages: self.chatViewModel.messages,
                        messagesGroupingInfo: self.chatViewModel.messagesGroupingInfo,
                        scrolledId: self.$chatViewModel.scrolledId,
                        showScrollToLatestButton: self.$chatViewModel.showScrollToLatestButton,
                        quotedMessage: self.$chatViewModel.quotedMessage,
                        currentDateString: self.chatViewModel.currentDateString,
                        listId: self.chatViewModel.listId,
                        onMessageAppear: self.chatViewModel.handleMessageAppear(index:scrollDirection:),
                        onScrollToBottom: self.chatViewModel.scrollToLastMessage,
                        onLongPress: { displayInfo in
                            messageDisplayInfo = displayInfo
                            withAnimation {
                                self.chatViewModel.showReactionOverlay(for: AnyView(self))
                            }
                        }
                    )
                    
                    MessageComposerView(
                        viewFactory: DefaultViewFactory.shared,
                        channelController: self.chatViewModel.channelController,
                        quotedMessage: self.$chatViewModel.quotedMessage,
                        editedMessage: self.$chatViewModel.editedMessage,
                        onMessageSent: self.chatViewModel.scrollToLastMessage
                    )
                }
                .overlay(
                    self.chatViewModel.reactionsShown ?
                    ReactionsOverlayView(
                        factory: DefaultViewFactory.shared,
                        channel: channel,
                        currentSnapshot: self.chatViewModel.currentSnapshot!,
                        messageDisplayInfo: messageDisplayInfo!,
                        onBackgroundTap: {
                            self.chatViewModel.reactionsShown = false
                            messageDisplayInfo = nil
                        },
                        onActionExecuted: { actionInfo in
                            self.chatViewModel.messageActionExecuted(actionInfo)
                            messageDisplayInfo = nil
                        }
                    )
                    .transition(.identity)
                    .ignoresSafeArea()
                    : nil
                )
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            self.isVideoCalling.toggle()
                        } label: {
                            Image(systemName: "video.fill")
                        }
                    }
                    
                    DefaultChatChannelHeader(
                        channel: channel,
                        headerImage: InjectedValues[\.utils].channelHeaderLoader.image(for: channel),
                        isActive: $channelInfoShown
                    )
                }
            }
        }
    }
}
