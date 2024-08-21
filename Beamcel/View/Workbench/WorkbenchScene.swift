//
//  WorkbenchScene.swift
//  Beamcel
//
//  Created by Marcel Kersten on 20.08.24.
//

import SwiftUI
import SwiftData

struct WorkbenchScene: Scene {
    var body: some Scene {
        WindowGroup("Beamcel", for: BeamcelProject.ID.self) { $projectId in
            if let unwrappedProjectId = projectId {
                WorkbenchView(projectId: unwrappedProjectId)
            }
        }
    }
    
    struct WorkbenchView: View {
        
        @Environment(\.modelContext) var modelContext
        private let projectId: PersistentIdentifier
        @State var project: BeamcelProject?
        
        init(projectId: PersistentIdentifier) {
            self.projectId = projectId
        }
        
        var body: some View {
            NavigationSplitView() {
                WorkbenchNavigatorView(project: project)
                .toolbar {
                    ToolbarItemGroup {
                        VStack {
                            Button(action: {}) {
                                Label("Run", systemImage: "play.fill")
                            }
                        }
                    }
                }
                .contextMenu(ContextMenu(menuItems: {
                    ProjectMenu()
                    StoryMenu()
                }))
            } detail: {
                Text("Project: \(project?.name ?? "unavailable")")
            }.onAppear {
                project = modelContext.model(for: projectId) as? BeamcelProject
            }
        }
    }
}

//#Preview {
//    @Environment(\.modelContext) var modelContext;
//    @State var project = BeamcelProject();
//    modelContext.insert(project);
//    return WorkbenchScene.WorkbenchView(projectId: project.id)
//}
