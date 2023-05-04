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
    @Published public var newBranchTime: Double = 0.5

    // Growing
    @Published public var lengthControl: LengthControlEnum = .absolute
    @Published public var rotationControl: RotationControlEnum = .absolute
    @Published public var variableThickness: Bool = false

    // Length
    @Published public var maxTrunkDistance: Double = 7

    // Color
    @Published public var startHue: Double = 20
    @Published public var startSaturation: Double = 50
    @Published public var startBrightness: Double = 47

    @Published public var hueChange: Double = 7
    @Published public var saturationChange: Double = 23
    @Published public var brightnessChange: Double = 4

    private let thicknesses: [CGFloat] = [20, 17, 7, 5, 3, 2, 2]

    public var startHSB: HSB {
        HSB(hue: startHue, saturation: startSaturation, brightness: startBrightness)
    }

    public var startColor: Color? {
        startHSB.color
    }

    public var hsbs: [HSB] {
        var array: [HSB] = []
        array.append(startHSB)

        for _ in 0 ... 7 {
            let newHSB = array.last!.nextHSB(settings: self)
            array.append(newHSB)
        }
        return array
    }

    public func getThickness(_ trunkDistance: Int) -> CGFloat {
        if !variableThickness { return 2.5 }
        
        if trunkDistance >= thicknesses.count { return 1.7 }

        return thicknesses[trunkDistance]
    }
}
