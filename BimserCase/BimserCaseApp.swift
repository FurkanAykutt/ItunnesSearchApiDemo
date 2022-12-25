//
//  BimserCaseApp.swift
//  BimserCase
//
//  Created by Ebubekir Aykut on 19.12.2022.
//

import SwiftUI

@main
struct BimserCaseApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView(viewModel: SearchViewModel())
        }
    }
}
