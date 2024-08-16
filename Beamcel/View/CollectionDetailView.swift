//
//  CollectionDetailView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 16.08.24.
//

import SwiftUI
import Logging

struct CollectionDetailView: View {
    
    let log = Logger(label: "CollectionDetailView")
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.openWindow) private var openWindow
    
    @Bindable var collection: RequestCollection
    
    var body: some View {
        VStack {
            Text(collection.name)
                .bold()
            Button("Open") {
                openCollection(collection: collection)
            }
            Button("Delete") {
                deleteCollection(collection: collection)
            }
        }
        
    }
    
    func openCollection(collection: RequestCollection) {
        openWindow(value: collection.id)
    }
    
    func deleteCollection(collection: RequestCollection) {
        log.info("Deleting: \(collection.id)")
        modelContext.delete(collection);
        try? modelContext.save()
    }
}

#Preview {
    CollectionDetailView(collection: RequestCollection())
}
