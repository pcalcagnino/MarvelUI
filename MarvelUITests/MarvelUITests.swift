//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Pablo Calcagnino on 08/04/2021.
//

import XCTest
import Combine
@testable import MarvelUI

class MarvelUITests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let expectation = self.expectation(description: "api call")
        MarvelAPI().characters()
            .print()
            .sink(receiveCompletion: {
                print($0)
                expectation.fulfill()
            },
            receiveValue: {
                print($0)
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 10)
    }

}
