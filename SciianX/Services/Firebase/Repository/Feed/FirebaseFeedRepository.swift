//
//  FirebaseFeedRepository.swift
//  SciianX
//
//  Created by Philipp Henkel on 12.03.24.
//

import Foundation
import FirebaseFirestore

class FirebaseFeedRepository {
    
    static let shared = FirebaseFeedRepository()
    
    private var listener: ListenerRegistration?
        
    private init() {}
    
    func createFeed(_ text: String, withUser user: UserProfile) {
        let feed = Feed(
            creator: user,
            text: text,
            likes: [],
            comments: [],
            createdAt: Date(),
            updatedAt: Date(),
            activeUsers: []
        )
        
        do {
            try FirebaseManager.shared.firestore.collection("feeds").document().setData(from: feed)
        } catch {
            print("Create feed failed: \(error)")
        }
    }
    
    func likeFeed(withUser user: UserProfile, feed: Feed) {
        let updatedFeed = feed.copy {
            if $0.likes.contains(where: { $0 == user }) {
                $0.likes.removeAll(where: { $0 == user })
            } else {
                $0.likes.append(user)
            }
            $0.updatedAt = Date()
        }
        
        do {
            try FirebaseManager.shared.firestore.collection("feeds").document().setData(from: updatedFeed, merge: true)
        } catch {
            print("Like feed failed: \(error)")
        }
    }
    
    func createComment(_ text: String, withUser user: UserProfile, feed: Feed) {
        let updatedFeed = feed.copy {
            $0.comments.append(Comment(creator: user, text: text, createdAt: Date()))
            $0.updatedAt = Date()
        }
        
        do {
            try FirebaseManager.shared.firestore.collection("feeds").document().setData(from: updatedFeed, merge: true)
        } catch {
            print("Like feed failed: \(error)")
        }
    }
    
    func fetchAllFeeds(completion: @escaping (Result<[Feed], FirebaseError>) -> Void) {
        self.listener = FirebaseManager.shared.firestore.collection("feeds").addSnapshotListener { querySnapshot, error in
            if let error {
                print("Fetch feeds failed: \(error)")
                completion(.failure(.unknown(error)))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("Query Snapshot has no documents")
                completion(.failure(.collectioNotFound))
                return
            }
            
            let allFeeds = documents.compactMap { document in
                try? document.data(as: Feed.self)
            }
            
            completion(.success(allFeeds))
        }
    }
}
