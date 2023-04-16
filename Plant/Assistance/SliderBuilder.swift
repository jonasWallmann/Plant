//
//  SliderBuilder.swift
//  Plant
//
//  Created by Jonas Wallmann on 16.04.23.
//

import SwiftUI

struct SliderBuilder<Content: View>: View {
    let description: String
    let descWidth: CGFloat
    let descriptionText: String

    @Binding var value: Double

    let content: Content

    @FocusState private var keyboardFocus: Bool

    init(description: String, descWidth: CGFloat = 50, descriptionText: String = "", value: Binding<Double>, @ViewBuilder content: () -> Content) {
        self.description = description
        self.descWidth = descWidth
        self.descriptionText = descriptionText
        _value = value
        self.content = content()
    }

    var body: some View {
        HStack {
            Text(description)
                .frame(width: descWidth, alignment: .leading)

            content

            TextField(description, value: $value, format: .number)
                .frame(width: 40)
                .multilineTextAlignment(.trailing)
                .focused($keyboardFocus)
                .keyboardType(.numberPad)
                .selectAllUponEntering()

            Text(descriptionText)
        }
    }
}

struct SliderBuilder_Previews: PreviewProvider {
    static var previews: some View {
        SliderBuilder(description: "Cans", value: .constant(0)) {
            Slider(value: .constant(0), in: 0 ... 10, step: 0.5)
        }
    }
}
