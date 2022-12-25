//
//  ViewLoadingModifier.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import SwiftUI
import Foundation

@ViewBuilder
func ViewLoadedAndNoItemText(noItemDescription : String, image : String) -> some View {
    VStack( spacing: Dimension.shared.width * 0.01) {
        if image != ""{
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: Dimension.shared.width * 0.6)
        }
        
        Text("\(noItemDescription)")
            .foregroundColor(Colors.shared.black)
          //  .font(Fonts.shared.nunitoBold14)
    }//:Vstack
    .frame(width: Dimension.shared.width * 0.85)
    .generalBackgroundColor()
}

@ViewBuilder
func ViewLoading() -> some View {
    HStack{
        Spacer()
        Progress(color: Colors.shared.black)
        Spacer()
    }//: Hstack
    .generalBackgroundColor()
}
