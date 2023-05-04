//
//  TestView2.swift
//  Plant
//
//  Created by Jonas Wallmann on 01.05.23.
//

import SwiftUI

struct WidthPointTestView: View {
    var body: some View {
        WidthPointTestShape()
            .stroke(.cyan, style: StrokeStyle(lineWidth: 10))
    }
}

struct WidthPointTestShape: Shape {
    let start = UnitPoint(x: 0.3, y: 0.8)
    let end = UnitPoint(x: 0.7, y: 0.2)

    let startWidth: CGFloat = 50
    let endWidth: CGFloat = 50

    let previousRadian: CGFloat = .pi / 2

    func path(in rect: CGRect) -> Path {
        let startPoint = RadianCircle.point(from: start, in: rect)
        let endPoint = RadianCircle.point(from: end, in: rect)

        let radian = RadianCircle.radian(from: startPoint, to: endPoint)

        let widthPoint = RadianCircle.widthPoint(from: endPoint, width: 40, direction: .left, radian: radian)

        return Path { path in
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            path.addLine(to: widthPoint)
        }
    }
}

struct TestView2_Previews: PreviewProvider {
    static var previews: some View {
        WidthPointTestView()
    }
}
