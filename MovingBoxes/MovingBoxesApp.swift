//
//  MovingBoxesApp.swift
//  MovingBoxes
//
//  Created by Hatim Hoho on 7/2/2023.
//

import SwiftUI

@main
struct MovingBoxesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
