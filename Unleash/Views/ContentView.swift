//
//  ContentView.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import SwiftUI
import CoreData
import AuthenticationServices
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    @EnvironmentObject var appDataStore: AppDataStorage
    @StateObject var authManager: AuthManager = AuthManager()
    
    var body: some View {
        VStack {
            if authManager.isLoaded {
                MainWelcomeView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            authManager.startListening(appDataStore: appDataStore, firebaseManager: firebaseManager)
        }
        .onDisappear {
            authManager.stopListening()
        }
    }
}

class AuthManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var isLoaded = false
    @Published var user: User?
    var appDataStore: AppDataStorage? = nil
    var firebaseManager: FirebaseManager? = nil
    
    private var handle: AuthStateDidChangeListenerHandle?

    func startListening(appDataStore: AppDataStorage, firebaseManager: FirebaseManager) {
        self.appDataStore = appDataStore
        self.firebaseManager = firebaseManager
        handle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            DispatchQueue.main.async {
                if let listener = self {
                    if user == nil {
                        listener.isLoggedIn = false
                        listener.isLoaded = false
                    } else {
                        listener.isLoggedIn = true
                        listener.user = user
                        if listener.isLoggedIn && !listener.isLoaded {
                            listener.appDataStore!.setupApplication(firebaseManger: firebaseManager);
                            listener.isLoaded = true
                        }
                    }
                }
            }
        }
    }

    func stopListening() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
