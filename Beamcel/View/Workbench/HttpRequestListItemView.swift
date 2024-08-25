//
//  HttpRequestListItemView.swift
//  Beamcel
//
//  Created by Marcel Kersten on 21.08.24.
//

import SwiftUI

struct HttpRequestListItemView: View {
    @Bindable var httpRequest: HttpRequest
    
    var body: some View {
        HStack() {
            Label("GET", systemImage: "").labelStyle(PaddedBackgroundLabelStyle(httpMethod: $httpRequest.method))
            VStack {
                VStack(alignment: .leading) {
                    Text(httpRequest.name ?? httpRequest.path)
                        .foregroundColor(.primary)
                        .font(.system(size: 12, weight: .semibold))
                        .lineLimit(1)
                        .truncationMode(.head)
                }
            }
        }
    }
    
    struct PaddedBackgroundLabelStyle: LabelStyle {
        @Binding var httpMethod: HTTPMethod;
        
        func makeBody(configuration: Configuration) -> some View {
            let color: Color = switch httpMethod {
                case(.GET): Color(red: 0.38, green: 0.686, blue: 0.996, opacity: 1.0)
                case(.POST): Color(red: 0.286, green: 0.8, blue: 0.565, opacity: 1.0)
                case(.PUT): Color(red: 0.988, green: 0.631, blue: 0.188, opacity: 1.0)
                case(.DELETE): Color(red: 0.976, green: 0.243, blue: 0.243, opacity: 1.0)
            }
            Label(configuration)
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.white)
                .labelStyle(.titleOnly)
                .padding(2.5)
                .background(color)
                .cornerRadius(5)
        }
    }
}

#Preview {
    let httpRequest = HttpRequest(name: "Preview", secure: false, method: .GET, path: "/preview", host: "localhost", headers: .none)
    return HttpRequestListItemView(httpRequest: httpRequest)
}
