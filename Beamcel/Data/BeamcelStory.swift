//
//  RequestCollectionStory.swift
//  Beamcel
//
//  Created by Marcel Kersten on 13.08.24.
//

import Foundation
import SwiftData

@Model
final class BeamcelStory {
    
    @Attribute(.unique) let id: UUID
    var name: String
    var desc: String
    @Relationship(deleteRule: .cascade)
    var requests: [HttpRequest]
    
    init(name: String, desc: String, requests: [HttpRequest]?) {
        id = UUID()
        self.name = name
        self.desc = desc
        self.requests = requests ?? []
    }
    
}
