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
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            gestureWidth = abs(gesture.translation.width)
                        }
                        .onEnded { gesture in
                            let wideEnough = gestureWidth > 100
                            let rightHeight = gesture.startLocation.y > geo.size.height * 0.8

                            if wideEnough, rightHeight {
                                vm.cutTree()
                                gestureWidth = 0
                            } else {
                                gestureWidth = 0
                            }
                        }
                )
        }
        .onShake {
            vm.cutTree()
        }
        .opacity(vm.opacity)
    }
}

struct GrowingPlantView_Previews: PreviewProvider {
    static var previews: some View {
        GrowingPlantView(vm: PlantVM(settingsVM: SettingsVM()))
    }
}
