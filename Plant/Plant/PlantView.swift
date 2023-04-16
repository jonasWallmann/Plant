//
//  PlantView.swift
//  Plant
//
//  Created by Jonas Wallmann on 16.04.23.
//

import SwiftUI

struct PlantView: View {
    let branches: [Branch]
    let growTime: Double

    init(branches: [Branch], growTime: Double = 0) {
        self.branches = branches
        self.growTime = growTime
    }

    var body: some View {
        ZStack {
            Color("Background")
            ForEach(branches) { branch in
                BranchView(branch: branch, growTime: growTime)
            }
        }
    }
}

struct PlantView_Previews: PreviewProvider {
    static var previews: some View {
        PlantView(branches: [Branch.mock])
    }
}
