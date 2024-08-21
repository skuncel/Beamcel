//
//  ProjectMenu.swift
//  Beamcel
//
//  Created by Marcel Kersten on 21.08.24.
//

import SwiftUI

struct ProjectMenu: View {
    var body: some View {
        Menu("Project") {
            Button("New Story", systemImage: "plus") {}
        }
    }
}

#Preview {
    ProjectMenu()
}
