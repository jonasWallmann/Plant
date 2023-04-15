//
//  RadianTest.swift
//  PlantTests
//
//  Created by Jonas Wallmann on 10.04.23.
//

@testable import Plant

import XCTest

final class RadianTest: XCTestCase {
    func test1() throws {
        try test(x: sqrt(3) / 2, y: 0.5, expected: .pi / 6)
    }

    func test2() throws {
        try test(x: -sqrt(3) / 2, y: 0.5, expected: 5 * .pi / 6)
    }

    func test3() throws {
        try test(x: -sqrt(2) / 2, y: -sqrt(2) / 2, expected: 5 * .pi / 4)
    }

    func test4() throws {
        try test(x: sqrt(3) / 2, y: -0.5, expected: 11 * .pi / 6)
    }

    func test5() throws {
        try test(x: sqrt(2) / 2, y: -sqrt(2) / 2, expected: 7 * .pi / 4)
    }

    private func test(x: CGFloat, y: CGFloat, expected: CGFloat) throws {
        let calculated = RadianCircle.radian(form: CGPoint(x: 0, y: 0), to: CGPoint(x: x, y: y))
        XCTAssertEqual(calculated, expected, accuracy: 0.01)
    }
}

