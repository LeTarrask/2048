//
//  _048Tests.swift
//  2048Tests
//
//  Created by Alex Luna on 29/07/2020.
//

import XCTest
@testable import _048
// swiftlint:disable type_name
class _048Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testBoardCreation() throws {
        let engine = GameEngine()
        let allTileValues = engine.board.grid.flatMap { $0 }.map { $0.value }
        XCTAssertEqual(allTileValues.count, 16, "There are 16 tiles on the standard board")

        XCTAssertEqual(allTileValues.filter {$0 == 2}.count, 1, "There is 1 tile with value 2")

        XCTAssertEqual(allTileValues.filter {$0 == 0}.count, 15, "There is 15 tiles with value 0")
    }

    func testTransformLine() throws {
        let engine = GameEngine()

        XCTAssertEqual(engine.transformArray(array: [2, 0, 4, 0]), [2, 4, 0, 0])
        XCTAssertEqual(engine.transformArray(array: [0, 4, 0, 8]), [4, 8, 0, 0])
        XCTAssertEqual(engine.transformArray(array: [8, 0, 2, 2]), [8, 4, 0, 0])
        XCTAssertEqual(engine.transformArray(array: [2, 2, 2, 2]), [4, 4, 0, 0])
        XCTAssertEqual(engine.transformArray(array: [2, 0, 4, 0]), [2, 4, 0, 0])
        XCTAssertEqual(engine.transformArray(array: [0, 2, 2, 0]), [4, 0, 0, 0])
        XCTAssertEqual(engine.transformArray(array: [2, 2, 2, 8]), [4, 2, 8, 0])
        XCTAssertEqual(engine.transformArray(array: [256, 256, 2, 4]), [512, 2, 4, 0])
        XCTAssertEqual(engine.transformArray(array: [2, 0, 2, 0]), [4, 0, 0, 0])
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
