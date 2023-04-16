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
        return self
    }
}

enum RotationControlEnum: String, CaseIterable, Identifiable {
    case absolute = "Absolute"
    case relative = "Relative"

    var id: Self {
        return self
    }
}
