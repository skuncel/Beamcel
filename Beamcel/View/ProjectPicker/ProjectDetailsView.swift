//
//  ProjectDetailsView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 18.08.24.
//

import SwiftUI

struct ProjectDetailsView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismiss) var dismiss
    @Bindable var project: BeamcelProject
    @Binding var projectEditorSheetShown: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: 104, height: 104)
                    .foregroundColor(.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .blur(radius: 64)
                    .opacity(colorScheme == .dark ? 0.5 : 1)
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
                        iconName: "folder",
                        title: "Open project",
                        color: .teal,
                        action: {
                            openWindow(value: project.id)
                            dismiss()
                        }
                    )
                    ProjectActionButtonView(
                        iconName: "pencil",
                        title: "Edit project",
                        color: .teal,
                        action: { projectEditorSheetShown.toggle() }
                    )
                    Spacer().frame(height: 20)
                    ProjectActionButtonView(
                        iconName: "trash",
                        title: "Delete project",
                        color: .red,
                        action: { 
                            modelContext.delete(project)
                            try? modelContext.save()
                        }
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
    @State var previewBool = false;
    return ProjectDetailsView(project: project, projectEditorSheetShown: $previewBool)
}
