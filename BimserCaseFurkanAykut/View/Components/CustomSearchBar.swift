//
//  CustomSearchBar.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import Foundation
import SwiftUI

struct CustomSearchBar: UIViewRepresentable {

    @Binding var text: String
    @Binding var isTapped: Bool
    var placeholder: String
    let placeholderColor: UIColor
    let count = 0
    var keyboardType: UIKeyboardType? = .default
    var autoCapitilazied: UITextAutocapitalizationType? = UITextAutocapitalizationType.none
    var textColor: UIColor? = UIColor(Colors.shared.black)
    var font: UIFont? = UIFont(name: "Nunito", size: 16)

    init(text: Binding<String>, placeholder: String = "", placeholderColor: UIColor = UIColor(Colors.shared.black), isTapped: Binding<Bool>, keyboardType: UIKeyboardType? = .default, autoCapitilazied: UITextAutocapitalizationType? = UITextAutocapitalizationType.none, textColor: UIColor? = UIColor(Colors.shared.black), font: UIFont? = UIFont(name: "Nunito", size: 16)) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        self._isTapped = isTapped
        self.keyboardType = keyboardType
        self.autoCapitilazied = autoCapitilazied
        self.textColor = textColor
        self.font = font
    }

    func makeUIView(context: Context) -> UITextField {
        let textfield = getTextField()
        textfield.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textfield.delegate = context.coordinator
        return textfield
    }

    // from SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if uiView.text != "" {
            DispatchQueue.main.async {
                self.isTapped = true
            }
        }
    }

    private func getTextField() -> UITextField {
        let textfield = UITextField(frame: .zero)
        let placeholder = NSAttributedString(
            string: placeholder,
            attributes: [
                    .foregroundColor: placeholderColor
            ])

        textfield.attributedPlaceholder = placeholder
        textfield.textColor = textColor ?? UIColor(Colors.shared.black)
        textfield.font = font ?? UIFont(name: "Nunito", size: 16)
        textfield.keyboardType = keyboardType ?? .numberPad
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        textfield.leftView = paddingView
        textfield.autocapitalizationType = autoCapitilazied ?? .none
        textfield.autocorrectionType = .no
        textfield.leftViewMode = .always
        return textfield
    }

    func updatePlaceholder(_ text: String) -> CustomSearchBar {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }

    // from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isTapped: $isTapped)
    }

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        @Binding var isTapped: Bool


        init(text: Binding<String>, isTapped: Binding<Bool>) {
            self._text = text
            self._isTapped = isTapped
        }


        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return true
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.text = textField.text ?? ""
            }
        }



        func textFieldDidBeginEditing(_ textField: UITextField) {
            withAnimation(.easeIn) {
                // moving hint to top
                self.isTapped = true
            }
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            if textField.text == "" {
                withAnimation(.easeIn) {
                    self.isTapped = false
                    textField.endEditing(true)
                }
            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            let nextTag = textField.tag + 1

            if let nextResponder = textField.superview?.viewWithTag(nextTag) {
                nextResponder.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }


            if textField.text == "" {
                withAnimation(.easeIn) {
                    self.isTapped = false
                    textField.endEditing(true)
                }
            }

            return true
        }


    }
}


