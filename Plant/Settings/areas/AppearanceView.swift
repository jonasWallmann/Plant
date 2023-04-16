//
//  AppearanceView.swift
//  Plant
//
//  Created by Jonas Wallmann on 16.04.23.
//

import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject private var vm: SettingsVM

    var body: some View {
        Section("Appearance") {
            Picker("Rotation", selection: $vm.rotationControl) {
                ForEach(RotationControlEnum.allCases) { rotation in
                    Text(rotation.rawValue).tag(rotation)
                }
            }
            Picker("Length", selection: $vm.lengthControl) {
                ForEach(LengthControlEnum.allCases) { length in
                    Text(length.rawValue).tag(length)
                }
            }
        }
    }
}

struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            AppearanceView()
        }
        .environmentObject(SettingsVM())
    }
}
