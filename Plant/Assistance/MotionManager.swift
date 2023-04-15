//
//  MotionManager.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import CoreMotion

class MotionManager {
    let tracker = CMMotionManager()

    var pitch: CGFloat?
    var roll: CGFloat?
    var yaw: CGFloat?

    var error: Error?

    init() {
        tracker.startDeviceMotionUpdates(to: OperationQueue()) { [weak self] motion, error in
            guard let self = self, let motion = motion else {
                return
            }
            self.pitch = motion.attitude.pitch
            self.roll = motion.attitude.roll
            self.yaw = motion.attitude.yaw
            self.error = error
        }
    }

    deinit {
        tracker.stopDeviceMotionUpdates()
    }
}
