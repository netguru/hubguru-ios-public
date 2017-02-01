//
//  QueryExtension.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

extension Query {
    
    func request(baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        return request
    }
    
    static func parametersFromQueryString(query: String) -> [String : String] {
        var parameters = [String : String]()
        for item in query.components(separatedBy: "&") {
            let components = item.components(separatedBy: "=")
            if components.count == 2 {
                parameters[components[0]] = components[1]
            }
        }
        return parameters
    }

}
