//
//  iOSFinalProjectApp.swift
//  iOSFinalProject
//
//  Created by Akira Hanada on 2025/09/10.
//

import SwiftUI

@main
struct iOSFinalProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
