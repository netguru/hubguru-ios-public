//
//  WebLinkParserSpec.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import XCTest

@testable import Hubguru

class WebLinkParserSpec: XCTestCase {
    
    func testParsingProperLinks() {
        let linksString = "<https://fixture.com/fixture?page=2>; rel=\"next\", <https://fixture.com/fixture?page=123>; rel=\"last\""
        let links = WebLinkParser.parse(string: linksString)
        let next = WebLink(urlString: "https://fixture.com/fixture?page=2", relation: .next)
        let last = WebLink(urlString: "https://fixture.com/fixture?page=123", relation: .last)
        
        XCTAssert(links.contains { $0 == next }, "Next link should be parsed correctly")
        
        XCTAssert(links.contains { $0 == last }, "Last link should be parsed correctly")
    }
    
    func testParsingBrokenRelation() {
        let linksString = "<https://fixture.com/fixture?page=2>; rel=\"ccc\""
        let links = WebLinkParser.parse(string: linksString)
        let other = WebLink(urlString: "https://fixture.com/fixture?page=2", relation: .other)
        XCTAssert(links.contains { $0 == other }, "Other link should be parsed correctly")
    }
    
    func testParsingBrokenString() {
        let links = WebLinkParser.parse(string: "")
        XCTAssert(links.count == 0, "Parser should return no links")
    }
}
