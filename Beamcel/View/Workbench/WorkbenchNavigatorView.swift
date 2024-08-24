//
//  WorkbenchNavigatorView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 21.08.24.
//

import SwiftUI

struct WorkbenchNavigatorView: View {
    @Bindable var project: BeamcelProject
    
    var body: some View {
        if project.stories.isEmpty == false {
            List {
                ForEach(project.stories) { story in
                    Section("\(story.name)") {
                        ForEach(story.requests) { request in
                            HttpRequestListItemView(httpRequest: request)
                        }
                    }
                }
            }
        } else {
            VStack {
                HStack {
                    Image(systemName: "xmark.circle")
                    Text("No stories, create one:")
                }
                Button("New story") {}
            }
        }
    }
}

//#Preview {
//    WorkbenchNavigatorView()
//}
