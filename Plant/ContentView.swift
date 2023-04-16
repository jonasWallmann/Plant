//
//  ContentView.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var settingsVM: SettingsVM
    @StateObject var plantVM: PlantVM

    var body: some View {
        GrowingPlantView(vm: plantVM)
            .toolbar {
                Button {
                    settingsVM.showingSettings = true
                } label: {
                    Image(systemName: "gear")
                }
            }
            .sheet(isPresented: $settingsVM.showingSettings) {
                NavigationStack {
                    SettingsView()
                        .environmentObject(settingsVM)
                        .onDisappear {
                            plantVM.addBranches()
                        }
                }
            }
            .statusBarHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView(settingsVM: SettingsVM(), plantVM: PlantVM(settingsVM: SettingsVM()))
        }
    }
}
