//
//  GrowingPlantView.swift
//  Plant
//
//  Created by Jonas Wallmann on 16.04.23.
//

import SwiftUI

struct GrowingPlantView: View {
    @ObservedObject var vm: PlantVM

    @State private var gestureWidth: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            PlantView(branches: vm.branches, growTime: vm.settings.growTime)
        }
        .onShake {
            vm.cutTree()
        }
        .opacity(vm.opacity)
    }
}

struct GrowingPlantView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            GrowingPlantView(vm: PlantVM(settingsVM: SettingsVM(), geo: geo))
        }
    }
}
