//
//  StoryEditorView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 22.08.24.
//

import SwiftUI

struct StoryEditorView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding                var story: BeamcelItem
    @State                  private var storyName = "New story"
    @State                  private var storyDesc = "Description"
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $storyName)
                TextEditor(text: $storyDesc)
            }.padding()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Edit story")
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    withAnimation {
                        story.name = storyName
                        story.desc = storyDesc
                        dismiss()
                    }
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    withAnimation {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    @State var story = BeamcelItem(name: "Preview", desc: "Preview", type: .story)
    return StoryEditorView(story: $story)
}
