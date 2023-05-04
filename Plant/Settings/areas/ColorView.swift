//
//  ColorView.swift
//  Plant
//
//  Created by Jonas Wallmann on 16.04.23.
//

import SwiftUI

struct ColorView: View {
    @EnvironmentObject private var vm: SettingsVM

    private let desWidth: CGFloat = 95

    var body: some View {
        Section("Color Preview") {
            Spacer()
        }
        .listRowBackground(
            HStack(spacing: 0) {
                ForEach(vm.hsbs) { hsb in
                    LinearGradient(gradient: hsb.testGradient(with: vm), startPoint: .leading, endPoint: .trailing)
                }
            }
        )
        Section("Start Color") {
            SliderBuilder(description: "Hue", descWidth: desWidth, descriptionText: "degree", value: $vm.startHue) {
                Slider(value: $vm.startHue, in: 0 ... 360, step: 1)
            }
            SliderBuilder(description: "Saturation", descWidth: desWidth, descriptionText: "%", value: $vm.startSaturation) {
                Slider(value: $vm.startSaturation, in: 0 ... 100, step: 1)
            }
            SliderBuilder(description: "Brightness", descWidth: desWidth, descriptionText: "%", value: $vm.startBrightness) {
                Slider(value: $vm.startBrightness, in: 0 ... 100, step: 1)
            }
        }
        Section("New Branch Color Adjustment") {
            SliderBuilder(description: "Hue", descWidth: desWidth, descriptionText: "degree", value: $vm.hueChange) {
                Slider(value: $vm.hueChange, in: -180 ... 180, step: 1)
            }
            SliderBuilder(description: "Saturation", descWidth: desWidth, descriptionText: "%", value: $vm.saturationChange) {
                Slider(value: $vm.saturationChange, in: -25 ... 25, step: 1)
            }
            SliderBuilder(description: "Brightness", descWidth: desWidth, descriptionText: "%", value: $vm.brightnessChange) {
                Slider(value: $vm.brightnessChange, in: -25 ... 25, step: 1)
            }
        }
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            ColorView()
        }
        .environmentObject(SettingsVM())
    }
}
