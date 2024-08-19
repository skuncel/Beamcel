//
//  SettingsScene.swift
//  Beamcel
//
//  Created by Marcel Kersten on 19.08.24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralSettingsView()
            .tabItem {
                Label("General", systemImage: "gear")
            }
            HttpClientSettingsView()
            .tabItem {
                Label("HTTP Client", systemImage: "network")
            }
        }
        .scenePadding()
        .frame(width: 500, height: 400)
    }
}

#Preview {
    SettingsView()
}
