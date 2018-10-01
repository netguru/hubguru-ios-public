//
// ApiRequesterExtension.swift
//
// Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxCocoa
import RxSwift

enum RequestError: Error, Equatable {
    case wrongStatusCode(Int)
}

extension ApiRequester {

	/// Allows to get API response with query.
	///
	/// - Returns: Observable Data
	func response(query: Query) -> Observable<(HTTPURLResponse, Data)> {
		let request = query.request(baseURL: configuration.baseURL)
		let session = URLSession(configuration: configuration.sessionConfiguration)
		return Observable.create { observer in
			return session.rx.response(request: request).subscribe(onNext: { (response, data) in
				if 200 ..< 300 ~= response.statusCode {
					observer.onNext((response, data))
				} else {
					observer.onError(RequestError.wrongStatusCode(response.statusCode))
				}
			}, onError: { error in
				observer.onError(error)
			}, onCompleted: nil, onDisposed: nil)
		}
	}

	/// Create an obervable that sends a result of performing a request for the
	/// given `query` and maps the response to `JSON`.
	///
	/// - Parameters:
	///     - query: A query of the request.
	///
	/// - Returns: An observable of `JSON` response.
	func jsonResponse(for query: Query) -> Observable<(response: HTTPURLResponse, json: JSON)> {
		return response(query: query).map {
			let json: JSON?
			do {
				json = try JSON(data: $0.1)
			} catch let error {
				throw error
			}
			
			return (response: $0.0, json: json!)
		}
	}

}
