//
//  ProjectEditorView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 18.08.24.
//

import SwiftUI

struct ProjectEditorView: View {
    @Environment(\.dismiss) var dismiss;
    @Binding var project: BeamcelProject?
    
    @State var projectName = "";
    @State var projectDesc = "";
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $projectName)
                TextEditor(text: $projectDesc)
            }.padding()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Edit story")
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    withAnimation {
                        if let unwrappedProject = project {
                            unwrappedProject.name = projectName
                            unwrappedProject.desc = projectDesc
                            dismiss()
                        } else {
                            let newProject = BeamcelProject();
                            newProject.name = projectName;
                            newProject.desc = projectDesc;
                            project = newProject;
                        }
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
        }.onAppear {
            if let unwrappedProject = project {
                projectName = unwrappedProject.name;
                projectDesc = unwrappedProject.desc;
            }
        }
    }
}

//#Preview {
//    @State var project: BeamcelProject = BeamcelProject();
//    return ProjectEditorView(project: $project)
//}
