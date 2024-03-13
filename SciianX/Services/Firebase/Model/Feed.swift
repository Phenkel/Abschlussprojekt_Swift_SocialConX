//
//  Feed.swift
//  SciianX
//
//  Created by Philipp Henkel on 12.03.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Feed: Codable {
    @DocumentID var id: String?
    
    let creator: UserProfile
    let text: String
    let likes: [UserProfile]
    let comments: [Comment]
    let createdAt: Date
    let updatedAt: Date
    let activeUsers: [UserProfile]
    
}

extension Feed {
    func copy(build: (inout Builder) -> Void) -> Feed {
        var builder = Builder(feed: self)
        build(&builder)
        
        return builder.toFeed()
    }
    
    struct Builder {
        var id: String?
        var creator: UserProfile
        var text: String
        var likes: [UserProfile]
        var comments: [Comment]
        var createdAt: Date
        var updatedAt: Date
        var activeUsers: [UserProfile]
        
        fileprivate init(feed: Feed) {
            self.id = feed.id
            self.creator = feed.creator
            self.text = feed.text
            self.likes = feed.likes
            self.comments = feed.comments
            self.createdAt = feed.createdAt
            self.updatedAt = feed.updatedAt
            self.activeUsers = feed.activeUsers
        }
        
        fileprivate func toFeed() -> Feed {
            return Feed(
                id: id,
                creator: creator,
                text: text,
                likes: likes,
                comments: comments,
                createdAt: createdAt,
                updatedAt: updatedAt,
                activeUsers: activeUsers
            )
        }
    }
}
