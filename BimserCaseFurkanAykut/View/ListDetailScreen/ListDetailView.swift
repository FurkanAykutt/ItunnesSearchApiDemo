//
//  ListDetailView.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 25.12.2022.
//

import SwiftUI

struct ListDetailView: View {

    var item: ItunnesResult

    var body: some View {
        VStack {
            Text(item.artistName ?? "")
            Text(item.trackName ?? "")
            Text(item.country ?? "")
        }

    }
}
