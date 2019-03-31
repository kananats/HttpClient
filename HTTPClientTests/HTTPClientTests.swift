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

    func test_getUser() {
        let expectation = XCTestExpectation()
        
        _ = HttpClient.GetUser(id: 2).request().subscribe(
            onSuccess: { data in
                XCTAssert(data.data.id == 2)
                XCTAssert(data.data.first_name == "Janet")
                XCTAssert(data.data.last_name == "Weaver")
                XCTAssert(data.data.avatar == "https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg")
                expectation.fulfill()
            }
        )
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_getUsers() {
        let expectation = XCTestExpectation()
        
        _ = HttpClient.GetUsers().request().subscribe(
            onSuccess: { data in
                XCTAssert(data.page == 1)
                XCTAssert(data.per_page == 3)
                XCTAssert(data.total == 12)
                XCTAssert(data.total_pages == 4)
                XCTAssert(data.data.first!.id == 1)
                XCTAssert(data.data.first!.first_name == "George")
                XCTAssert(data.data.first!.last_name == "Bluth")
                XCTAssert(data.data.first!.avatar == "https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg")
                expectation.fulfill()
            }
        )
        
        _ = HttpClient.GetUsers(page: 3).request().subscribe(
            onSuccess: { data in
                XCTAssert(data.page == 1)
                XCTAssert(data.per_page == 3)
                XCTAssert(data.total == 12)
                XCTAssert(data.total_pages == 4)
                XCTAssert(data.data.first!.id == 1)
                XCTAssert(data.data.first!.first_name == "George")
                XCTAssert(data.data.first!.last_name == "Bluth")
                XCTAssert(data.data.first!.avatar == "https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg")
                expectation.fulfill()
            }
        )
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_postUser() {
        let expectation = XCTestExpectation()
        
        _ = HttpClient.PostUser(name: "morpheus", job: "leader").request().subscribe(
            onSuccess: { data in
                XCTAssert(data.id == "505")
                XCTAssert(data.createdAt == "2019-03-31T10:18:28.293Z")
                expectation.fulfill()
            }
        )
        
        wait(for: [expectation], timeout: 10)
    }
}
