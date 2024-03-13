//
//  FeedViewModel.swift
//  SciianX
//
//  Created by Philipp Henkel on 12.03.24.
//

import Foundation

class FeedViewModel: ObservableObject, Identifiable {
    
    @Published private(set) var creator: UserProfile
    @Published private(set) var text: String
    @Published private(set) var translatedText: String?
    @Published private(set) var likes: [UserProfile]
    @Published private(set) var comments: [CommentViewModel]
    @Published private(set) var createdAt: Date
    @Published private(set) var createdAtString: String
    @Published private(set) var updatedAt: Date
    @Published private(set) var activeUsers: [UserProfile]
    
    let id: String?
    
    private let user: UserProfile
    private let translationRepository = TranslationRepository.shared
    private let feedRepository = FirebaseFeedRepository.shared
    
    init(_ feed: Feed, withUser user: UserProfile) {
        self.creator = feed.creator
        self.text = feed.text
        self.likes = feed.likes
        self.comments = feed.comments.compactMap { CommentViewModel($0) }
        self.createdAt = feed.createdAt
        self.createdAtString = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy HH:mm"
            return formatter.string(from: feed.createdAt)
        }()
        self.updatedAt = feed.updatedAt
        self.activeUsers = feed.activeUsers
        self.id = feed.id
        self.user = user
    }
    
    @MainActor
    func translateText() {
        Task {
            do {
                let translation = try await translationRepository.translateText(self.text)
                
                self.translatedText = translation.data.translatedText
            } catch {
                print("Failed translating text: \(error)")
            }
        }
    }
    
    func likeFeed() {
        feedRepository.likeFeed(withUser: user, feed: self.asFeed())
    }
    
    func createComment(_ text: String) {
        self.feedRepository.createComment(text, withUser: user, feed: self.asFeed())
    }
    
    private func asFeed() -> Feed {
        return Feed(
            id: self.id,
            creator: self.creator,
            text: self.text,
            likes: self.likes,
            comments: self.comments.compactMap {
                $0.asComment()
            },
            createdAt: self.createdAt,
            updatedAt: self.updatedAt,
            activeUsers: self.activeUsers
        )
    }
}
