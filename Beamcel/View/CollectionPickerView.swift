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
    @State private var isCreateCollectionPopoverPresented: Bool = false
    @State private var newCollectionName: String = ""
    
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
                        isCreateCollectionPopoverPresented = true
                    }.popover(isPresented: $isCreateCollectionPopoverPresented, arrowEdge: .bottom) {
                        VStack {
                            TextField("Collection name", text: $newCollectionName)
                                .padding(.bottom)
                            Button("Create collection") {
                                let newCollection = RequestCollection()
                                newCollection.name = newCollectionName
                                modelContext.insert(newCollection)
                                try? modelContext.save()
                                newCollectionName = ""
                                isCreateCollectionPopoverPresented = false
                            }
                        }
                        .padding()
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
