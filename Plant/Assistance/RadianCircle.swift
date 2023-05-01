//
//  RadianCircle.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import Foundation

class RadianCircle {
    static func radian(from start: CGPoint, to end: CGPoint) -> CGFloat {
        return absoluteRadian(from: start, to: end).truncatingRemainder(dividingBy: 2 * .pi)
    }

    static func absoluteRadian(from start: CGPoint, to end: CGPoint) -> CGFloat {
        let width = width(start: start, end: end)
        let height = height(start: start, end: end)

        // corners
        if start.x < end.x && start.y > end.y {
            return atan(height / width)
        }
        if start.x > end.x && start.y > end.y {
            return atan(width / height) + .pi * 0.5
        }
        if start.x > end.x && start.y < end.y {
            return atan(height / width) + .pi
        }
        if start.x < end.x && start.y < end.y {
            return atan(width / height) + .pi * 1.5
        }

        // axes
        if start.x < end.x && start.y == end.y {
            return 0
        }
        if start.x == end.x && start.y > end.y {
            return .pi * 0.5
        }
        if start.x > end.x && start.y == end.y {
            return .pi
        }
        if start.x == end.x && start.y < end.y {
            return .pi * 1.5
        }
        return .pi * 0.5
    }

    public static func endPoint(from start: CGPoint, radian: CGFloat, length: CGFloat) -> CGPoint {
        var radian: CGFloat = radian.truncatingRemainder(dividingBy: 2 * .pi)

        if radian < 0 {
            radian = .pi * 2 + radian
        }

        // corners
        if radian > 0 && radian < .pi * 0.5 {
            let angle = radian
            let width = cos(angle) * length
            let height = sin(angle) * length
            return CGPoint(x: start.x + width, y: start.y - height)
        }
        if radian > .pi * 0.5 && radian < .pi {
            let angle = radian - .pi * 0.5
            let width = sin(angle) * length
            let height = cos(angle) * length
            return CGPoint(x: start.x - width, y: start.y - height)
        }
        if radian > .pi && radian < .pi * 1.5 {
            let angle = radian - .pi
            let width = cos(angle) * length
            let height = sin(angle) * length
            return CGPoint(x: start.x - width, y: start.y + height)
        }
        if radian > .pi * 1.5 && (radian < 0 || radian < .pi * 2) {
            let angle = radian - .pi * 1.5
            let width = sin(angle) * length
            let height = cos(angle) * length
            return CGPoint(x: start.x + width, y: start.y + height)
        }

        // axes
        if radian == 0 || radian == .pi * 2 {
            return CGPoint(x: start.x + length, y: start.y)
        }
        if radian == .pi * 0.5 {
            return CGPoint(x: start.x, y: start.y - length)
        }
        if radian == .pi {
            return CGPoint(x: start.x - length, y: start.y)
        }
        if radian == .pi * 1.5 {
            return CGPoint(x: start.x, y: start.y + length)
        }
        return CGPoint(x: start.x + length, y: start.y)
    }

    public static func widthPoint(from point: CGPoint, width: CGFloat, direction: DirectionEnum, radian: CGFloat) -> CGPoint {
        let adjustment = direction == .left ? CGFloat.pi / 2 : -CGFloat.pi / 2
        let newRadian = radian + adjustment

        return endPoint(from: point, radian: newRadian, length: width)
    }

    public static func point(from point: CGPoint, in rect: CGRect) -> CGPoint {
        return CGPoint(x: point.x * rect.maxX, y: point.y * rect.maxX)
    }

    public static func length(start: CGPoint, end: CGPoint, in rect: CGRect) -> CGFloat {
        let width = width(start: start, end: end) * rect.maxX
        let height = height(start: start, end: end) * rect.maxX
        return sqrt(pow(width, 2) + pow(height, 2))
    }

    private static func height(start: CGPoint, end: CGPoint) -> CGFloat {
        abs(start.y - end.y)
    }

    private static func width(start: CGPoint, end: CGPoint) -> CGFloat {
        abs(start.x - end.x)
    }
}

extension CGFloat {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
