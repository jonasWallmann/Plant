//
//  TrunkDistanceView.swift
//  Plant
//
//  Created by Jonas Wallmann on 27.04.23.
//

import SwiftUI

struct FormView: View {
    @EnvironmentObject private var vm: SettingsVM

    var body: some View {
        Section("Form") {
            HStack {
                Text("Height")
                Spacer()

                Picker("Height", selection: $vm.maxTrunkDistance) {
                    ForEach(5 ..< 11) { height in
                        Text("\(height)").tag(Double(height))
                    }
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 265)
            }
            HStack {
                Text("Thickness")
                Spacer()

                Picker("Thickness", selection: $vm.thickness) {
                    ForEach(ThicknessControlEnum.allCases) { thickness in
                        Text(thickness.rawValue).tag(thickness)
                    }
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 265)
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            FormView()
        }
        .environmentObject(SettingsVM())
    }
}
