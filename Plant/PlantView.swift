//
//  ContentView.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import SwiftUI

struct PlantView: View {
    @StateObject private var vm = PlantVM()

    @State private var gestureWidth: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("Background")
                ForEach(vm.branches) { branch in
                    BranchView(branch: branch, growTime: vm.growTime)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        gestureWidth = abs(gesture.translation.width)
                    }
                    .onEnded { gesture in
                        let wideEnough = gestureWidth > 100
                        let rightHeight = gesture.startLocation.y > geo.size.height * 0.8

                        if wideEnough && rightHeight {
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
        .statusBarHidden()
        .toolbar {
            Button {
                vm.showingSettings = true
            } label: {
                Image(systemName: "gear")
            }
        }
        .sheet(isPresented: $vm.showingSettings) {
            NavigationStack {
                SettingsView(plantVM: vm)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlantView()
        }
    }
}
