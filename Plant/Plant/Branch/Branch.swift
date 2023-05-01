//
//  Branch.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import SwiftUI

struct Branch: Identifiable {
    public let id: UUID = .init()
    private let timeStamp: Date = .init()

    public let start: CGPoint
    public let end: CGPoint

    public let startWidth: CGFloat
    public let endWidth: CGFloat

    private let startColor: HSB
    private let endColor: HSB

    private let rotation: CGFloat
    private let trunkDistance: Int

    public var radian: CGFloat {
        RadianCircle.radian(form: start, to: end)
    }

    private var length: CGFloat {
        RadianCircle.length(start: start, end: end)
    }

    public var colors: [Color] {
        [startColor.color, endColor.color]
    }

    public var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .init(x: start.x, y: 1 - start.y),
            endPoint: .init(x: end.x, y: 1 - end.y)
        )
    }

    init(start: CGPoint, end: CGPoint, startWidth: CGFloat, startColor: HSB, endColor: HSB, rotation: CGFloat, trunkDistance: Int) {
        self.start = start
        self.end = end
        self.startWidth = startWidth
        self.endWidth = startWidth * 0.6
        self.startColor = startColor
        self.endColor = endColor
        self.rotation = rotation
        self.trunkDistance = trunkDistance
    }

    // MARK: Next Branch ------------------------------------------

    public func nextBranch(newRotation: CGFloat, newLength: CGFloat?, settings: SettingsVM) -> Branch {
        let newLength = newLength ?? (0.16 - log(CGFloat(trunkDistance + 1)) / 17)
        let newRadian = radian - newRotation

        let newStart = end
        let newEnd = RadianCircle.endPoint(from: newStart, radian: newRadian, length: newLength)

        let newStartWidth = endWidth

        let newStartColor = endColor
        let newEndColor = startColor.nextHSB(settings: settings)

        let newTrunkDistance = trunkDistance + 1

        return Branch(start: newStart, end: newEnd, startWidth: newStartWidth, startColor: newStartColor, endColor: newEndColor, rotation: newRotation, trunkDistance: newTrunkDistance)
    }

    public func isGrowing(_ growTime: Double) -> Bool {
        abs(timeStamp.timeIntervalSinceNow) < growTime
    }

    public func isOnEdge(_ maxTrunkDistance: Double) -> Bool {
        if trunkDistance > Int(maxTrunkDistance) { return true }

        let sides = end.x <= 0 || end.x >= 1
        let top = end.y <= 0
        return sides || top
    }

    public func hasRotation(in newRotation: CGFloat) -> Bool {
        let bothLeftRotated = rotation < 0 && newRotation < 0
        let bothRightRotated = rotation > 0 && newRotation > 0
        return bothLeftRotated || bothRightRotated
    }
}

extension Branch {
    static let mock = Branch(start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: 0.5), startWidth: 10, startColor: HSB.mock, endColor: HSB.mock.nextHSB(settings: SettingsVM()), rotation: 0, trunkDistance: 0)
}
