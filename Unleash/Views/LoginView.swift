//
//  LoginView.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct LoginView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var errMsg: String = ""
    
    @State var selectedView = 0
    @EnvironmentObject var firebaseManager: FirebaseManager
    @EnvironmentObject var appDataStore: AppDataStorage
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("UnleashNoBackground")
                    .resizable()
                    .frame(width: geometry.size.width, height: 90)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding(.top, 50)
                Picker(selection: $selectedView, label: Text("Picker")) {
                    Text("Login").tag(0)
                    Text("Register").tag(1)
                }.pickerStyle(.segmented)
                    .padding(50)
                
                VStack {
                    if selectedView == 0 {
                        Text("Login")
                    } else {
                        Text("Register")
                    }
                    TextField("Enter an email", text: $email).textFieldStyle(.roundedBorder)
                    if selectedView == 1 {
                        TextField("Enter your name", text: $name).textFieldStyle(.roundedBorder)
                    }
                    SecureField(
                        "Enter a password",
                        text: $password)
                    .padding(.bottom,20).textFieldStyle(.roundedBorder)
                    Text(errMsg).foregroundStyle(Color.red)
                    Button {
                        if selectedView == 0 {
                            if let loginStatus = appDataStore.loginUser(firebaseManager: firebaseManager, email: email, password: password) {
                                errMsg = loginStatus
                            }
                        } else {
                            if let registerStatus = appDataStore.registerUser(firebaseManager: firebaseManager, email: email, password: password, name: name) {
                                errMsg = registerStatus
                            }
                        }
                    } label: {
                        Text("Submit")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(AppConfig.Styles.Colors.main_orange)) // Button color
                            .cornerRadius(10)
                    }
                }
                
                
                Spacer()
            }
        }
        .padding(20)
            .ignoresSafeArea()
            .background(Color(AppConfig.Styles.Colors.main_mint_green))
    }
    
    private func storeUserInformation() {
        guard let uid = firebaseManager.auth.currentUser?.uid else {
            return
        }
        let userData = ["email": self.email, "uid": uid, "name": self.name]
        Firestore.firestore().collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
            }
    }
}

