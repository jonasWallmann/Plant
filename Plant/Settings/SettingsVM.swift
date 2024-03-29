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
    @Published public var growTime: Double = 1.5
    @Published public var newBranchTime: Double = 0.25

    // Growing
    @Published public var lengthControl: LengthControlEnum = .absolute
    @Published public var rotationControl: RotationControlEnum = .absolute
    @Published public var thickness: ThicknessControlEnum = .consistent

    // Length
    @Published public var maxTrunkDistance: Double = 9

    // Color
    @Published public var startHue: Double = 20
    @Published public var startSaturation: Double = 50
    @Published public var startBrightness: Double = 47

    @Published public var hueChange: Double = 7
    @Published public var saturationChange: Double = 23
    @Published public var brightnessChange: Double = 4

    private let thicknesses: [CGFloat] = [20, 17, 7, 5, 3, 2, 2]

    public func reset() {
        growTime = 1.5
        newBranchTime = 0.25

        lengthControl = .absolute
        rotationControl = .absolute
        thickness = .consistent

        maxTrunkDistance = 9

        startHue = 20
        startSaturation = 50
        startBrightness = 47

        hueChange = 7
        saturationChange = 23
        brightnessChange = 4
    }

    public var startHSB: HSB {
        HSB(hue: startHue, saturation: startSaturation, brightness: startBrightness)
    }

    public var startColor: Color? {
        startHSB.color
    }

    public var hsbs: [HSB] {
        var array: [HSB] = []
        array.append(startHSB)

        for _ in 0 ..< Int(maxTrunkDistance) {
            let newHSB = array.last!.nextHSB(settings: self)
            array.append(newHSB)
        }
        return array
    }

    public func getThickness(_ trunkDistance: Int) -> CGFloat {
        if thickness == .consistent { return 2.5 }

        if trunkDistance > thicknesses.count { return 1.7 }

        return thicknesses[trunkDistance - 1]
    }
}
