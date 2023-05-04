//
//  EndPointTestView.swift
//  Plant
//
//  Created by Jonas Wallmann on 01.05.23.
//

import SwiftUI

struct EndPointTestView: View {
    let radians: [CGFloat] = [0, .pi * 0.25, .pi * 0.5, .pi * 0.75, .pi, .pi * 1.25, .pi * 1.5, .pi * 1.75, .pi * 2]

    var body: some View {
        ZStack {
            ForEach(radians, id: \.self) {
                EndPointTestShape(radian: $0)
                    .stroke(.indigo, style: StrokeStyle(lineWidth: 10))
            }
        }
    }
}

struct EndPointTestShape: Shape {
    let radian: CGFloat
    let start = UnitPoint(x: 0.5, y: 0.5)

    func path(in rect: CGRect) -> Path {
        let startPoint = RadianCircle.point(from: start, in: rect)
        let endPoint = RadianCircle.endPoint(from: startPoint, radian: radian, length: 200)

        return Path { path in
            path.move(to: startPoint)
            path.addLine(to: endPoint)
        }
    }
}

struct EndPointTestView_Previews: PreviewProvider {
    static var previews: some View {
        EndPointTestView()
    }
}
