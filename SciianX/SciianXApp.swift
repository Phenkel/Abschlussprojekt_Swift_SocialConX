//
//  SciianXApp.swift
//  SciianX
//
//  Created by Philipp Henkel on 10.01.24.
//

import SwiftUI
import FirebaseCore

@main
struct SciianXApp: App {
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authenticationViewModel.user != nil {
                ContentView()
                    .environmentObject(self.authenticationViewModel)
            } else {
                LoginAndRegisterView()
                    .environmentObject(self.authenticationViewModel)
            }
        }
    }
}
