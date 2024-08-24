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
            case .story: HStack {
                Image(systemName: "book.pages")
                Text(item.story!.name)
            }.tag(item).lineLimit(1)
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
            project.stories.forEach { story in
                let navItem = WorkbenchNavigatorItem(story: story)
                story.requests.forEach { httpRequest in
                    let childNavItem = WorkbenchNavigatorItem(httpRequest: httpRequest)
                    navItem.appendChild(child: childNavItem)
                }
                navigatorItems.append(navItem)
            }
        }
    }
}

//#Preview {
//    @Binding var project = BeamcelProject()
//    WorkbenchNavigatorView(project: BeamcelProject())
//}
