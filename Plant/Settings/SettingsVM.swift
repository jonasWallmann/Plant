//
//  SettingsVM.swift
//  Plant
//
//  Created by Jonas Wallmann on 16.04.23.
//

import SwiftUI

class SettingsVM: ObservableObject {
    @Published public var showingSettings: Bool = false

    // Time
    @Published public var growTime: Double = 2
    @Published public var newBranchTime: Double = 0.2

    // Appearance
    @Published public var lengthControl: LengthControlEnum = .absolute
    @Published public var rotationControl: RotationControlEnum = .absolute

    // Length
    @Published public var maxTrunkDistance: Double = 7

    // Color
    @Published public var startHue: Double = 220
    @Published public var startSaturation: Double = 330
    @Published public var startBrightness: Double = 200

    @Published public var hueChange: Double = -7
    @Published public var saturationChange: Double = 0
    @Published public var brightnessChange: Double = 0

    public var startHSB: HSB {
        HSB(hue: startHue, saturation: startSaturation, brightness: startBrightness)
    }

    public var hsbs: [HSB] {
        var array: [HSB] = []
        array.append(startHSB)

        for _ in 0...7 {
            let newHSB = array.last!.nextHSB(settings: self)
            array.append(newHSB)
        }
        return array
    }
}
