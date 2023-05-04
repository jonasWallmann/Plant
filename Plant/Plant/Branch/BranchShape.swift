//
//  BranchShape.swift
//  Plant
//
//  Created by Jonas Wallmann on 01.05.23.
//

import SwiftUI

struct BranchShape: Shape {
    private let branch: Branch

    var progress: CGFloat = 0

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    init(branch: Branch, progress: CGFloat) {
        self.branch = branch
        self.progress = progress
    }

    public func path(in rect: CGRect) -> Path {
        let start = UnitPoint(x: branch.start.x, y: branch.start.y + 0.001)
        let end = branch.end

        let length = RadianCircle.length(start: start, end: end, in: rect)
        let progressLength = length * progress

        let startPoint = RadianCircle.point(from: start, in: rect)
        let endPoint = RadianCircle.endPoint(from: startPoint, radian: branch.radian, length: progressLength)

        let radian = RadianCircle.radian(from: start, to: end)

        let leftStartPoint = RadianCircle.widthPoint(from: startPoint, width: branch.startWidth, direction: .left, radian: branch.previousRadian)
        let rightStartPoint = RadianCircle.widthPoint(from: startPoint, width: branch.startWidth, direction: .right, radian: branch.previousRadian)

        let leftEndPoint = RadianCircle.widthPoint(from: endPoint, width: branch.endWidth, direction: .left, radian: radian)
        let rightEndPoint = RadianCircle.widthPoint(from: endPoint, width: branch.endWidth, direction: .right, radian: radian)

        return Path { path in
            path.move(to: leftStartPoint)
            path.addLine(to: rightStartPoint)
            path.addLine(to: rightEndPoint)
            path.addLine(to: leftEndPoint)
        }
    }
}
