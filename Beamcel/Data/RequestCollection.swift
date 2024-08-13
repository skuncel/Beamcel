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
    var name: String;
    var stories: [RequestCollectionStory];
    
    init(name: String, stories: [RequestCollectionStory]?) {
        id = UUID()
        self.name = name
        self.stories = stories ?? []
    }
    
}
