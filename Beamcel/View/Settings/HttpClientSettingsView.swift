//
//  HttpClientSettingsView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 19.08.24.
//

import SwiftUI

struct HttpClientSettingsView: View, HttpClientSettings {
    
    @AppStorage("validateTlsCerts") private var validateTlsCerts = true
    @AppStorage("storeCookies") private var storeCookies = false
    @AppStorage("followRedirects") private var followRedirects = false
    
    var body: some View {
        Form {
            Section("Security") {
                Toggle("Validate TLS certificates", isOn: $validateTlsCerts)
            }
            Section("Response handling") {
                Toggle("Store cookies", isOn: $storeCookies)
                Toggle("Follow redirects", isOn: $followRedirects)
            }
        }.formStyle(.grouped)
    }
}

#Preview {
    HttpClientSettingsView()
}
