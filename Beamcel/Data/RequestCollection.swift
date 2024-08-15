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
    
    @Attribute(.unique) let id: UUID
    var name: String
    var stories: [RequestCollectionStory]?
    
    init() {
        id = UUID()
        self.name = "Default"
        self.stories = Optional.none
    }
    
}
