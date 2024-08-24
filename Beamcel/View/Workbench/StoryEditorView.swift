//
//  StoryEditorView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 22.08.24.
//

import SwiftUI

struct StoryEditorView: View {
    
    @Environment(\.dismiss)         private var dismiss
    @Environment(\.modelContext)    private var modelContext
    @Binding                        var story: BeamcelStory
    
    var body: some View {
        Text("Edit story")
            .font(.largeTitle)
        Form {
            TextField("Name", text: $story.name)
            TextField("Description", text: $story.desc)
        }.formStyle(.grouped)
        HStack {
            Button("Cancel") {
                dismiss()
            }
            Button("Save") {
                try? modelContext.save()
            }
        }
        .padding()
    }
}

#Preview {
    @State var story = BeamcelStory(name: "Preview", desc: "Preview", requests: .none)
    return StoryEditorView(story: $story)
}
