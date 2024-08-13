//
//  RequestCollectionStory.swift
//  Beamcel
//
//  Created by Marcel Kersten on 13.08.24.
//

import Foundation
import SwiftData

@Model
final class RequestCollectionStory {
    
    let id: UUID
    var name: String
    var requests: [HttpRequest]
    
    init(name: String, requests: [HttpRequest]?) {
        id = UUID()
        self.name = name
        self.requests = requests ?? []
    }
    
}
