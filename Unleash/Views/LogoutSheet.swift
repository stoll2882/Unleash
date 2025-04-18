//
//  LogoutSheet.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//
import SwiftUI

struct LogoutSheet: View {
    
    @Binding var showingLogoutPopup: Bool
    @State var height: CGFloat
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        VStack {
            Image(systemName: "rectangle.portrait.and.arrow.right")
                .fontWeight(.bold)
                .font(.system(size: AppConfig.Styles.LogoutSheet.icon_size))
                .foregroundStyle(Color(AppConfig.Styles.Colors.main_neon_green))
                .padding()
            Text("Do you want to log out?")
                .textLightMain();
            Button("Yes") {
                do {
                    try firebaseManager.auth.signOut()
                } catch {
                    print("Error signing out")
                }
                showingLogoutPopup = false
            }
            .buttonStyle(BlockButtonStyle(isDefault: true))
            .padding()
            Button("No") {
                showingLogoutPopup = false
            }
            .buttonStyle(BlockButtonStyle())
            Spacer()
        }
        .presentationDetents([.height(height*AppConfig.Styles.LogoutSheet.height_factor)])
    }
}
