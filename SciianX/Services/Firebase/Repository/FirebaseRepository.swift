//
//  FirebaseRepository.swift
//  SciianX
//
//  Created by Philipp Henkel on 05.03.24.
//

import Foundation
import FirebaseAuth

class FirebaseRepository {
    
    private var user: User?
    var userProfile: UserProfile?
    var allUsers: [UserProfile] = []
    
    static let shared = FirebaseRepository()
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Result<UserProfile?, FirebaseError>) -> Void) {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // AuthErrorCode.code versucht den spezifischen numerischen Error Code aus der Enumeration zu extrahieren
                // RawValue wird benötigt um den spezifischen Case zu identifizieren da AuthError.Code nicht direkt verglichen werden kann
                if let errorCode = AuthErrorCode.Code(rawValue: error._code) {
                    switch errorCode {
                    case .userNotFound:
                        print("Login failed: \(error)")
                        completion(.failure(.userNotFound))
                    case .accountExistsWithDifferentCredential:
                        print("Login failed: \(error)")
                        completion(.failure(.differentCredentials))
                    default:
                        print("Login failed: \(error)")
                        completion(.failure(.unknown))
                    }
                } else {
                    print("Login failed: \(error)")
                    completion(.failure(.unknown))
                }
                return
            }
            
            guard let authResult = authResult, let email = authResult.user.email else {
                completion(.failure(.userNotFound))
                return
            }
            
            print("User (\(email) logged in -> \(authResult.user.uid)")
            self.user = authResult.user
            
            self.fetchUserProfile(withId: authResult.user.uid) { result in
                completion(result)
            }
        }
    }
    
    func register(email: String, password: String, realName: String, userName: String, completion: @escaping (Result<UserProfile?, FirebaseError>) -> Void) {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                if let errorCode = AuthErrorCode.Code(rawValue: error._code) {
                    switch errorCode {
                    case .emailAlreadyInUse:
                        print("Register failed: \(error)")
                        completion(.failure(.emailAlreadyRegistered))
                        return
                    case .invalidEmail:
                        print("Register failed: \(error)")
                        completion(.failure(.unvalidMail))
                        return
                    default:
                        print("Register failed: \(error)")
                        completion(.failure(.unknown))
                        return
                    }
                }
            }
            
            guard let authResult, let email = authResult.user.email else {
                completion(.failure(.unknown))
                return
            }
            
            print("User (\(email)) registered -> \(authResult.user.uid)")
            self.createUserProfile(
                withId: authResult.user.uid,
                email: email,
                realName: realName,
                userName: userName
            )
            
            self.login(email: email, password: password) { result in
                completion(result)
            }
        }
    }
    
    func logout() {
        do {
            try FirebaseManager.shared.auth.signOut()
            self.user = nil
            
            print("User logged out")
        } catch {
            print("Signing out failed: \(error)")
        }
    }
    
    func checkAuth(completion: @escaping (Result<UserProfile?, FirebaseError>) -> Void) {
        guard let currentUser = FirebaseManager.shared.auth.currentUser else {
            print("No user logged in")
            completion(.failure(.noUserLoggedIn))
            return
        }
        
        self.user = currentUser
        self.fetchUserProfile(withId: currentUser.uid) { result in
            completion(result)
        }
    }
    
    private func createUserProfile(withId id: String, email: String, realName: String, userName: String) {
        let userProfile = UserProfile(
            id: id,
            email: email,
            realName: realName,
            userName: userName,
            registeredAt: Date(),
            lastActiveAt: Date()
        )
        
        do {
            try FirebaseManager.shared.firestore.collection("user").document(userProfile.id).setData(from: userProfile)
        } catch {
            print("Create user failed: \(error)")
        }
    }
    
    func fetchUserProfile(withId id: String, completion: @escaping (Result<UserProfile?, FirebaseError>) -> Void) {
        FirebaseManager.shared.firestore.collection("users").document(id).getDocument { document, error in
            if let error = error {
                print("Fetch user failed: \(error)")
                completion(.failure(.unknown))
                return
            }
            
            guard let document = document, document.exists else {
                print("Document (\(id)) not found")
                completion(.failure(.userNotFound))
                return
            }
            
            do {
                let userProfile = try document.data(as: UserProfile.self)
                completion(.success(userProfile))
            } catch {
                print("Decoding user failed: \(error)")
                completion(.failure(.unknown))
            }
        }
    }
}
