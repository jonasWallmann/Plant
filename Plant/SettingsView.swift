//
//  SettingsView.swift
//  Plant
//
//  Created by Jonas Wallmann on 15.04.23.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var plantVM: PlantVM

    var body: some View {
        Form {
            Section("Times") {
                SliderBuilder(description: "Grow", value: $plantVM.growTime) {
                    Slider(value: $plantVM.growTime, in: 0 ... 10, step: 0.5)
                }
                SliderBuilder(description: "Add", value: $plantVM.newBranchTime) {
                    Slider(value: $plantVM.newBranchTime, in: 0 ... 1, step: 0.1)
                }
            }
            Section("Appearance") {
                Picker("Rotation", selection: $plantVM.rotationControl) {
                    Text("Absolute").tag(RotationControlEnum.absolute)
                    Text("Relative").tag(RotationControlEnum.relative)
                }
                Picker("Length", selection: $plantVM.lengthControl) {
                    ForEach(LengthControlEnum.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SliderBuilder<Content: View>: View {
    let description: String
    @Binding var value: Double

    let content: Content

    init(description: String, value: Binding<Double>, @ViewBuilder content: () -> Content) {
        self.description = description
        self._value = value
        self.content = content()
    }

    var body: some View {
        HStack {
            Text(description)
                .frame(width: 50, alignment: .leading)
            content
            TextField(description, value: $value, format: .number)
                .frame(width: 40)
                .multilineTextAlignment(.trailing)
            Text("sec")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(plantVM: PlantVM())
        }
    }
}
