//
//  EndPointTest.swift
//  PlantTests
//
//  Created by Jonas Wallmann on 10.04.23.
//

@testable import Plant

import XCTest

final class EndPointTest: XCTestCase {
    func test1() throws {
        try test(radian: .pi / 6, x: sqrt(3) / 2, y: -0.5)
    }

    func test2() throws {
        try test(radian: 5 * .pi / 6, x: -sqrt(3) / 2, y: -0.5)
    }

    func test3() throws {
        try test(radian: 5 * .pi / 4, x: -sqrt(2) / 2, y: sqrt(2) / 2)
    }

    func test4() throws {
        try test(radian: 11 * .pi / 6, x: sqrt(3) / 2, y: 0.5)
    }

    func test5() throws {
        try test(radian: -(2 * .pi - .pi / 6), x: sqrt(3) / 2, y: -0.5)
    }

    private func test(radian: CGFloat, x: CGFloat, y: CGFloat) throws {
        let end: CGPoint = RadianCircle.endPoint(from: CGPoint(x: 0, y: 0), radian: radian, length: 1)
        XCTAssertEqual(end.x, x, accuracy: 0.1)
        XCTAssertEqual(end.y, y, accuracy: 0.1)
    }
}

