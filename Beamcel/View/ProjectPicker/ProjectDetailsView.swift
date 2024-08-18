//
//  ProjectDetailsView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 18.08.24.
//

import SwiftUI

struct ProjectDetailsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Bindable var project: BeamcelProject
    
    var body: some View {
        VStack {
            ZStack {
                if colorScheme == .dark {
                    Rectangle()
                        .frame(width: 104, height: 104)
                        .foregroundColor(.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .blur(radius: 64)
                        .opacity(0.5)
                }
                Image(nsImage: NSApp.applicationIconImage)
                    .resizable()
                    .frame(width: 128, height: 128)
            }
            Text(project.name)
                .font(.system(size: 36, weight: .bold))
            Text(project.desc)
                .textSelection(.enabled)
                .foregroundColor(.secondary)
                .font(.system(size: 13.5))
            Spacer().frame(height: 40)
            HStack {
                VStack(spacing: 8) {
                    ProjectActionButtonView(
                        iconName: "plus",
                        title: "Open project",
                        color: .accent,
                        action: {}
                    )
                    ProjectActionButtonView(
                        iconName: "pencil",
                        title: "Edit project",
                        color: .accent,
                        action: {}
                    )
                    Spacer().frame(height: 20)
                    ProjectActionButtonView(
                        iconName: "trash",
                        title: "Delete project",
                        color: .red,
                        action: {}
                    )
                }
                .frame(width: 250)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    let project = BeamcelProject()
    project.name = "Preview"
    return ProjectDetailsView(project: project)
}
