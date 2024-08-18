//
//  CreateNewProjectView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 18.08.24.
//

import SwiftUI

struct NoProjectChoosenView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var projectEditorSheetShown: Bool
    
    private var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }

    private var appBuild: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }

    private var appVersionPostfix: String {
        Bundle.main.object(forInfoDictionaryKey: "CE_VERSION_POSTFIX") as? String ?? ""
    }
    
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
            Text("Beamcel")
                .font(.system(size: 36, weight: .bold))
            Text(String(
                format: NSLocalizedString("Version %@%@ (%@)", comment: ""),
                appVersion,
                appVersionPostfix,
                appBuild
                )
            )
            .textSelection(.enabled)
            .foregroundColor(.secondary)
            .font(.system(size: 13.5))
            Spacer().frame(height: 40)
            HStack {
                VStack(spacing: 8) {
                    ProjectActionButtonView(
                        iconName: "plus",
                        title: "Create new project",
                        color: .accent,
                        action: {projectEditorSheetShown.toggle()}
                    )
                    ProjectActionButtonView(
                        iconName: "folder",
                        title: "Import project",
                        color: .primary,
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
    @State var sheetShown = false;
    return NoProjectChoosenView(projectEditorSheetShown: $sheetShown)
}
