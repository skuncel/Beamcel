//
//  RequesWizardView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 17.08.24.
//

import SwiftUI

struct RequesWizardView: View {
    
    @State private var path: String = "";
    
    var body: some View {
        Text("New HTTP request").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding()
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Information").font(.subheadline)
                Divider()
                TextField("Name", text: $path)
                TextEditor(text: $path)
            }
            Divider()
            VStack(alignment: .leading) {
                Text("Configuration").font(.subheadline)
                Divider()
                HStack(alignment: .top) {
                    Picker(selection: .constant(HTTPMethod.GET), label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                        Text("GET").tag(HTTPMethod.GET)
                    }
                    .labelsHidden()
                    .scaledToFit()
                    TextField("Path", text: $path)
                }
                Picker(selection: .constant(1), label: Text("Content-type")) {
                    Text("application/json").tag(1)
                }
            }
            
        }.padding()
        Button("Save") {}.padding().scaledToFill()
    }
}

#Preview {
    RequesWizardView()
}
