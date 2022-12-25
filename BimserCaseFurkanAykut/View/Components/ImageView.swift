//
//  ImageView.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import SwiftUI

struct ImageView: View {
    //MARK: PROPERTIES
    var image : String
    var foregroundColor : Color? = Colors.shared.black
    var width : CGFloat? = Dimension.shared.width * 0.1
    var height : CGFloat? = Dimension.shared.width * 0.1

    //MARK: BODY
    var body: some View {
        Image(image)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(foregroundColor)
            .scaledToFit()
            .frame(width: width, height: height)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(image: "noImage")
    }
}
