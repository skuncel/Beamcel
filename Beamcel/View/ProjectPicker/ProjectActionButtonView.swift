//
//  ProjectActionButtonView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 18.08.24.
//

import SwiftUI

struct ProjectActionButtonView: View {
    var iconName: String
    var title: String
    var color: Color
    var action: () -> Void

    init(iconName: String, title: String, color: Color, action: @escaping () -> Void) {
        self.iconName = iconName
        self.title = title
        self.color = color
        self.action = action
    }
    
    var body: some View {
        Button(action: action, label: {
                    HStack(spacing: 7) {
                        Image(systemName: iconName)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.secondary)
                            .font(.system(size: 20))
                            .frame(width: 24)
                            .padding(.vertical)
                        Text(title)
                            .font(.system(size: 13, weight: .semibold))
                            .padding(.leading, 5)
                            .padding(.vertical)
                        Spacer()
                    }
                })
                .buttonStyle(ProjectActionButtonStyle(color))
    }
    
    struct ProjectActionButtonStyle: ButtonStyle {
        var color: Color
        
        init(_ color: Color) {
            self.color = color
        }
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .contentShape(Rectangle())
                .padding(7)
                .frame(height: 36)
                .background(color.opacity(configuration.isPressed ? 0.5 : 0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    enum ProjectActionButtoColor {
        case primary, secondary, none
    }
}

#Preview {
    ProjectActionButtonView(iconName: "plus",title: "Test", color: .accent, action: {})
}
