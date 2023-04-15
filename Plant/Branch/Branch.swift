//
//  Branch.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import SwiftUI

struct Branch: Identifiable, Equatable, Shape {
    public let id: UUID = .init()
    private let timeStamp: Date = .init()

    public let start: CGPoint
    public let end: CGPoint

    private let rotation: CGFloat
    public let trunkDistance: Int

    public var isOnEdge: Bool {
        if trunkDistance > 8 { return true }

        let sides = end.x <= 0 || end.x >= 1
        let top = end.y <= 0

        return sides || top
    }

    private var radian: CGFloat {
        RadianCircle.radian(form: start, to: end)
    }

    private var length: CGFloat {
        RadianCircle.length(start: start, end: end)
    }

    init(start: CGPoint, end: CGPoint, rotation: CGFloat, trunkDistance: Int) {
        self.start = start
        self.end = end
        self.rotation = rotation
        self.trunkDistance = trunkDistance
    }

    // MARK: Next Branch ------------------------------------------

    public func nextBranch(rotation: CGFloat, length: CGFloat?) -> Branch {
        let newLength = length ?? (0.16 - log(CGFloat(trunkDistance + 1)) / 17)
        let newStart = end
        let newRadian = radian - rotation
        let newEnd = RadianCircle.endPoint(from: newStart, radian: newRadian, length: newLength)

        return Branch(start: newStart, end: newEnd, rotation: rotation, trunkDistance: trunkDistance + 1)
    }

    public func isGrowing(_ growTime: Double) -> Bool {
        abs(timeStamp.timeIntervalSinceNow) < growTime
    }

    // MARK: Path -------------------------------------------

    public func path(in rect: CGRect) -> Path {
        Path { path in
            let startX = start.x * rect.maxX
            let startY = 1 * rect.maxY - start.y * rect.maxX
            let endX = end.x * rect.maxX
            let endY = 1 * rect.maxY - end.y * rect.maxX

            let startPoint = CGPoint(x: startX, y: startY)
            let endPoint = CGPoint(x: endX, y: endY)

            path.move(to: startPoint)
            path.addLine(to: endPoint)
        }
    }

    public func hasRotation(in newRotation: CGFloat) -> Bool {
        let bothLeftRotated = rotation <= 0 && newRotation <= 0
        let bothRightRotated = rotation >= 0 && newRotation >= 0
        return bothLeftRotated || bothRightRotated
    }
}

extension Branch {
    static let mock = Branch(start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: 0.5), rotation: 0, trunkDistance: 0)
}
