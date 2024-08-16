//
//  CollectionPickerView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 15.08.24.
//

import SwiftUI
import SwiftData

struct CollectionPickerView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var collections: [RequestCollection]
    @State private var selectedCollection: RequestCollection?
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Image("product-icon")
                    .imageScale(.small)
                Text("Collections")
                    .bold()
            }
            .padding(.vertical)
            List(collections, selection: $selectedCollection) { collection in
                NavigationLink {
                    CollectionDetailView(collection: collection)
                } label: {
                    Text(collection.name)
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button("Add collection", systemImage: "plus") {
                        
                    }
                }
            }
        } detail: {
            Text("Select a collection from the side menu")
        }
    }
}

#Preview {
    CollectionPickerView()
}
