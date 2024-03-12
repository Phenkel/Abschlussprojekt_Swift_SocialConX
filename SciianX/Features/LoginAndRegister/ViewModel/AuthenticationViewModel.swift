//
//  AuthenticationViewModel.swift
//  SciianX
//
//  Created by Philipp Henkel on 11.03.24.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    
    @Published var user: UserProfile?
    @Published var errorMessage: String = "testestest"
    
    private var mailCheckRepository = MailCheckRepository.shared
    private var firebaseRepository = FirebaseRepository.shared
    
    init() {
        firebaseRepository.checkAuth() { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func login(mail: String, password: String) {
        self.errorMessage = ""
        
        firebaseRepository.login(email: mail, password: password) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    @MainActor
    func register(mail: String, password: String, passwordConfirm: String, realName: String, userName: String) {
        self.errorMessage = ""
        
        guard !mail.isEmpty, !password.isEmpty, !passwordConfirm.isEmpty, !realName.isEmpty, !userName.isEmpty else {
            self.errorMessage = "Please fill every field."
            return
        }
        
        guard password == passwordConfirm else {
            self.errorMessage = "Passwords don't match."
            return
        }
        
        let passwordRegex = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#$%^&+=])(?=\\S+$).{6,}$"
        guard password.range(of: passwordRegex, options: .regularExpression) != nil else {
            self.errorMessage = """
            Password need 6 characters
            Password need 1 letter
            Password need 1 number
            Password need 1 special character
            """
            return
        }
        
        Task {
            do {
                let mailCheck = try await mailCheckRepository.checkEmail(mail)
                
                if mailCheck.valid, !mailCheck.block, !mailCheck.disposable, !mailCheck.emailForwarder {
                    firebaseRepository.register(email: mail, password: password, realName: realName, userName: userName) { result in
                        switch result {
                        case .success(let user):
                            self.user = user
                        case .failure(let error):
                            self.errorMessage = error.localizedDescription
                        }
                    }
                } else {
                    self.errorMessage = mailCheck.text
                }
            } catch {
                self.errorMessage = "Could not validate eMail"
                print("Failed validating email: \(error)")
            }
        }
    }
}
