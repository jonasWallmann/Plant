//
//  ExportVM.swift
//  Plant
//
//  Created by Jonas Wallmann on 05.06.23.
//

import SwiftUI

@MainActor
class ExportVM {

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    public func getVectorImage(plantVM: PlantVM) -> URL {
        

        let view = GrowingPlantView(vm: plantVM).frame(width: screenWidth, height: screenHeight)

        let renderer = ImageRenderer(content: view)

        let url = URL.documentsDirectory.appending(path: "Tree.pdf")

        renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)

            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }

            pdf.beginPDFPage(nil)

            context(pdf)

            pdf.endPDFPage()
            pdf.closePDF()
        }

        return url
    }
}
