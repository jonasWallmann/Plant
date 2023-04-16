//
//  Branch.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import SwiftUI

struct Branch: Identifiable, Shape {
    public let id: UUID = .init()
    private let timeStamp: Date = .init()

    public let start: CGPoint
    public let end: CGPoint

    private let startColor: HSB
    private let endColor: HSB

    private let rotation: CGFloat
    public let trunkDistance: Int

    public var isOnEdge: Bool {
        if trunkDistance > 6 { return true }

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

    init(start: CGPoint, end: CGPoint, startColor: HSB, rotation: CGFloat, trunkDistance: Int, settings: SettingsVM) {
        self.start = start
        self.end = end
        self.startColor = startColor
        self.endColor = startColor.nextHSB(settings: settings)
        self.rotation = rotation
        self.trunkDistance = trunkDistance
    }

    // MARK: Next Branch ------------------------------------------

    public func nextBranch(rotation: CGFloat, length: CGFloat?, settings: SettingsVM) -> Branch {
        let newLength = length ?? (0.16 - log(CGFloat(trunkDistance + 1)) / 17)
        let newStart = end
        let newRadian = radian - rotation
        let newEnd = RadianCircle.endPoint(from: newStart, radian: newRadian, length: newLength)
        let newStartColor = endColor

        return Branch(start: newStart, end: newEnd, startColor: newStartColor, rotation: rotation, trunkDistance: trunkDistance + 1, settings: settings)
    }

    public func isGrowing(_ growTime: Double) -> Bool {
        abs(timeStamp.timeIntervalSinceNow) < growTime
    }

    // MARK: Path -------------------------------------------

    public func path(in rect: CGRect) -> Path {
        Path { path in
            let startX = start.x * rect.maxX
            let startY = (1 - start.y) * rect.maxY

            let endX = end.x * rect.maxX
            let endY = (1 - end.y) * rect.maxY

            let startPoint = CGPoint(x: startX, y: startY)
            let endPoint = CGPoint(x: endX, y: endY)

            path.move(to: startPoint)
            path.addLine(to: endPoint)
        }
    }

    public func hasRotation(in newRotation: CGFloat) -> Bool {
        let bothLeftRotated = rotation < 0 && newRotation < 0
        let bothRightRotated = rotation > 0 && newRotation > 0
        return bothLeftRotated || bothRightRotated
    }
}

extension Branch {
    static let mock = Branch(start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: 0.5), startColor: HSB.mock, rotation: 0, trunkDistance: 0, settings: SettingsVM())
}
