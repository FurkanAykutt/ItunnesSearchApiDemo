//
//  OutherShadowModifier.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import Foundation
import SwiftUI

struct OutherShadow : ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Colors.shared.beige)
            .cornerRadius(Radius.shared.radius10)
            .shadow(color: .white, radius: 3, x: -2, y: -2)
            .shadow(color: .gray.opacity(0.4), radius: 3, x: 2, y: 2)
    }
}

extension View {
    func outherShadow() -> some View {
        modifier(OutherShadow())
    }
}
