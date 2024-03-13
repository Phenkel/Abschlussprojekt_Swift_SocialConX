//
//  UserProfile.swift
//  SciianX
//
//  Created by Philipp Henkel on 05.03.24.
//

import Foundation

struct UserProfile: Codable, Equatable {
    let id: String
    let email: String
    let realName: String
    let userName: String
    let registeredAt: Date
    let lastActiveAt: Date
    let following: [UserProfile]
}
