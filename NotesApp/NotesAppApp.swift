//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by Aditya Raj on 26/10/25.
//

import SwiftUI
import CoreData

@main
struct NotesAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
