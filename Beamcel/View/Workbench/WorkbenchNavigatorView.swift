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
    
    var body: some View {
        List {
            if project.stories.isEmpty == false {
                ForEach(project.stories) { story in
                    Section("\(story.name)") {
                        ForEach(story.requests) { request in
                            HttpRequestListItemView(httpRequest: request)
                        }
                    }
                }
            } else {
                VStack {
                    Image(systemName: "xmark.circle")
                    Text("No stories, create one:")
                    Button("New story") {
                        showStoryEditor.toggle()
                    }
                }
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
        })
    }
}

//#Preview {
//    @Binding var project = BeamcelProject()
//    WorkbenchNavigatorView(project: BeamcelProject())
//}
