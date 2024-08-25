//
//  WorkbenchNavigatorView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 21.08.24.
//

import SwiftUI

struct WorkbenchNavigatorView: View {
    @Environment(\.modelContext)    var modelContext
    @Binding                        var project: BeamcelProject
    @State                          private var showStoryEditor: Bool = false
    @State                          private var selectedStory: BeamcelStory = BeamcelStory(name: "New story", desc: "", requests: .none)
    @State                          private var navigatorItems: [WorkbenchNavigatorItem] = []
    @State                          private var selectedNavigatorItem: WorkbenchNavigatorItem?
    
    var body: some View {
        List(navigatorItems, children: \.children, selection: $selectedNavigatorItem) { item in
            switch item.type {
            case .project: HStack {
                Image(systemName: "folder.fill")
                Text(item.project!.name).font(.headline)
            }.tag(item).lineLimit(1).truncationMode(.tail)
            case .story: HStack {
                Image(systemName: "book.pages")
                Text(item.story!.name)
            }.tag(item).lineLimit(1).truncationMode(.tail)
            case .httpRequest: HttpRequestListItemView(httpRequest: item.httpRequest!).tag(item)
            }
        }.sheet(isPresented: $showStoryEditor,
                onDismiss: {
                    modelContext.insert(selectedStory)
                    project.stories.append(selectedStory)
                    try? modelContext.save()
                },
                content: {
                    StoryEditorView(story: $selectedStory)
                    .frame(width: 300, height: 150)
        }).onAppear {
            let projectNavItem = WorkbenchNavigatorItem(project: project)
            navigatorItems.append(projectNavItem)
            project.stories.forEach { story in
                let navItem = WorkbenchNavigatorItem(story: story)
                story.requests.forEach { httpRequest in
                    let childNavItem = WorkbenchNavigatorItem(httpRequest: httpRequest)
                    navItem.appendChild(child: childNavItem)
                }
                navigatorItems.append(navItem)
            }
        }.contextMenu(menuItems: {
            if selectedNavigatorItem != nil {
                Button("Add request", systemImage: "plus") {
                    let httpRequest = HttpRequest(name: "Test", secure: false, method: .GET, path: "/review", host: "localhost", headers: .none)
                    let childNavItem = WorkbenchNavigatorItem(httpRequest: httpRequest)
                    selectedNavigatorItem?.appendChild(child: childNavItem)
                }
                if selectedNavigatorItem != nil && selectedNavigatorItem?.type == .httpRequest {
                    Button("Delete request", systemImage: "trash", role: .destructive) { }
                }
                Divider()
            }
            Button("Add story", systemImage: "plus") {
                addStory()
            }
            if selectedNavigatorItem != nil && selectedNavigatorItem?.type == .story {
                Button("Delete story", systemImage: "trash", role: .destructive) {
                    deleteStory()
                }
            }
        })
    }
    
    func addStory() {
        let newStory = BeamcelStory(name: "New story", desc: "", requests: [])
        modelContext.insert(newStory)
        self.project.stories.append(newStory)
        try? modelContext.save()
        let newStoryNavItem = WorkbenchNavigatorItem(story: newStory);
        self.navigatorItems.append(newStoryNavItem)
    }
    
    func deleteStory() {
        if selectedNavigatorItem?.type == .story {
            modelContext.delete(selectedNavigatorItem!.story!)
        }
    }
    
    func addHttpRequest() {
       
    }
    
    func deleteHttpRequest() {
        
    }
    
}

#Preview {
    @State var previewProject = BeamcelProject()
    return WorkbenchNavigatorView(project: $previewProject)
}
