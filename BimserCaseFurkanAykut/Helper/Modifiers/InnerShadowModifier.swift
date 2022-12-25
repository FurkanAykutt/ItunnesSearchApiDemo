//
//  InnerShadowModifier.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import SwiftUI

struct InnerShadowModifier: ViewModifier {
    @State var radius: CGFloat = 10
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(Colors.shared.beige, lineWidth: 4)
                    .shadow(color: .gray.opacity(0.4) , radius: 3, x: 2, y: 2)
                    .shadow(color: .white, radius: 3, x: -2, y: -2)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
            )
    }
}

extension View {
    func innerShadow() -> some View {
        modifier(InnerShadowModifier())
    }
}
