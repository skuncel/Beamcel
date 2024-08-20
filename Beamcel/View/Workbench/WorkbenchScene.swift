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
                
            } detail: {
                Text("Project: \(project?.name ?? "unavailable")")
            }.onAppear {
                project = modelContext.model(for: projectId) as? BeamcelProject
            }
        }
    }
}

//#Preview {
//    WorkbenchScene.WorkbenchView()
//}
