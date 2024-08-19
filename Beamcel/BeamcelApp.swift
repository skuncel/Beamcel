//
//  BeamcelApp.swift
//  Beamcel
//
//  Created by Marcel Kersten on 13.08.24.
//

import SwiftUI
import SwiftData

@main
struct BeamcelApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            BeamcelProject.self,
            BeamcelStory.self,
            HttpRequest.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        Group {
            ProjectPickerScene()
        }
        .modelContainer(sharedModelContainer)
        
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
        
        WindowGroup(for: BeamcelProject.ID.self) { $collectionId in
            if let undwrappedCollectionId = collectionId {
                let collection = sharedModelContainer.mainContext.model(for: undwrappedCollectionId) as? BeamcelProject
                if let unwrappedCollection = collection {
                    CollectionView(collection: unwrappedCollection)
                }
            }
        }
    }
}
