//
//  ListRowCard.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import SwiftUI

struct ListRowCard: View {
    //MARK: Properties
    var ImageUrl: String
    var collectionName: String
    var collectionPrice: Double
    var releaseDate: String

    var body: some View {
        VStack {
            KFImageView(image: ImageUrl, width: Dimension.shared.width * 0.2, height: Dimension.shared.width * 0.3)
                .padding(.horizontal)

                Text(collectionName)
                    .foregroundColor(Colors.shared.black)

                Text("\(collectionPrice, specifier: "%.2f") $")
                    .foregroundColor(Colors.shared.black)

                Text("\(formatDate(date: releaseDate))")
                    .foregroundColor(Colors.shared.black)
        }//:hstack
        .padding()
        .frame(width: Dimension.shared.width * 0.4, height: Dimension.shared.width * 0.7)
            .outherShadow()
    }//:body
    
    //MARK: Functions

    func formatDate(date: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate,.withFullTime]
        let date = dateFormatter.date(from: date)
        return date ?? Date()
    }
}

struct ListRowCard_Previews: PreviewProvider {
    static var previews: some View {
        ListRowCard(ImageUrl: "https://is4-ssl.mzstatic.com/image/thumb/Video113/v4/2c/75/fc/2c75fc0a-b2d9-1d15-8e4d-1022a98b261f/pr_source.lsr/100x100bb.jpg", collectionName: "Frozen", collectionPrice: 7.99, releaseDate: "2005-07-12T12:00:00Z")
    }
}
