//
//  MarvelAPITests.swift
//  MarvelUITests
//
//  Created by Pablo Calcagnino on 09/04/2021.
//

import XCTest
import Combine
@testable import MarvelUI

class MarvelAPITests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        cancellables = []
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }

    func testExample() throws {
        let expectation = self.expectation(description: "Characters")
        var error: Error?
        var characters = [Character]()
        MarvelAPI().characters()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                expectation.fulfill()
            },
            receiveValue: { value in
                characters = value
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 100)
        XCTAssertNil(error)
        XCTAssertGreaterThan(characters.count, 0)
    }

}
