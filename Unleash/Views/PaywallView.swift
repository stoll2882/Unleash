//
//  PaywallView.swift
//  Unleash
//
//  Created by Sam Toll on 2/6/25.
//

import SwiftUI
import StoreKit

struct PaywallView: View {
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @State private var showingError = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Color(AppConfig.Styles.Colors.main_mint_green)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // App Logo/Icon
                    Image("UnleashOrange")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(.top, 40)
                    
                    // Main headline
                    Text("Unlock All Features")
                        .font(.custom(AppConfig.Styles.Text.MainFont, size: 32))
                        .foregroundColor(AppConfig.Styles.Colors.main_dark_green)
                        .multilineTextAlignment(.center)
                    
                    Text("Start Your Fitness Journey Today")
                        .font(.custom(AppConfig.Styles.Text.LightFont, size: 18))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    // Feature list
                    VStack(alignment: .leading, spacing: 20) {
                        FeatureRow(icon: "✓", text: "Full workout programs")
                        FeatureRow(icon: "✓", text: "Exercise library with videos")
                        FeatureRow(icon: "✓", text: "Progress tracking")
                        FeatureRow(icon: "✓", text: "Custom exercise notes")
                        FeatureRow(icon: "✓", text: "Cloud sync across devices")
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                    
                    Spacer()
                    
                    // Subscription Button
                    Button(action: {
                        Task {
                            try? await subscriptionManager.purchase()
                            if subscriptionManager.errorMessage != nil {
                                showingError = true
                            }
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(AppConfig.Styles.Colors.main_orange))
                                .frame(height: 55)
                            
                            if subscriptionManager.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Subscribe Now")
                                    .font(.custom(AppConfig.Styles.Text.MainFont, size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                    .disabled(subscriptionManager.isLoading)
                    
                    // Restore Purchases
                    Button(action: {
                        Task {
                            await subscriptionManager.restorePurchases()
                            if subscriptionManager.errorMessage != nil {
                                showingError = true
                            }
                        }
                    }) {
                        Text("Restore Purchases")
                            .font(.custom(AppConfig.Styles.Text.LightFont, size: 14))
                            .foregroundColor(AppConfig.Styles.Colors.main_dark_green)
                    }
                    .padding(.bottom, 20)
                    
                    // Terms and Privacy
                    Text("Terms of Service  •  Privacy Policy")
                        .font(.custom(AppConfig.Styles.Text.LightFont, size: 12))
                        .foregroundColor(.gray)
                        .padding(.bottom, 30)
                }
            }
        }
        .alert("Purchase Error", isPresented: $showingError) {
            Button("OK", role: .cancel) {
                subscriptionManager.errorMessage = nil
            }
        } message: {
            Text(subscriptionManager.errorMessage ?? "Unknown error occurred")
        }
        .task {
            subscriptionManager.checkSubscriptionStatus()
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Text(icon)
                .font(.custom(AppConfig.Styles.Text.MainFont, size: 20))
                .foregroundColor(AppConfig.Styles.Colors.main_dark_green)
                .frame(width: 30)
            
            Text(text)
                .font(.custom(AppConfig.Styles.Text.LightFont, size: 16))
                .foregroundColor(.black)
            
            Spacer()
        }
    }
}

