//
//  SubscriptionManager.swift
//  Unleash
//
//  Created by Sam Toll on 2/6/25.
//

import Foundation
import StoreKit
import SwiftUI

@MainActor
class SubscriptionManager: ObservableObject {
    @Published var subscriptionStatus: SubscriptionStatus = .unknown
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var updateListenerTask: Task<Void, Error>?
    
    // Replace this with your actual subscription product ID from App Store Connect
    let subscriptionProductID = "com.blixli.unleash.subscription"
    
    // The group ID for your subscription - get this from App Store Connect
    let subscriptionGroupID = "com.blixli.unleash.subscription"
    
    enum SubscriptionStatus {
        case subscribed
        case notSubscribed
        case unknown
        
        var hasAccess: Bool {
            return self == .subscribed
        }
    }
    
    init() {
        updateListenerTask = listenForTransactions()
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    func checkSubscriptionStatus() {
        isLoading = true
        Task {
            await checkStatus()
        }
    }
    
    @MainActor
    func checkStatus() async {
        #if DEBUG
        // DEVELOPMENT ONLY: Allow access without subscription during development
        // Remove this when you're ready to test with real subscriptions
        if ProcessInfo.processInfo.environment["DISABLE_SUBSCRIPTION_CHECK"] == "YES" {
            print("🔓 DEV MODE: Subscription check disabled")
            subscriptionStatus = .subscribed
            isLoading = false
            return
        }
        #endif
        
        var hasActiveSubscription = false
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try await checkVerified(result)
                // Check if this is our subscription product
                if transaction.productID == subscriptionProductID {
                    hasActiveSubscription = true
                    break
                }
            } catch {
                // Transaction is not verified, skip it
                continue
            }
        }
        
        subscriptionStatus = hasActiveSubscription ? .subscribed : .notSubscribed
        isLoading = false
    }
    
    func purchase() async throws {
        isLoading = true
        errorMessage = nil
        
        print("🔍 Looking for product with ID: \(subscriptionProductID)")
        let products = try await Product.products(for: [subscriptionProductID])
        print("📦 Found products: \(products)")
        
        guard let product = products.first else {
            errorMessage = "Subscription product not found. Make sure you've created it in App Store Connect with ID: \(subscriptionProductID)"
            print("❌ Product not found. Available product IDs: \(products.map { $0.id })")
            isLoading = false
            return
        }
        
        let result = try await product.purchase()
        
        switch result {
        case .success(let verification):
            switch verification {
            case .verified(_):
                // Purchase succeeded, refresh subscription status
                await checkStatus()
            case .unverified(_, let error):
                errorMessage = "Purchase verification failed: \(error.localizedDescription)"
            }
        case .userCancelled:
            errorMessage = "Purchase cancelled"
        case .pending:
            errorMessage = "Purchase pending"
        @unknown default:
            errorMessage = "Unknown purchase result"
        }
        
        isLoading = false
    }
    
    func restorePurchases() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await AppStore.sync()
            await checkStatus()
        } catch {
            errorMessage = "Failed to restore purchases: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    private func listenForTransactions() -> Task<Void, Error> {
        return Task.detached { [weak self] in
            for await result in Transaction.updates {
                guard let self = self else { continue }
                do {
                    let transaction = try await self.checkVerified(result)
                    
                    // Handle verified transaction
                    await self.checkStatus()
                    await transaction.finish()
                } catch {
                    // Transaction is not verified
                    print("Transaction verification failed: \(error)")
                }
            }
        }
    }
    
    private func checkVerified(_ result: VerificationResult<StoreKit.Transaction>) async throws -> StoreKit.Transaction {
        switch result {
        case .unverified:
            throw SubscriptionManagerError.failedVerification
        case .verified(let transaction):
            return transaction
        }
    }
}

enum SubscriptionManagerError: Error {
    case failedVerification
}
