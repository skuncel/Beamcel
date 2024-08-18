//
//  ExistingProjectListItemView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 18.08.24.
//

import SwiftUI

struct ProjectListItemView: View {
    
    @Bindable var project: BeamcelProject
    
    var body: some View {
            HStack(spacing: 8) {
                Image(systemName: "doc")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                VStack(alignment: .leading) {
                    Text(project.name)
                        .foregroundColor(.primary)
                        .font(.system(size: 13, weight: .semibold))
                        .lineLimit(1)
                    Text(project.desc)
                        .foregroundColor(.secondary)
                        .font(.system(size: 11))
                        .lineLimit(1)
                        .truncationMode(.head)
                }
            }
            .frame(height: 36)
            .contentShape(Rectangle())
        }
}

#Preview {
    let project = BeamcelProject()
    project.name = "Preview"
    return ProjectListItemView(project: project)
}
