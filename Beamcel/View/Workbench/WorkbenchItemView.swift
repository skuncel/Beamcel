//
//  WorkbenchItemView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 28.08.24.
//

import SwiftUI

struct WorkbenchItemView: View {
    @Binding var item: BeamcelItem?
    
    var body: some View {
        if let unwrappedItem = item {
            Text("Item: \(unwrappedItem.name) | Type: \(unwrappedItem.type)")
        } else {
            Text("No item selected")
        }
    }
}
