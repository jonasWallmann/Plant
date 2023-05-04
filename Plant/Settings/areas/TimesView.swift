//
//  TimesView.swift
//  Plant
//
//  Created by Jonas Wallmann on 16.04.23.
//

import SwiftUI

struct TimesView: View {
    @EnvironmentObject private var vm: SettingsVM

    var body: some View {
        Section("Time") {
            SliderBuilder(description: "Grow", descriptionText: "sec", value: $vm.growTime) {
                Slider(value: $vm.growTime, in: 0 ... 10, step: 0.5)
            }
            SliderBuilder(description: "Add", descriptionText: "sec", value: $vm.newBranchTime) {
                Slider(value: $vm.newBranchTime, in: 0 ... 1, step: 0.1)
            }
        }
    }
}

struct TimesView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            TimesView()
        }
        .environmentObject(SettingsVM())
    }
}
