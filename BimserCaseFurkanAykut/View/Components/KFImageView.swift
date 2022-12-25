//
//  KFImageView.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import SwiftUI
import Kingfisher

struct KFImageView: View {
    //MARK: PROPERTIES
    var image: String
    var foregroundColor: Color? = Colors.shared.black
    var width: CGFloat? = Dimension.shared.width * 0.1
    var height: CGFloat? = Dimension.shared.width * 0.25

    //MARK: BODY
    var body: some View {
        if image != "" {
            KFImage(URL(string: image))
                .placeholder { Progress() }
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .onProgress { receivedSize, totalSize in }
                .onSuccess { result in }
                .onFailure { error in }
                .resizable()
                .renderingMode(.original)
                .foregroundColor(foregroundColor)
                .scaledToFit()
                .frame(width: width, height: height)
        } else {
            ImageView(image: "noImage", width: width, height: height)
                .frame(width: width, height: height)
        }
    }
}

struct KFImageView_Previews: PreviewProvider {
    static var previews: some View {
        KFImageView(image: "https://is4-ssl.mzstatic.com/image/thumb/Video113/v4/2c/75/fc/2c75fc0a-b2d9-1d15-8e4d-1022a98b261f/pr_source.lsr/100x100bb.jpg")
    }
}
