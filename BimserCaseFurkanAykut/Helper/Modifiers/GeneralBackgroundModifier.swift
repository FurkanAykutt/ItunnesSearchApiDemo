//
//  GeneralBackgroundModifier.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import SwiftUI

struct GeneralBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Colors.shared.beige)
    }
}

extension View {
    func generalBackgroundColor() -> some View {
        modifier(GeneralBackgroundColor())
    }
}
