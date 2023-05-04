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

    var groundColor: Color {
        plantVM.groundColor ?? .black
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                GrowingPlantView(vm: plantVM)
                    .toolbar {
                        Button {
                            plantVM.stopGrowing()
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
                                    plantVM.resumeGrowing()
                                }
//                                .presentationBackground(Material.thin)
                        }
                    }

                groundColor
                    .frame(height: groundHeight(geo))
                    .onTapGesture {
                        if plantVM.branches.isEmpty {
                            plantVM.startGrowing()
                        } else {
                            plantVM.cutTree()
                        }
                    }
            }
        }
    }

    func groundHeight(_ geo: GeometryProxy) -> CGFloat {
        return geo.size.height - geo.size.width
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GeometryReader { geo in
                ContentView(settingsVM: SettingsVM(), plantVM: PlantVM(settingsVM: SettingsVM(), geo: geo))
            }
        }
    }
}
