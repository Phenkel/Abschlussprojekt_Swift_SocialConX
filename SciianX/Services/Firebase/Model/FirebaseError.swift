//
//  FirebaseError.swift
//  SciianX
//
//  Created by Philipp Henkel on 11.03.24.
//

import Foundation

enum FirebaseError: Error, LocalizedError {
    case userNotFound
    case differentCredentials
    case emailAlreadyRegistered
    case unvalidMail
    case noUserLoggedIn
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .userNotFound:
            return "User not found"
        case .differentCredentials:
            return "Mail and Password are not matching"
        case .emailAlreadyRegistered:
            return "A user with this email already exists."
        case .unvalidMail:
            return "Email is unvalid."
        case .noUserLoggedIn:
            return "No user logged in"
        case .unknown:
            return "An unknown error occured. Please try again later or contact support if the error persists"
        }
    }
}
