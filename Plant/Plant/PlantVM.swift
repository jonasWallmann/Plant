//
//  PlantVM.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import SwiftUI

class PlantVM: ObservableObject {
    @Published private(set) var branches: [Branch] = []
    @Published private(set) var opacity: Double = 1

    public let settings: SettingsVM
    private let motionManager = MotionManager()

    private var addingBranches: Bool = false

    private var usingNewBranchTime: Double {
        settings.newBranchTime == 0 ? 0.0001 : settings.newBranchTime
    }

    init(settingsVM: SettingsVM) {
        settings = settingsVM
        addTrunk()
    }

    // MARK: Growing --------------------------------------------------

    public func addTrunk() {
        let start = CGPoint(x: 0.5, y: 0)
        let end = CGPoint(x: 0.5, y: 0.25)
        let trunk = Branch(start: start, end: end, startWidth: 20, startColor: settings.startHSB, endColor: settings.startHSB.nextHSB(settings: settings), rotation: 0, trunkDistance: 0)
        branches.append(trunk)

        DispatchQueue.main.asyncAfter(deadline: .now() + settings.growTime) {
            self.addBranches()
        }
    }

    public func addBranches() {
        addingBranches = true

        if settings.showingSettings || branches.count > 2000 {
            addingBranches = false
            return
        }

        let rotation = getRotation()
        let length = getLength()

        if let growingBranch = getGrowingBranch(at: rotation) {
            let newBranch = growingBranch.nextBranch(newRotation: rotation, newLength: length, settings: settings)
            branches.append(newBranch)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + settings.newBranchTime) {
            self.addBranches()
        }
    }

    private func getGrowingBranch(at rotation: CGFloat) -> Branch? {
        var potentials: [Branch] = []

        for branch in branches {
            if branch.isGrowing(settings.growTime) || branch.isOnEdge(settings.maxTrunkDistance) { continue }

            if !branches.contains(where: { $0.start == branch.end && $0.hasRotation(in: rotation) }) {
                potentials.append(branch)
            }
        }
        return potentials.randomElement()
    }

    // MARK: Calculations ---------------------------------------

    private func getRotation() -> CGFloat {
        guard let roll = motionManager.roll else { return 0 }

        switch settings.rotationControl {
        case .absolute:
            if roll > 0 {
                return CGFloat.pi / 12
            }
            return -CGFloat.pi / 12
        case .relative:
            return roll / 2
        }
    }

    private func getLength() -> CGFloat? {
        switch settings.lengthControl {
        case .absolute:
            return nil
        case .relative:
            guard let pitch = motionManager.pitch else { return 0.2 }
            return (1.6 - abs(pitch)) / 15
        }
    }

    // MARK: Cutting ---------------------------------------------

    public func cutTree() {
        withAnimation(Animation.easeOut(duration: 3)) {
            opacity = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.branches = []
            self.opacity = 1
            self.addTrunk()
        }
    }
}
