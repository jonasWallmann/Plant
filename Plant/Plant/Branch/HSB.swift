//
//  HSB.swift
//  Plant
//
//  Created by Jonas Wallmann on 16.04.23.
//

import SwiftUI

struct HSB: Identifiable {
    let id = UUID()

    let hue: Double
    let saturation: Double
    let brightness: Double

    var color: Color {
        Color(hue: hue / 360, saturation: saturation / 360, brightness: brightness / 360)
    }

    func nextHSB(settings: SettingsVM) -> HSB {
        let newHue = hue + settings.hueChange
        let newSaturation = saturation + settings.saturationChange
        let newBrightness = brightness + settings.brightnessChange

        return HSB(hue: newHue, saturation: newSaturation, brightness: newBrightness)
    }

    public func testGradient(with settings: SettingsVM) -> Gradient {
        Gradient(colors: [color, nextHSB(settings: settings).color])
    }
}

extension HSB {
    static let mock = HSB(hue: 220, saturation: 330, brightness: 200)
}
