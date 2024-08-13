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
    
    let id: UUID
    var name: String;
    var stories: OrderedSet<RequestCollectionStory>;
    
    init(name: String, stories: OrderedSet<RequestCollectionStory>?) {
        id = UUID()
        self.name = name
        self.stories = stories ?? OrderedSet()
    }
    
}
