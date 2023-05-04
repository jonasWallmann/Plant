//
//  TestView.swift
//  Plant
//
//  Created by Jonas Wallmann on 01.05.23.
//

import SwiftUI

struct BranchTestView: View {
    var body: some View {
        BranchTestShape()
            .fill(.indigo)
            .ignoresSafeArea()
    }
}

struct BranchTestShape: Shape {
    let start = UnitPoint(x: 0.5, y: 1)
    let end = UnitPoint(x: 0.7, y: 0.4)

    let startWidth: CGFloat = 50
    let endWidth: CGFloat = 25

    let previousRadian: CGFloat = .pi / 2

    func path(in rect: CGRect) -> Path {
        let startPoint = RadianCircle.point(from: start, in: rect)
        let endPoint = RadianCircle.point(from: end, in: rect)

        let radian = RadianCircle.radian(from: startPoint, to: endPoint)

        let leftStartPoint = RadianCircle.widthPoint(from: startPoint, width: startWidth, direction: .left, radian: previousRadian)
        let rightStartPoint = RadianCircle.widthPoint(from: startPoint, width: startWidth, direction: .right, radian: previousRadian)

        let leftEndPoint = RadianCircle.widthPoint(from: endPoint, width: endWidth, direction: .left, radian: radian)
        let rightEndPoint = RadianCircle.widthPoint(from: endPoint, width: endWidth, direction: .right, radian: radian)

        return Path { path in
            path.move(to: leftStartPoint)
            path.addLine(to: rightStartPoint)
            path.addLine(to: rightEndPoint)
            path.addLine(to: leftEndPoint)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        BranchTestView()
    }
}
