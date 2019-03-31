//
//  HTTPClientTests.swift
//  HTTPClientTests
//
//  Created by Kananat Suwanviwatana on 2019/03/30.
//  Copyright © 2019 Kananat Suwanviwatana. All rights reserved.
//

import XCTest
@testable import HTTPClient

final class HTTPClientTests: XCTestCase {

    override func setUp() {
        endpoint = MockEndpoint()
    }

    func test_getUsers() {
        _ = HttpClient.GetUsers(page: 3).request().subscribe(
            onSuccess: { response in
                XCTAssert(response.data.first!.first_name == "George")
            },
            onError: { error in
            }
        )
    }
}
