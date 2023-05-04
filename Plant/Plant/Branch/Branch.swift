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

    public let start: UnitPoint
    public let end: UnitPoint

    public let startWidth: CGFloat
    public let endWidth: CGFloat

    private let startColor: HSB
    private let endColor: HSB

    private let rotation: CGFloat
    private let trunkDistance: Int

    private let geo: GeometryProxy?

    public let previousRadian: CGFloat

    public var radian: CGFloat {
        return RadianCircle.radian(from: start, to: end)
    }

    public var direction: DirectionEnum {
        return rotation < 0 ? .left : .right
    }

    public var colors: [Color] {
        guard let start = startColor.color,
              let end = endColor.color
        else { return [.indigo] }

        return [start, end]
    }

    public var gradient: LinearGradient {
        guard let geo = geo else { return LinearGradient(colors: colors, startPoint: .bottom, endPoint: .top) }

        let ratio = geo.size.width / geo.size.height

        let adjustedStartY = start.y * ratio
        let adjustedEndY = end.y * ratio

        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .init(x: start.x, y: adjustedStartY),
            endPoint: .init(x: end.x, y: adjustedEndY)
        )
    }

    init(start: UnitPoint, end: UnitPoint, startWidth: CGFloat, endWidth: CGFloat, startColor: HSB, endColor: HSB, rotation: CGFloat, trunkDistance: Int, previousRadian: CGFloat, geo: GeometryProxy?) {
        self.start = start
        self.end = end
        self.startWidth = startWidth
        self.endWidth = endWidth
        self.startColor = startColor
        self.endColor = endColor
        self.rotation = rotation
        self.trunkDistance = trunkDistance
        self.previousRadian = previousRadian
        self.geo = geo
    }

    // MARK: Next Branch ------------------------------------------

    public func nextBranch(newRotation: CGFloat, newLength: CGFloat?, settings: SettingsVM, geo: GeometryProxy) -> Branch {
        let newLength = newLength ?? (0.16 - log(CGFloat(trunkDistance + 1)) / 17)
        let newRadian = radian - newRotation

        let newStart = UnitPoint(x: end.x, y: end.y)
        let newEnd = RadianCircle.endPoint(from: newStart, radian: newRadian, length: newLength)

        let newTrunkDistance = trunkDistance + 1

        let newStartWidth = settings.getThickness(newTrunkDistance)
        let newEndWidth = settings.getThickness(newTrunkDistance + 1)

        let newStartColor = endColor
        let newEndColor = newStartColor.nextHSB(settings: settings)

        return Branch(start: newStart, end: newEnd, startWidth: newStartWidth, endWidth: newEndWidth, startColor: newStartColor, endColor: newEndColor, rotation: newRotation, trunkDistance: newTrunkDistance, previousRadian: radian, geo: geo)
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
    static let mock = Branch(start: UnitPoint(x: 0.5, y: 1), end: UnitPoint(x: 0.5, y: 0.5), startWidth: 10, endWidth: 8, startColor: HSB.mock, endColor: HSB.mock.nextHSB(settings: SettingsVM()), rotation: 0, trunkDistance: 0, previousRadian: .pi / 2, geo: nil)
}
