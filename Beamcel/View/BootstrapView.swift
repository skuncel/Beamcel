//
//  BootstrapView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 15.08.24.
//

import SwiftUI

struct BootstrapView: View {
    @Environment(\.modelContext) var modelContext
    @State private var firstCollectionName: String = ""
    
    var body: some View {
        HStack {
            VStack {
                Image("product-icon")
                    .imageScale(.large)
                Text("Welcome to Beamcel")
            }
            Divider()
            VStack {
                Text("Lets create our first Collection")
                TextField("Collection name", text: $firstCollectionName)
                Button("Beam to collection") {
                    initCollectionAndOpen()
                }
            }
            .padding()
        }
    }
    
    func initCollectionAndOpen() {
        let firstCollection = RequestCollection();
        firstCollection.name = firstCollectionName;
        modelContext.insert(firstCollection)
        try? modelContext.save()
    }
}

#Preview {
    BootstrapView()
}
