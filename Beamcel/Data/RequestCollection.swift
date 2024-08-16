//
//  Collection.swift
//  Beamcel
//
//  Created by Marcel Kersten on 13.08.24.
//

import Foundation
import SwiftData
import OrderedCollections

@Model
final class RequestCollection {
    
    var name: String
    var stories: [RequestCollectionStory]
    
    init() {
        self.name = "Default"
        self.stories = []
    }
    
}
