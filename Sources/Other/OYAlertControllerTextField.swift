//
//  OYAlertControllerTextField.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

public struct OYAlertControllerTextField: Equatable {
    var text: String
    var placeholder: String
    var keyboardType: UIKeyboardType

    public init(text: String, placeholder: String, keyboardType: UIKeyboardType = .default) {
        self.text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
}
