//
//  PageableProviderSpec.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

@testable import Hubguru
import OHHTTPStubs
import RxSwift
import XCTest

class PageableProviderSpec: XCTestCase {
    
    var sut: PageableProvider!
    var disposeBag = DisposeBag()
    
    override func setUp() {
        sut = PageableProvider(apiRequester: ApiRequesterMock())
    }
    
    func testPageResponses() {
        let pagesExpectation = expectation(description: "waiting to load load all pages")
        let query = QueryMock()
        let fixtureData = "{\"fixture\" : \"fixture\"}".data(using: .utf8)!
        
        stub(condition: { $0.url?.absoluteString == "https://fixture.com/fixture?" }) { _ in
            OHHTTPStubsResponse(data: fixtureData, statusCode: 200, headers: ["Link" : "<https://fixture.com/fixture?page=2>; rel=\"next\", <https://fixture.com/fixture?page=3>; rel=\"last\""])
        }
        
        stub(condition: { $0.url?.absoluteString == "https://fixture.com/fixture?page=2" }) { _ in
			OHHTTPStubsResponse(data: fixtureData, statusCode: 200, headers: ["Link" : "<https://fixture.com/fixture?page=1>; rel=\"prev\", <https://fixture.com/fixture?page=3>; rel=\"next\", <https://fixture.com/fixture?page=3>; rel=\"last\""])
        }
        
        stub(condition: { $0.url?.absoluteString == "https://fixture.com/fixture?page=3" }) { _ in
			OHHTTPStubsResponse(data: fixtureData, statusCode: 200, headers: ["Link" : "<https://fixture.com/fixture?page=1>; rel=\"prev\", <https://fixture.com/fixture?page=1>; rel=\"first\""])
        }

		sut.nextPageFor(query: query, type: ModelMock.self) // first page
			.flatMap { _ in self.sut.nextPageFor(query: query, type: ModelMock.self) } // second page
			.flatMap { _ in self.sut.nextPageFor(query: query, type: ModelMock.self) } // third, last page
			.flatMap { _ in self.sut.nextPageFor(query: query, type: ModelMock.self) } // fourth page, non-existstent
			.subscribe(onError: { error in
				XCTAssert(error as! PageableProviderError == PageableProviderError.lastPageReached, "Proper error should be returned")
				pagesExpectation.fulfill()
			})
			.disposed(by: disposeBag)

        waitForExpectations(timeout: 1) { _ in }
    }
}
