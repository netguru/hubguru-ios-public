//
//  ApiRequesterMock.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

@testable import Hubguru

class ApiRequesterMock: ApiRequester {
    var configuration: ApiClientConfiguration = ApiClientConfigurationMock()
    var oauthToken: String? = nil
}

struct ApiClientConfigurationMock: ApiClientConfiguration {
    let baseURL = URL(string: "https://fixture.com")!
    let sessionConfiguration = URLSessionConfiguration.default
}
