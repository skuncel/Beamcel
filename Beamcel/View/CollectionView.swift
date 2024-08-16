//
//  CollectionView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 13.08.24.
//

import SwiftUI
import SwiftData
import Logging

struct CollectionView: View {
    
    private let log = Logger(label: "CollectionView")
    
    @Environment(\.modelContext) private var modelContext
    @Bindable var collection: RequestCollection
    
    @State private var selectedStory: RequestCollectionStory?
    @State private var selectedRequest: HttpRequest?
    @State private var isCreateStorySheetPresented = false
    @State private var newStoryName = ""
    
    var body: some View {
        NavigationSplitView {
            Picker("Story", selection: $selectedStory) {
                if(collection.stories.isEmpty) {
                    Text("No story, create one").tag(RequestCollectionStory?.none)
                } else {
                    ForEach(collection.stories) { story in
                        Text(story.name).tag(story as RequestCollectionStory?)
                    }
                }
            }.labelsHidden().padding(.horizontal)
            Spacer()
            List(selectedStory?.requests ?? [], id: \.self, selection: $selectedRequest) { request in
                NavigationLink {
                    HttpRequestView(httpRequest: request)
                } label: {
                    Text(request.name)
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Menu {
                        Button(action: createRequest) {
                            Label("New Request", systemImage: "antenna.radiowaves.left.and.right")
                        }
                        Button("New Story") {
                            isCreateStorySheetPresented = true
                        }.sheet(isPresented: $isCreateStorySheetPresented) {
                            log.info("Opening create tory sheet")
                        } content: {
                            VStack {
                                TextField("Story name", text: $newStoryName)
                                    .padding(.bottom)
                                Button("Create story") {
                                    let newCollection = RequestCollection()
                                    newCollection.name = newStoryName
                                    modelContext.insert(newCollection)
                                    try? modelContext.save()
                                    newStoryName = ""
                                    isCreateStorySheetPresented = false
                                }
                            }
                            .padding()
                        }
                    } label: {
                        Label("New", systemImage: "plus")
                    }
                    
                }
            }
        } detail: {
            if let request = selectedRequest {
                HttpRequestView(httpRequest: request)
            } else {
                Text("Select an request from the side menu")
            }
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
    let previewHttpRequest = HttpRequest(name: "Test", secure: true, method: HTTPMethod.GET, path: "/test", host: "localhost", headers: Optional.none)
    let previewRequestCollectionStory = RequestCollectionStory(name: "Preview story", requests: [previewHttpRequest])
    let previewRequestCollection = RequestCollection()
    previewRequestCollection.stories.append(previewRequestCollectionStory)
    return CollectionView(collection: RequestCollection())
}
