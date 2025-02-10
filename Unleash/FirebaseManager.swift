//
//  FirebaseManager.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseCore

class FirebaseManager: NSObject, ObservableObject {

    let auth: Auth
    let storage: Storage
    let firestore: Firestore

    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()

        super.init()
    }
}
