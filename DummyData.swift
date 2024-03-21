//
//  DummyData.swift
//  SciianX
//
//  Created by Philipp Henkel on 12.03.24.
//

import Foundation

var dummyFeed = Feed(
    creator: UserProfile(
        id: "Test",
        email: "Test@Mail.de",
        realName: "Test Name",
        userName: "TestUser",
        registeredAt: Date(),
        lastActiveAt: Date(),
        following: []
    ),
    text: "Random Text den ich hier habe um zu testen",
    likes: [],
    comments: [],
    createdAt: Date(),
    updatedAt: Date(),
    activeUsers: [],
    images: []
)

var dummyFeedViewModel = FeedViewModel(dummyFeed, withUser: UserProfile(
    id: "Test",
    email: "Test@Mail.de",
    realName: "Test Name",
    userName: "TestUser",
    registeredAt: Date(),
    lastActiveAt: Date(),
    following: []
))

var dummyComment = Comment(
    creator: UserProfile(
        id: "Test",
        email: "Test@Mail.de",
        realName: "Test Name",
        userName: "TestUser",
        registeredAt: Date(),
        lastActiveAt: Date(),
        following: []
    ),
    text: "Das hier ist ein random Kommentar",
    createdAt: Date()
)

var dummyCommentViewModel = CommentViewModel(dummyComment)
