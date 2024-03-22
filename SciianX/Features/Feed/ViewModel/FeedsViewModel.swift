//
//  FeedsViewModel.swift
//  SciianX
//
//  Created by Philipp Henkel on 12.03.24.
//

import Foundation
import SwiftUI
import PhotosUI

class FeedsViewModel: ObservableObject {
    
    @Published private(set) var feeds: [FeedViewModel] = []
    @Published private(set) var followedFeeds: [FeedViewModel] = []
    @Published private(set) var ownFeeds: [FeedViewModel] = []
    @Published private(set) var usedFeeds: [FeedViewModel] = []
    
    private let user: UserProfile?
    private let feedRepository = FirebaseFeedRepository.shared
    
    init(_ user: UserProfile?) {
        self.user = user
        self.fetchAllFeeds()
    }
    
    func createFeed(_ text: String, _ images: [UIImage], withUser user: UserProfile) {
        let imageData = images.compactMap {
            $0.jpegData(compressionQuality: 0.8)
        }
        
        Task {
            await feedRepository.createFeed(text, imageData, withUser: user)
        }
    }
    
    func convertImagePicker(_ data: [PhotosPickerItem], completion: @escaping ([UIImage]) -> Void) {
        Task {
            var loadedImages: [UIImage] = []
            
            for item in data {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        loadedImages.append(uiImage)
                    }
                }
            }
            
            completion(loadedImages)
        }
    }
    
    private func fetchAllFeeds() {
        feedRepository.fetchAllFeeds() { [weak self] result in
            switch result {
            case .success(let allFeeds):
                if let user = self?.user {
                    let oldFeeds = self?.feeds ?? []
                    
                    self?.feeds = allFeeds.compactMap { feed in
                        if let oldFeed = oldFeeds.first(where: { $0.id == feed.id }) {
                            FeedViewModel(feed, withUser: user, translatedText: oldFeed.translatedText)
                        } else {
                            FeedViewModel(feed, withUser: user)
                        }
                    }
                    self?.feeds.sort(by: { $0.updatedAt > $1.updatedAt })
                    
                    if let feeds = self?.feeds {
                        self?.followedFeeds = feeds.filter { user.following.contains($0.creator) }
                        
                        self?.ownFeeds = feeds.filter { $0.creator == user }
                        
                        self?.usedFeeds = feeds.filter { $0.activeUsers.contains(user) }
                    }
                }
            case .failure(let error):
                print("Failed fetching feeds: \(error)")
            }
        }
    }
}
