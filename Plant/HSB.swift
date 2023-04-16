//
//  HSB.swift
//  Plant
//
//  Created by Jonas Wallmann on 16.04.23.
//

import SwiftUI

struct HSB {
    let hue: Double
    let saturation: Double
    let brightness: Double

    var color: Color {
        Color(hue: hue / 360, saturation: saturation / 360, brightness: brightness / 360)
    }

    func nextColor() -> HSB {
        let newHue = hue - 30
        let newSaturation = saturation
        let newBrightness = brightness

        return HSB(hue: newHue, saturation: newSaturation, brightness: newBrightness)
    }
}

extension HSB {
    static let mock = HSB(hue: 220, saturation: 330, brightness: 200)
}

struct HSB_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(
                    Gradient(colors: [HSB.mock.color, HSB.mock.nextColor().color])
                )
//            Rectangle()
//                .fill(
//                    Gradient(colors: [HSB.mock.nextColor().color, HSB.mock.nextColor().nextColor().color])
//                )
        }
        .ignoresSafeArea()
    }
}
