//
//  _048Tests.swift
//  2048Tests
//
//  Created by Alex Luna on 29/07/2020.
//

import XCTest
@testable import Twenty48
// swiftlint:disable type_name
class Twenty48Tests: XCTestCase {

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
}
