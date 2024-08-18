//
//  ProjectEditorView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 18.08.24.
//

import SwiftUI

struct ProjectEditorView: View {
    
    @Environment(\.modelContext) var modelContext;
    @Binding var project: BeamcelProject
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Edit project")
                .font(.system(size: 36, weight: .bold))
            TextField("Name", text: $project.name)
            TextField("Description", text: $project.desc)
            Spacer()
            HStack {
                ProjectActionButtonView(iconName: "x.circle", title: "Cancel", color: .accent, action: {saveProject()})
                ProjectActionButtonView(iconName: "pencil", title: "Save", color: .accent, action: {saveProject()})
            }
            
        }
        .padding()
    }
    
    func saveProject() {
        modelContext.insert(project)
        try? modelContext.save()
    }
}

#Preview {
    @State var project: BeamcelProject = BeamcelProject();
    return ProjectEditorView(project: $project)
}
