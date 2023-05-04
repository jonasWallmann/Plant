//
//  GradientTestView.swift
//  Plant
//
//  Created by Jonas Wallmann on 01.05.23.
//

import SwiftUI

struct GradientTestView: View {
    var body: some View {
        GeometryReader { geo in
            GradientTestSubView(geo: geo)
        }
    }
}

struct GradientTestSubView: View {
    let geo: GeometryProxy
    let shape: GradientShape

    init(geo: GeometryProxy) {
        self.geo = geo
        shape = GradientShape(geo: geo)
    }

    var body: some View {
        shape
            .fill(shape.gradient)
    }
}

struct GradientShape: Shape {
    let start = UnitPoint(x: 0.5, y: 1)
    let end = UnitPoint(x: 0.5, y: 0.5)

    let startWidth: CGFloat = 50
    let endWidth: CGFloat = 25

    let radian: CGFloat = .pi / 2

    let geo: GeometryProxy

    var gradient: LinearGradient {
        let ratio = geo.size.width / geo.size.height

        let adjustedStartY = start.y * ratio
        let adjustedEndY = end.y * ratio

        return LinearGradient(
            gradient: Gradient(colors: [.indigo, .red]),
            startPoint: .init(x: start.x, y: adjustedStartY),
            endPoint: .init(x: end.x, y: adjustedEndY)
        )
    }

    func path(in rect: CGRect) -> Path {
        let startPoint = RadianCircle.point(from: start, in: rect)
        let endPoint = RadianCircle.point(from: end, in: rect)

        let leftStartPoint = point(from: startPoint, with: startWidth, direction: .left)
        let rightStartPoint = point(from: startPoint, with: startWidth, direction: .right)

        let leftEndPoint = point(from: endPoint, with: endWidth, direction: .left)
        let rightEndPoint = point(from: endPoint, with: endWidth, direction: .right)

        return Path { path in
            path.move(to: leftStartPoint)
            path.addLine(to: rightStartPoint)
            path.addLine(to: rightEndPoint)
            path.addLine(to: leftEndPoint)
        }
    }

    private func point(from point: CGPoint, with: CGFloat, direction: DirectionEnum) -> CGPoint {
        RadianCircle.widthPoint(from: point, width: with, direction: direction, radian: radian)
    }
}

struct GradientTestView_Previews: PreviewProvider {
    static var previews: some View {
        GradientTestView()
    }
}
