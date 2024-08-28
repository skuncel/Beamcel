//
//  Request.swift
//  Beamcel
//
//  Created by Marcel Kersten on 13.08.24.
//

import Foundation
import SwiftData

@Model
final class HttpRequest {
    var secure: Bool
    var method: HTTPMethod
    var path: String
    var host: String
    var headers: Dictionary<String, String>?
    
    init(secure: Bool, method: HTTPMethod, path: String, host: String,
         headers: Dictionary<String, String>?) {
        self.secure = secure
        self.method = method
        self.path = path
        self.host = host
        self.headers = headers
    }
    
}

enum HTTPMethod: Codable {
    case GET, POST, PUT, DELETE
}
