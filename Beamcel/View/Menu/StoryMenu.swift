//
//  StoryMenu.swift
//  Beamcel
//
//  Created by Marcel Kersten on 21.08.24.
//

import SwiftUI

struct StoryMenu: View {
    var body: some View {
        Menu("Story") {
            Button("New HTTP request", systemImage: "plus") {}
        }
    }
}

#Preview {
    StoryMenu()
}
