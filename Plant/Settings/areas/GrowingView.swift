//
//  AppearanceView.swift
//  Plant
//
//  Created by Jonas Wallmann on 16.04.23.
//

import SwiftUI

struct GrowingView: View {
    @EnvironmentObject private var vm: SettingsVM

    var body: some View {
        Section("Growing") {
            HStack {
                Text("Rotation")
                Spacer()

                Picker("Rotation", selection: $vm.rotationControl) {
                    ForEach(RotationControlEnum.allCases) { rotation in
                        Text(rotation.rawValue).tag(rotation)
                    }
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 265)
            }

            HStack {
                Text("Length")
                Spacer()

                Picker("Length", selection: $vm.lengthControl) {
                    ForEach(LengthControlEnum.allCases) { length in
                        Text(length.rawValue).tag(length)
                    }
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 265)
            }
        }

    }
}

struct GrowingView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            GrowingView()
        }
        .environmentObject(SettingsVM())
    }
}
