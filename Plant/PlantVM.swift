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

    @Published public var showingSettings: Bool = false

    @Published public var growTime: Double = 1
    @Published public var newBranchTime: Double = 0.2

    @Published public var lengthControl: LengthControlEnum = .absolute
    @Published public var rotationControl: RotationControlEnum = .absolute

    @Published public var startColor: HSB = .mock

    private let motionManager = MotionManager()

    private var usingNewBranchTime: Double {
        newBranchTime == 0 ? 0.0001 : newBranchTime
    }

    init() {
        addTrunk()
    }

    // MARK: Growing --------------------------------------------------

    public func addTrunk() {
        let start = CGPoint(x: 0.5, y: 0)
        let end = CGPoint(x: 0.5, y: 0.2)
        let trunk = Branch(start: start, end: end, startColor: startColor, rotation: 0, trunkDistance: 0)
        branches.append(trunk)

        DispatchQueue.main.asyncAfter(deadline: .now() + growTime) {
            self.addBranch()
        }
    }

    private func addBranch() {
        if branches.count > 2000 { return }

        if !showingSettings {
            let rotation = getRotation()
            let length = getLength()

            if let growingBranch = getGrowingBranch(at: rotation) {
                let newBranch = growingBranch.nextBranch(rotation: rotation, length: length)
                branches.append(newBranch)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + newBranchTime) {
            self.addBranch()
        }
    }

    private func getGrowingBranch(at rotation: CGFloat) -> Branch? {
        var potentials: [Branch] = []

        for branch in branches {
            if branch.isGrowing(growTime) || branch.isOnEdge { continue }

            if !branches.contains(where: { $0.start == branch.end && $0.hasRotation(in: rotation) }) {
                potentials.append(branch)
            }
        }
        return potentials.randomElement()
    }

    // MARK: Calculations ---------------------------------------

    private func getRotation() -> CGFloat {
        guard let roll = motionManager.roll else { return 0 }

        switch rotationControl {
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
        switch lengthControl {
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
