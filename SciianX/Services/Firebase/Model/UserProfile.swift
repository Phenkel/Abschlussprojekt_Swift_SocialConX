//
//  UserProfile.swift
//  SciianX
//
//  Created by Philipp Henkel on 05.03.24.
//

import Foundation

struct UserProfile: Codable {
    var id: String
    var email: String
    var realName: String
    var userName: String
    var registeredAt: Date
    var lastActiveAt: Date
}
