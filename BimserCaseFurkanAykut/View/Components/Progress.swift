//
//  Progress.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//
import SwiftUI

struct Progress: View {
    var color: Color? = Colors.shared.black
    var width = UIScreen.main.bounds.width
    var body: some View {
        ProgressView()
            .frame(width: width * 0.2, height: width * 0.2, alignment: .center)
            .tint(color ?? Colors.shared.black)
    }
}
