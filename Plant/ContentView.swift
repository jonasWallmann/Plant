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
        if let groundColor = plantVM.groundColor {
            return groundColor
        }
        return settingsVM.startHSB.color ?? .accentColor
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                GrowingPlantView(vm: plantVM)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                plantVM.toggleGrowing()
                            } label: {
                                Image(systemName: plantVM.isGrowing ? "stop.fill" : "play.fill")
                                    .foregroundColor(groundColor)
                                    .padding(.vertical)
                                    .padding(.trailing, 40)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                plantVM.stopGrowing()
                                settingsVM.showingSettings = true
                            } label: {
                                Image(systemName: "gear")
                                    .foregroundColor(groundColor)
                                    .padding(.vertical)
                                    .padding(.leading, 40)
                            }
                        }
                    }
                    .sheet(isPresented: $settingsVM.showingSettings) {
                        NavigationStack {
                            SettingsView()
                                .environmentObject(settingsVM)
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
