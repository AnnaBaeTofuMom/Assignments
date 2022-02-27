//
//  Endpoint.swift
//  Brandi01
//
//  Created by 경원이 on 2022/02/24.
//

import Foundation

enum Endpoint {
    case request
}

extension Endpoint {
    var url: URL {
        switch self {
        case .request: return .makeEndPoint("v2/search/image")
            
        }
        
    }
}

extension URL {
    static let baseURL = "https://dapi.kakao.com/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
        
    }
}
