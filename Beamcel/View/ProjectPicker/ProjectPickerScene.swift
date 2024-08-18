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
            .sheet(isPresented: $projectEditorSheetShown) {
                HStack {
                    Button("Cancel") { projectEditorSheetShown.toggle() }
                        .backgroundStyle(.windowBackground)
                    Spacer()
                    Button("Save") { }
                        .backgroundStyle(.windowBackground)
                }.padding()
                if let unwrappedSelectedProject = selectedProject {
                    @State var project = unwrappedSelectedProject;
                    ProjectEditorView(project: $project as Binding<BeamcelProject>)
                        .frame(width: 500, height: 250)
                } else {
                    @State var newProject = BeamcelProject();
                    ProjectEditorView(project: $newProject)
                        .frame(width: 500, height: 250)
                }
            }
        }
    }
}
