//
//  WorkbenchScene.swift
//  Beamcel
//
//  Created by Marcel Kersten on 20.08.24.
//

import SwiftUI
import SwiftData

struct WorkbenchScene: Scene {
    @Environment(\.modelContext) var modelContext;
    
    var body: some Scene {
        WindowGroup("Beamcel", for: BeamcelProject.ID.self) { $projectId in
            if let unwrappedProjectId = projectId {
                let queriedProject = modelContext.model(for: unwrappedProjectId) as! BeamcelProject
                WorkbenchView(openedProject: queriedProject)
            }
        }
    }
    
    struct WorkbenchView: View {
        @State var openedProject: BeamcelProject

        var body: some View {
            NavigationSplitView() {
                WorkbenchNavigatorView(project: $openedProject)
                .toolbar {
                    ToolbarItemGroup {
                        VStack {
                            Button(action: {}) {
                                Label("Run", systemImage: "play.fill")
                            }
                        }
                    }
                }
            } detail: {
                Text("Project: \(openedProject.name)")
            }
        }
    }
}

#Preview {
    WorkbenchScene.WorkbenchView(openedProject: BeamcelProject())
}
