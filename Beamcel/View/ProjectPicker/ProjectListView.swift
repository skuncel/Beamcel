//
//  ChooseExistingProjectView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 18.08.24.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
    
    @Binding var existingProjects: [BeamcelProject]
    @Binding var projectSelection: BeamcelProject?
    
    var body: some View {
        VStack(alignment: .leading) {
            List(selection: $projectSelection) {
                Text("Projects")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 10)
                ForEach(existingProjects, id: \.self) { project in
                        ProjectListItemView(project: project)
                }
            }
            .listStyle(.sidebar)
        }
    }
}

#Preview {
    @State var existingProjects: [BeamcelProject] = [BeamcelProject()]
    @State var projectSelection: BeamcelProject?
    return ProjectListView(existingProjects: $existingProjects, projectSelection: $projectSelection)
}
