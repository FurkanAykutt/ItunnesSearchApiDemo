//
//  AlertModifier.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 25.12.2022.
//

import SwiftUI

struct ErrorHandlingAlertWithOneAction: ViewModifier {
    //MARK: PROPERTIES
    var message: String
    @Binding var isPresented: Bool
    var actionDone: () -> Void

    //MARK: BODY
    func body(content: Content) -> some View {
        content
            .alert(message, isPresented: $isPresented, actions: {
            Button("Tamam") {
                actionDone()
            }
        })
    }
}

extension View {
    func customAlertWithOneAction(message: String, isPresented: Binding<Bool>, actionDone: @escaping () -> Void) -> some View {
        modifier(ErrorHandlingAlertWithOneAction(message: message, isPresented: isPresented, actionDone: actionDone))
    }
}
