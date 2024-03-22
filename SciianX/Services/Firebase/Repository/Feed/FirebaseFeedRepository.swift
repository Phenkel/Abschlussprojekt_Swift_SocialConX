//
//  FirebaseFeedRepository.swift
//  SciianX
//
//  Created by Philipp Henkel on 12.03.24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class FirebaseFeedRepository {
    
    static let shared = FirebaseFeedRepository()
    
    private var feedIdsListener: ListenerRegistration?
    private var feedsListeners: [ListenerRegistration] = []
    
    private init() {}
    
    func createFeed(_ text: String, _ images: [Data], withUser user: UserProfile) async {
        var imageUrls: [URL?] = []
        
        for imageData in images {
            imageUrls.append(await self.uploadImage(imageData, withUserId: user.id))
        }
                
        let feed = Feed(
            creator: user,
            text: text,
            likes: [],
            comments: [],
            createdAt: Date(),
            updatedAt: Date(),
            activeUsers: [],
            images: imageUrls.compactMap { $0?.absoluteString }
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
            if let id = updatedFeed.id {
                try FirebaseManager.shared.firestore.collection("feeds").document(id).setData(from: updatedFeed, merge: true)
            }
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
            if let id = updatedFeed.id {
                try FirebaseManager.shared.firestore.collection("feeds").document(id).setData(from: updatedFeed, merge: true)
            }
        } catch {
            print("Like feed failed: \(error)")
        }
    }
    
    func fetchAllFeeds(completion: @escaping (Result<[Feed], FirebaseError>) -> Void) {
        self.feedIdsListener = FirebaseManager.shared.firestore.collection("feeds").addSnapshotListener { querySnapshot, error in
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
    
//    func fetchFeed(_ feedId: String, completion: @escaping (Result<Feed, FirebaseError>) -> Void) {
//        self.listener = FirebaseManager.shared.firestore.collection("feeds").document(feedId).addSnapshotListener { documentSnapshot, error in
//            if let error {
//                print("Fetch feeds failed: \(error)")
//                completion(.failure(.unknown(error)))
//                return
//            }
//            
//            guard let document = documentSnapshot else {
//                print("Document Snapshot has no data")
//                completion(.failure(.documentNotFound))
//                return
//            }
//            
//            let feed = try? document.data(as: Feed.self)
//            
//            guard let feed else {
//                print("Document Snapshot has no data")
//                completion(.failure(.documentNotFound))
//                return
//            }
//            
//            completion(.success(feed))
//        }
//    }
    
    private func uploadImage(_ imageData: Data, withUserId id: String) async -> URL? {
        return await withUnsafeContinuation { continuation in
            let imageRef = FirebaseManager.shared.storageRef.child("feeds/\(id)/\(UUID().uuidString).jpg")
            
            imageRef.putData(imageData) { _, error in
                if let error {
                    print("Failed uploading image: \(error)")
                    continuation.resume(returning: nil)
                }
                
                imageRef.downloadURL { url, error in
                    if let error {
                        print("Failed getting url: \(error)")
                        continuation.resume(returning: nil)
                    }
                    
                    continuation.resume(returning: url)
                }
            }
        }
    }
}
