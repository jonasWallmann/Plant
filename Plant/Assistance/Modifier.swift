//
//  Modifier.swift
//  Plant
//
//  Created by Jonas Wallmann on 16.04.23.
//

import SwiftUI

struct TextFieldSelectAllModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                if let textField = obj.object as? UITextField {
                    textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                }
            }
    }
}

extension View {
    func selectAllUponEntering() -> some View {
        modifier(TextFieldSelectAllModifier())
    }
}
