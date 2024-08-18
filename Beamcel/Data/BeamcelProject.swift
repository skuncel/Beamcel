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
    var stories: [BeamcelStory]
    
    init() {
        self.name = "Default name"
        self.desc = "Default description"
        self.stories = []
    }
    
}
