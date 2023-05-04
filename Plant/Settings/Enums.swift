//
//  Enums.swift
//  Plant
//
//  Created by Jonas Wallmann on 15.04.23.
//

import Foundation

enum LengthControlEnum: String, CaseIterable, Identifiable {
    case absolute = "Absolute"
    case relative = "Relative"

    var id: Self {
        self
    }
}

enum RotationControlEnum: String, CaseIterable, Identifiable {
    case absolute = "Absolute"
    case relative = "Relative"

    var id: Self {
        self
    }
}

enum ThicknessControlEnum: String, CaseIterable, Identifiable {
    case consistent = "Consistent"
    case natural = "Natural"

    var id: Self {
        self
    }
}

enum DirectionEnum: String {
    case left = "left"
    case right = "right"
}
