//
//  ContentView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 13.08.24.
//

import SwiftUI
import SwiftData

struct CollectionView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var collection: RequestCollection
    @State private var selectedStory: RequestCollectionStory?
    
    var body: some View {
        NavigationSplitView {
            Picker("Story", selection: $selectedStory) {
                Text("No story, create one").tag(RequestCollectionStory?.none)
                ForEach(collection.stories ?? []) { story in
                    Text(story.name).tag(story as RequestCollectionStory?)
                }
            }.labelsHidden().padding(.horizontal)
            Spacer()
            List {
                ForEach(selectedStory?.requests ?? []) { request in
                    NavigationLink {
                        Text("\(request.name)")
                    } label: {
                        Text(request.name)
                    }
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Menu {
                        Button(action: createRequest) {
                            Label("New Request", systemImage: "antenna.radiowaves.left.and.right")
                        }
                        Button(action: createRequest) {
                            Label("New Story", systemImage: "book.pages")
                        }
                    } label: {
                        Label("New", systemImage: "plus")
                    }
                    
                }
            }
        } detail: {
            Text("Select an request from the side menu")
        }
    }

    private func createRequest() {
        withAnimation {
            let newRequest = HttpRequest(name: "test", secure: false, method: HTTPMethod.GET, path: "", host: "", headers: Optional.none)
            modelContext.insert(newRequest)
        }
    }
}

#Preview {
    CollectionView(collection: RequestCollection())
        .modelContainer(for: [RequestCollection.self,
                              RequestCollectionStory.self,
                              HttpRequest.self],
                        inMemory: true)
}
