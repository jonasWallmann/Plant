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
        Path { path in
            let length = RadianCircle.length(start: branch.start, end: branch.end)
            let progressLength = length * progress

            let start = branch.start
            let end = RadianCircle.endPoint(from: branch.start, radian: branch.radian, length: progressLength)

            let startX = start.x * rect.maxX
            let startY = (1 - start.y) * rect.maxY

            let endX = end.x * rect.maxX
            let endY = (1 - end.y) * rect.maxY

            let startPoint = CGPoint(x: startX, y: startY)
            let endPoint = CGPoint(x: endX, y: endY)

            let radian = RadianCircle.radian(form: startPoint, to: endPoint)

            let leftStartPoint = RadianCircle.widthPoint(from: startPoint, width: branch.startWidth, direction: .left, radian: radian)
            let rightStartPoint = RadianCircle.widthPoint(from: startPoint, width: branch.startWidth, direction: .right, radian: radian)

            let leftEndPoint = RadianCircle.widthPoint(from: endPoint, width: branch.endWidth, direction: .left, radian: radian)
            let rightEndPoint = RadianCircle.widthPoint(from: endPoint, width: branch.endWidth, direction: .right, radian: radian)

            path.move(to: leftStartPoint)
            path.addLine(to: rightStartPoint)
            path.addLine(to: rightEndPoint)
            path.addLine(to: leftEndPoint)
            path.addLine(to: leftStartPoint)
        }
    }
}
