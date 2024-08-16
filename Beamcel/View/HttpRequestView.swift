//
//  HttpRequestView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 15.08.24.
//

import SwiftUI

struct HttpRequestView: View {
    @Bindable var httpRequest: HttpRequest
    
    var body: some View {
        VStack {
            HStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            Grid {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }
        
    }
}

#Preview {
    let previewHttpRequest = HttpRequest(name: "Test", secure: true, method: HTTPMethod.GET, path: "/test", host: "localhost", headers: Optional.none)
    return HttpRequestView(httpRequest: previewHttpRequest)
}
