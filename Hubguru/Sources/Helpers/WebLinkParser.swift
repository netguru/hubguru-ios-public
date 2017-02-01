//
//  WebLinkParser.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

enum LinkRelation: String {
    case next
    case prev
    case first
    case last
    case other
}

struct WebLink: Equatable {
    let urlString: String
    let relation: LinkRelation
    
    public static func ==(lhs: WebLink, rhs: WebLink) -> Bool {
        return lhs.relation == rhs.relation && lhs.urlString == rhs.urlString
    }
}

/// Use this class to parse Web Links (RFC5988)
class WebLinkParser {
    
    /// Parses whole Link string send as header in http response
    /// into array of WebLinks
    /// - Returns: Array of WebLinks
    class func parse(string: String) -> [WebLink] {
        var links = [WebLink]()
        let separated = string.components(separatedBy: ",")
        for one in separated {
            guard let start = one.range(of:"<"), let end = one.range(of:">") else {
                break
            }
            let path = one[start.upperBound..<end.lowerBound]
            
            guard let startRelationship = one.range(of:"rel=\""), let endRelationship = one.range(of:"\"", options: .backwards) else {
                break
            }
            let relationship = one[startRelationship.upperBound..<endRelationship.lowerBound]
            if let relation = LinkRelation.init(rawValue: relationship) {
                links.append(WebLink(urlString: path, relation: relation))
            } else {
                links.append(WebLink(urlString: path, relation: .other))
            }
        }
        
        return links
    }
}
