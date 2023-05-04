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

    @Published private(set) var isGrowing: Bool = false

    public let settings: SettingsVM
    public var groundColor: Color?

    private let geo: GeometryProxy
    private let motionManager = MotionManager()

    private var usingNewBranchTime: Double {
        settings.newBranchTime == 0 ? 0.0001 : settings.newBranchTime
    }

    init(settingsVM: SettingsVM, geo: GeometryProxy) {
        self.geo = geo
        settings = settingsVM
    }

    // MARK: Growing --------------------------------------------------

    public func startGrowing() {
        groundColor = settings.startColor
        let start = UnitPoint(x: 0.5, y: 1)
        let end = UnitPoint(x: 0.5, y: 0.75)
        let trunk = Branch(start: start, end: end, startWidth: settings.getThickness(0), endWidth: settings.getThickness(1), startColor: settings.startHSB, endColor: settings.startHSB.nextHSB(settings: settings), rotation: 0, trunkDistance: 0, previousRadian: .pi / 2, geo: geo)
        branches.append(trunk)

        DispatchQueue.main.asyncAfter(deadline: .now() + settings.growTime) {
            self.addBranches()
        }
    }

    private func addBranches() {
        if !isGrowing { return }

        let rotation = getRotation()
        let length = getLength()

        if let growingBranch = getGrowingBranch(at: rotation) {
            let newBranch = growingBranch.nextBranch(newRotation: rotation, newLength: length, settings: settings, geo: geo)
            branches.append(newBranch)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + settings.newBranchTime) {
            self.addBranches()
        }
    }

    public func toggleGrowing() {
        if isGrowing {
            stopGrowing()
        } else {
            resumeGrowing()
        }
    }

    public func resumeGrowing() {
        isGrowing = true
        if branches.isEmpty {
            startGrowing()
        } else {
            addBranches()
        }
    }

    public func stopGrowing() {
        isGrowing = false
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
            return (2 - abs(pitch)) / 15
        }
    }

    // MARK: Cutting ---------------------------------------------

    public func cutTree() {
        withAnimation(Animation.easeOut(duration: 3)) {
            opacity = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.groundColor = self.settings.startColor
            self.branches = []
            self.opacity = 1
        }
    }
}
