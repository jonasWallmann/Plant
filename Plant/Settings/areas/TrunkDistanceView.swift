//
//  TrunkDistanceView.swift
//  Plant
//
//  Created by Jonas Wallmann on 27.04.23.
//

import SwiftUI

struct TrunkDistanceView: View {
    @EnvironmentObject private var vm: SettingsVM

    var body: some View {
        Section("Tree Size") {
            SliderBuilder(description: "Max trunk dist", descWidth: 160, descriptionText: "branches", value: $vm.maxTrunkDistance) {
                Slider(value: $vm.maxTrunkDistance, in: 0...15, step: 1)
            }
        }
    }
}

struct TrunkDistanceView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TrunkDistanceView()
        }
            .environmentObject(SettingsVM())
    }
}
