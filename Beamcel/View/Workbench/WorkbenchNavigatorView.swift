//
//  WorkbenchNavigatorView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 21.08.24.
//

import SwiftUI
import SwiftData
import OrderedCollections

struct WorkbenchNavigatorView: View {
    @Environment(\.modelContext)    var modelContext
    @Binding                        var project: BeamcelProject
    @Binding                        var selectedItem : BeamcelItem?;
    @State                          private var showStoryEditor: Bool = false
    
    var body: some View {
        @State var projectItems = project.items;
        List(projectItems, children: \.childs, selection: $selectedItem) { item in
            switch item.type {
            case .story: HStack {
                Image(systemName: "book.pages")
                Text(item.name)
            }.tag(item).lineLimit(1).truncationMode(.tail)
            case .httpRequest: HttpRequestListItemView(httpRequestId: item.getContentRef()!).tag(item)
            }
        }.sheet(isPresented: $showStoryEditor,
                onDismiss: {
                    modelContext.insert(selectedItem!)
                    project.items.append(selectedItem!)
                    try? modelContext.save()
                },
                content: {
                    Text("Test")
        }).contextMenu(menuItems: {
            if(selectedItem?.type == .story) {
                Button("Add request", systemImage: "plus") {
                    addHttpRequest()
                }
            }
            if(selectedItem?.type == .httpRequest) {
                Button("Delete request", systemImage: "trash", role: .destructive) {
                    deleteHttpRequest()
                }
            }
            Divider()
            Button("Add story", systemImage: "plus") {
                addStory()
            }
            if(selectedItem?.type == .story) {
                Button("Delete story", systemImage: "trash", role: .destructive) {
                        deleteStory()
                }
            }
        })
    }
    
    func addStory() {
        let newStory = BeamcelItem(name: "New story", desc: "", type: .story)
        modelContext.insert(newStory)
        self.project.items.append(newStory)
        try? modelContext.save()
    }
    
    func deleteStory() {
        //modelContext.delete(selectedItem!)
        selectedItem = nil
        try? modelContext.save()
    }
    
    func addHttpRequest() {
        let httpRequest = HttpRequest(secure: true, method: .GET, path: "/path", host: "localhost", headers: .none)
        modelContext.insert(httpRequest);
        try! modelContext.save()
        let newRequestItem = BeamcelItem(name: "New request", desc: "", type: .httpRequest)
        newRequestItem.addContentRef(ref: httpRequest.id)
        modelContext.insert(newRequestItem)
        selectedItem?.childs?.append(newRequestItem);
        try! modelContext.save()
    }
    
    func deleteHttpRequest() {
        modelContext.delete(selectedItem!)
        selectedItem = selectedItem?.parent;
        try? modelContext.save()
    }
    
}
