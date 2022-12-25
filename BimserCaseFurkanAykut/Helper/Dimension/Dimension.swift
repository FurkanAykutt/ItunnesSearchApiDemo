//
//  Dimension.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import SwiftUI

final class Dimension {

    private init() { }

    static let shared = Dimension()

    let width = UIScreen.main.bounds.width
    let heigth = UIScreen.main.bounds.height

}
