//
//  ContentView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 13.08.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var requests: [HttpRequest]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(requests) { request in
                    NavigationLink {
                        Text("\(request.name)")
                    } label: {
                        Text(request.name)
                    }
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: createRequest) {
                        Label("New Request", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func createRequest() {
        withAnimation {
            let newRequest = HttpRequest(name: "test", secure: false, method: HTTPMethod.GET, path: "", host: "", headers: Optional.none)
            modelContext.insert(newRequest)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: HttpRequest.self, inMemory: true)
}
