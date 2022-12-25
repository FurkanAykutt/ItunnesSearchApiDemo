//
//  ItunnesSuccessResponse.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import Foundation

// MARK: - ItunnesSuccessResponse
struct ItunnesSuccessResponse: Codable {
    let resultCount: Int?
    let results: [ItunnesResult]?
}

// MARK: - Result
struct ItunnesResult: Codable,Hashable {
    let wrapperType: String?
    let kind: String?
    let collectionId, trackId: Int?
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let collectionArtistId: Int?
    let collectionArtistViewUrl, collectionViewUrl, trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice, trackRentalPrice, collectionHdPrice: Double?
    let trackHdPrice, trackHdRentalPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let contentAdvisoryRating: String?
    let shortDescription, longDescription: String?
    let hasITunesExtras: Bool?
    let artistId: Int?
    let artistViewUrl: String?
}
