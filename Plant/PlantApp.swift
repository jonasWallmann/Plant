//
//  PlantApp.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import SwiftUI

@main
struct PlantApp: App {
    @StateObject private var settingsVM = SettingsVM()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(settingsVM: settingsVM, plantVM: PlantVM(settingsVM: settingsVM))
//                TestView()
            }
        }
    }
}
