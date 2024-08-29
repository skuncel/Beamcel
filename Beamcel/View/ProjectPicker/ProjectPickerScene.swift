//
//  ProjectPickerScene.swift
//  Beamcel
//
//  Created by Marcel Kersten on 17.08.24.
//

import SwiftUI
import SwiftData

struct ProjectPickerScene: Scene {
    public let sceneId: String = "project-picker"
    @Query let projects: [BeamcelProject]
    
    var body: some Scene {
        Window("Beamcel projects", id: sceneId) {
            ProjectPickerView(existingProjects: projects)
                .frame(width: 740, height: 432)
                .task {
                    if let window = NSApp.windows.first(where: { $0.identifier?.rawValue == sceneId }) {
                        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                        window.standardWindowButton(.zoomButton)?.isHidden = true
                        window.isMovableByWindowBackground = true
                    }
                }
            }
            .windowStyle(.hiddenTitleBar)
            .windowResizability(.contentSize)
        }
    
    struct ProjectPickerView: View {
        @Environment(\.modelContext) var modelContext;
        @State var projectEditorSheetShown = false
        @State var existingProjects: [BeamcelProject]
        @State var selectedProject: BeamcelProject?
        
        var body: some View {
            HStack {
                ProjectListView(existingProjects: $existingProjects, projectSelection: $selectedProject)
                if let unwrappedSelectedProject = selectedProject {
                    ProjectDetailsView(project: unwrappedSelectedProject, projectEditorSheetShown: $projectEditorSheetShown)
                        .frame(width: 480)
                } else {
                    NoProjectChoosenView(projectEditorSheetShown: $projectEditorSheetShown)
                        .frame(width: 480)
                }
            }
            .sheet(isPresented: $projectEditorSheetShown,
                   onDismiss: saveSelectedProject) {
                ProjectEditorView(project: $selectedProject)
            }
        }
        
        func saveSelectedProject() {
            if let unwrappedProject = selectedProject {
                modelContext.insert(unwrappedProject);
                try? modelContext.save();
            }
        }
        
    }
}

#Preview {
    @State var projects = [BeamcelProject()]
    return ProjectPickerScene.ProjectPickerView(existingProjects: projects)
}
