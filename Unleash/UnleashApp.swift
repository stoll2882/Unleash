//
//  UnleashApp.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import SwiftUI

@main
struct UnleashApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
