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
        @State var selectedItem: BeamcelItem?

        var body: some View {
            NavigationSplitView() {
                WorkbenchNavigatorView(project: $openedProject, selectedItem: $selectedItem)
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
                WorkbenchItemView(item: $selectedItem)
            }
        }
    }
}

#Preview {
    WorkbenchScene.WorkbenchView(openedProject: BeamcelProject())
}
