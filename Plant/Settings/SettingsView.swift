//
//  SettingsView.swift
//  Plant
//
//  Created by Jonas Wallmann on 15.04.23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var vm: SettingsVM

    var body: some View {
        Form {
            TimesView()
            AppearanceView()
            ColorView()
        }
        .navigationTitle("Settings")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back") {
                    vm.showingSettings = false
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
                .environmentObject(SettingsVM())
        }
    }
}
