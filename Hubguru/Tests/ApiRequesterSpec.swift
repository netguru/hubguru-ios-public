//
//  ApiRequesterSpec.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import XCTest
import RxSwift
import OHHTTPStubs

@testable import Hubguru

class ApiRequesterSpec: XCTestCase {
    
    var sut: ApiRequesterMock!
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        sut = ApiRequesterMock()
    }
    
    func testProperDataResponse() {

        let stubObject = stub(condition: isHost(sut.configuration.baseURL.host!)) { _ in
            OHHTTPStubsResponse(data: "fixture".data(using: .utf8)!, statusCode: 200, headers: nil)
        }

        let responseExpectation = expectation(description: "waiting for mocked response")

        sut.response(query: QueryMock())
			.subscribe(onNext: { value in
				XCTAssertEqual(String(data: value.1, encoding: .utf8), "fixture", "Response data should be correct")
				responseExpectation.fulfill()
			})
			.disposed(by: disposeBag)

        waitForExpectations(timeout: 10) { _ in
            OHHTTPStubs.removeStub(stubObject)
        }

    }

	func testProperJSONResponse() {

		let stubObject = stub(condition: isHost(sut.configuration.baseURL.host!)) { _ in
			OHHTTPStubsResponse(data: "{\"foo\":[\"bar\",1,true]}".data(using: .utf8)!, statusCode: 200, headers: nil)
		}

		let responseExpectation = expectation(description: "waiting for mocked response")

		sut.jsonResponse(for: QueryMock())
			.subscribe(onNext: { value in
				XCTAssertEqual(value.json.dictionaryObject! as NSDictionary, ["foo": ["bar", 1, true]] as NSDictionary, "Response json should be corretly parsed")
				responseExpectation.fulfill()
			})
			.disposed(by: disposeBag)

		waitForExpectations(timeout: 10) { _ in
			OHHTTPStubs.removeStub(stubObject)
		}

	}

    func testWrongStatusCodeReturned() {
        let stubObject = stub(condition: isHost(sut.configuration.baseURL.host!)) { _ in
            return OHHTTPStubsResponse(data: "fixture".data(using: .utf8)!, statusCode: 400, headers: nil)
        }
        let responseExpectation = expectation(description: "waiting for mocked response")
        
        sut.response(query: QueryMock()).subscribe(onNext: { _ in }, onError: { error in
            XCTAssert((error as! RequestError) == RequestError.wrongStatusCode(400), "Proper status code should be returned")
            responseExpectation.fulfill()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 1) { _ in
            OHHTTPStubs.removeStub(stubObject)
        }
    }
}
