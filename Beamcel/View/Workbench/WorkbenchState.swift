//
//  WorkbenchState.swift
//  Beamcel
//
//  Created by Marcel Kersten on 22.08.24.
//

import Foundation

@Observable
class WorkbenchState {
    let openedProject: BeamcelProject
    var selectedStory: BeamcelStory? = .none
    var selectedHttpRequest: HttpRequest? = .none
    
    var storyEditorOpened = false
    
    init(openedProject: BeamcelProject) {
        self.openedProject = openedProject
    }
}
