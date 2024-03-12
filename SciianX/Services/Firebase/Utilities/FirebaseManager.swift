//
//  FirebaseManager.swift
//  SciianX
//
//  Created by Philipp Henkel on 05.03.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    
    var auth = Auth.auth()
    var firestore = Firestore.firestore()
    
    static let shared = FirebaseManager()
    
    private init() {}
}
