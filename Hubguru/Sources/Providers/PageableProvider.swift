//
//  PageableProvider.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

enum PageableProviderError: Error, Equatable {
    case responseError
    case lastPageReached
    case pageableUrlBroken
    
    static func ==(lhs: PageableProviderError, rhs: PageableProviderError) -> Bool {
        switch (lhs, rhs) {
        case (.responseError, .responseError):
            return true
        case (.lastPageReached, .lastPageReached):
            return true
        case (.pageableUrlBroken, .pageableUrlBroken):
            return true
        default:
            return false
        }
    }
}

class PageableProvider {
    
    let apiRequester: ApiRequester
    fileprivate let disposeBag = DisposeBag()
    fileprivate var nextPages = [String : String]()
    fileprivate var lastPages = [String : String]()
    fileprivate var lastDownloadedLink: String? = nil
    
    init(apiRequester: ApiRequester) {
        self.apiRequester = apiRequester
    }
    
    func nextPageFor<T: ExpressibleByJSON>(query: Query, type: T.Type) -> Observable<[T]> {
        return Observable.create { [unowned self] observer in
            let properQuery: Query
            if let nextLink = self.nextPages[query.path], let lastLink = self.lastPages[query.path] {
                if lastLink != self.lastDownloadedLink {
                    if let url = URL(string: nextLink), let query = url.query {
                        properQuery = PageableQuery(path: url.path, queryString: query)
                    } else {
                        observer.onError(PageableProviderError.pageableUrlBroken)
                        return Disposables.create()
                    }
                } else {
                    observer.onError(PageableProviderError.lastPageReached)
                    return Disposables.create()
                }
            } else {
                properQuery = query
            }
            return self.apiRequester.jsonResponse(for: properQuery).subscribe(
				onNext: { value in
					let items = value.json["items"].array?.map { T(json: $0) } ?? []
					if let links = value.response.allHeaderFields["Link"] as? String {
						if let nextLink = (WebLinkParser.parse(string: links).filter{ return $0.relation == .next }).first {
							self.nextPages[query.path] = nextLink.urlString
						}
						if let lastLink = (WebLinkParser.parse(string: links).filter{ return $0.relation == .last }).first {
							self.lastPages[query.path] = lastLink.urlString
						}
					} else {
						self.nextPages[query.path] = query.path
						self.lastPages[query.path] = query.path
					}
					self.lastDownloadedLink = value.response.url?.absoluteString
					observer.onNext(items)
					observer.onCompleted()
				},
				onError: { observer.onError($0) },
				onCompleted: { observer.onCompleted() }
			)
        }
    }
}

fileprivate struct PageableQuery: Query {
    let type = RequestType.get
    let parameters: [String: String]
    let path: String
    
    init(path: String, queryString: String) {
        self.path = path
        self.parameters = PageableQuery.parametersFromQueryString(query: queryString)
    }
    
}
