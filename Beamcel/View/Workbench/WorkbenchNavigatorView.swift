//
//  WorkbenchNavigatorView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 21.08.24.
//

import SwiftUI

struct WorkbenchNavigatorView: View {
    
    @State var project: BeamcelProject?
    
    var body: some View {
        if let unwrappedProject = project {
            if unwrappedProject.stories.isEmpty == false {
                List {
                    ForEach(project!.stories) { story in
                        Section("\(story.name)") {
                            ForEach(story.requests) { request in
                                HttpRequestListItemView(httpRequest: request)
                            }
                        }
                    }
                }
            } else {
                HStack {
                    Image(systemName: "xmark.circle")
                    Text("No stories")
                }
            }
        }
    }
}

//#Preview {
//    WorkbenchNavigatorView()
//}
