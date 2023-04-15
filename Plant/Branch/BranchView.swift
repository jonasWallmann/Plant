//
//  BranchView.swift
//  Plant
//
//  Created by Jonas Wallmann on 10.04.23.
//

import SwiftUI

struct BranchView: View {
    @State private var pathProgress: CGFloat = 0

    let branch: Branch
    let growTime: Double

    var body: some View {
        branch
            .trim(from: 0.0, to: pathProgress)
            .stroke(.green, lineWidth: 2)
            .onAppear {
                withAnimation(Animation.easeOut(duration: growTime)) {
                    pathProgress = 1
                }
            }
            
    }
}

struct BranchView_Previews: PreviewProvider {
    static var previews: some View {
        BranchView(branch: Branch.mock, growTime: 1)
    }
}
