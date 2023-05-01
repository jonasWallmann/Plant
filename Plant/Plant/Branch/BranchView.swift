//
//  BranchView.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import SwiftUI

struct BranchView: View {
    @State private var progress: CGFloat = 0

    let branch: Branch
    let growTime: Double

    var body: some View {
        BranchShape(branch: branch, progress: progress)
            .fill(branch.gradient)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: growTime)) {
                    progress = 1
                }
            }
    }
}

struct BranchView_Previews: PreviewProvider {
    static var previews: some View {
        BranchView(branch: Branch.mock, growTime: 1)
    }
}
