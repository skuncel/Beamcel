//
//  WorkbenchNavigatorItem.swift
//  Beamcel
//
//  Created by Marcel Kersten on 24.08.24.
//

import Foundation

@Observable
class WorkbenchNavigatorItem: Identifiable, Hashable {
    let uuid = UUID()
    let type: WorkbenchNavigatorItemType
    let story: BeamcelStory?
    let httpRequest: HttpRequest?
    var children: [WorkbenchNavigatorItem]?
    
    
    init(story: BeamcelStory) {
        self.story = story
        type = .story
        httpRequest = .none
    }
    
    init(httpRequest: HttpRequest) {
        self.httpRequest = httpRequest
        type = .httpRequest
        story = .none
    }
    
    func appendChild(child: WorkbenchNavigatorItem) {
        if self.children == nil {
            self.children = []
        }
        self.children?.append(child)
    }
    
    func hash(into hasher: inout Hasher) {
        switch type {
        case .story:
            hasher.combine(story!)
        case .httpRequest:
            hasher.combine(httpRequest!)
        }
    }
    
    static func == (lhs: WorkbenchNavigatorItem, rhs: WorkbenchNavigatorItem) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

enum WorkbenchNavigatorItemType {
    case story, httpRequest
}
