//
//  BeamcelItem.swift
//  Beamcel
//
//  Created by Marcel Kersten on 28.08.24.
//

import Foundation
import SwiftData

@Model
final class BeamcelItem {
    var name: String
    var desc: String
    var type: BeamcelItemType
    var parent: BeamcelItem?
    @Relationship(deleteRule: .cascade, inverse: \BeamcelItem.parent)
    var childs: [BeamcelItem]?
    var content: Data?
 
    init(name: String, desc: String, type: BeamcelItemType, parent: BeamcelItem? = nil, childs: [BeamcelItem]? = .none, content: Data? = .none) {
        self.name = name
        self.desc = desc
        self.type = type
        self.parent = parent
        self.childs = childs
        self.content = content
    }
    
    init(name: String, desc: String, type: BeamcelItemType, parent: BeamcelItem? = nil, childs: [BeamcelItem]? = .none, content: PersistentIdentifier) {
        self.name = name
        self.desc = desc
        self.type = type
        self.parent = parent
        self.childs = childs
        addContentRef(ref: content)
    }
    
    func addContentRef(ref: PersistentIdentifier) {
        let encoder = JSONEncoder();
        content = try? encoder.encode(ref);
    }
    
    func getContentRef() -> PersistentIdentifier? {
        let decoder = JSONDecoder();
        return try? decoder.decode(PersistentIdentifier.self, from: content!)
    }
}

enum BeamcelItemType: Codable {
    case story, httpRequest
}
