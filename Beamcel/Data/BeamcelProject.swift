//
//  Collection.swift
//  Beamcel
//
//  Created by Marcel Kersten on 13.08.24.
//

import Foundation
import SwiftData

@Model
final class BeamcelProject {
    var name: String
    var desc: String
    @Relationship(deleteRule: .cascade)
    var items: [BeamcelItem]
    
    init() {
        self.name = "New project"
        self.desc = ""
        self.items = []
    }
    
}
