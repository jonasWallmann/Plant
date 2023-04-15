//
//  RadianCircle.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import Foundation

class RadianCircle {
    static func radian(form start: CGPoint, to end: CGPoint) -> CGFloat {
        let height = height(start: start, end: end)
        let width = width(start: start, end: end)

        // corners
        if start.x < end.x && start.y < end.y {
            return atan(height / width)
        }
        if start.x > end.x && start.y < end.y {
            return atan(width / height) + .pi * 0.5
        }
        if start.x > end.x && start.y > end.y {
            return atan(height / width) + .pi
        }
        if start.x < end.x && start.y > end.y {
            return atan(width / height) + .pi * 1.5
        }

        // axes
        if start.x < end.x && start.y == end.y {
            return 0
        }
        if start.x == end.x && start.y < end.y {
            return .pi * 0.5
        }
        if start.x > end.x && start.y == end.y {
            return .pi
        }
        if start.x == end.x && start.y > end.y {
            return .pi * 1.5
        }
        return .pi * 0.5
    }

    public static func endPoint(from start: CGPoint, radian: CGFloat, length: CGFloat) -> CGPoint {
        var radian: CGFloat = radian.truncatingRemainder(dividingBy: .pi * 2)

        if radian < 0 {
            radian = .pi * 2 + radian
        }

        // corners
        if radian > 0 && radian < .pi * 0.5 {
            let angle = radian
            let width = cos(angle) * length
            let height = sin(angle) * length
            return endPoint(from: start, width: width, height: height)
        }
        if radian > .pi * 0.5 && radian < .pi {
            let angle = radian - .pi / 2
            let width = -sin(angle) * length
            let height = cos(angle) * length
            return endPoint(from: start, width: width, height: height)
        }
        if radian > .pi && radian < .pi * 1.5 {
            let angle = radian - .pi
            let with = -cos(angle) * length
            let height = -sin(angle) * length
            return endPoint(from: start, width: with, height: height)
        }
        if radian > .pi * 1.5 && (radian < 0 || radian < .pi * 2) {
            let angle = radian - .pi * 1.5
            let width = sin(angle) * length
            let height = -cos(angle) * length
            return endPoint(from: start, width: width, height: height)
        }

        // axes
        if radian == 0 || radian == .pi * 2 {
            return endPoint(from: start, width: length, height: 0)
        }
        if radian == .pi * 0.5 {
            return endPoint(from: start, width: 0, height: length)
        }
        if radian == .pi {
            return endPoint(from: start, width: -length, height: 0)
        }
        if radian == .pi * 1.5 {
            return endPoint(from: start, width: 0, height: -length)
        }
        return endPoint(from: start, width: 0, height: length)
    }

    private static func endPoint(from start: CGPoint, width: CGFloat, height: CGFloat) -> CGPoint {
        return CGPoint(x: start.x + width, y: start.y + height)
    }

    public static func length(start: CGPoint, end: CGPoint) -> CGFloat {
        sqrt(pow(height(start: start, end: end), 2) + pow(width(start: start, end: end), 2))
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
