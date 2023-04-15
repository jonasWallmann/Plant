//
//  PlantApp.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import SwiftUI

@main
struct PlantApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PlantView()
            }
        }
    }
}
