//
//  FeedsViewModel.swift
//  SciianX
//
//  Created by Philipp Henkel on 12.03.24.
//

import Foundation

class FeedsViewModel: ObservableObject {
    
    @Published private(set) var feeds: [FeedViewModel] = []
    @Published private(set) var followedFeeds: [FeedViewModel] = []
    
    private let user: UserProfile?
    private let feedRepository = FirebaseFeedRepository.shared
    
    init(_ user: UserProfile?) {
        self.user = user
        self.fetchAllFeeds()
    }
    
    func createFeed(_ text: String, withUser user: UserProfile) {
        feedRepository.createFeed(text, withUser: user)
    }
    
    private func fetchAllFeeds() {
        feedRepository.fetchAllFeeds() { result in
            switch result {
            case .success(let allFeeds):
                if let user = self.user {
                    self.feeds = allFeeds.compactMap { FeedViewModel($0, withUser: user) }
                    self.feeds.sort(by: { $0.updatedAt > $1.updatedAt })
                    
                    self.followedFeeds = self.feeds.filter { user.following.contains($0.creator) }
                }
            case .failure(let error):
                print("Failed fetching feeds: \(error)")
            }
        }
    }
}
