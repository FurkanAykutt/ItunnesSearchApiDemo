//
//  ContentView.swift
//  BimserCase
//
//  Created by Ebubekir Aykut on 19.12.2022.
//

import SwiftUI
import Alamofire

// MARK: - Model

// MARK: - BimserCaseSuccessResponse
struct BimserCaseSuccessResponse: Codable {
    let resultCount: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let wrapperType: WrapperType?
    let kind: Kind?
    let collectionID, trackID: Int?
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let collectionArtistID: Int?
    let collectionArtistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice, trackRentalPrice, collectionHDPrice: Double?
    let trackHDPrice, trackHDRentalPrice: Double?
    let releaseDate: Date?
    let collectionExplicitness, trackExplicitness: Explicitness?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: Country?
    let currency: Currency?
    let primaryGenreName: String?
    let contentAdvisoryRating: ContentAdvisoryRating?
    let shortDescription, longDescription: String?
    let hasITunesExtras: Bool?
    let artistID: Int?
    let artistViewURL: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case collectionArtistID = "collectionArtistId"
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, shortDescription, longDescription, hasITunesExtras
        case artistID = "artistId"
        case artistViewURL = "artistViewUrl"
    }
}

enum Explicitness: String, Codable {
    case notExplicit = "notExplicit"
}

enum ContentAdvisoryRating: String, Codable {
    case pg = "PG"
    case pg13 = "PG-13"
    case r = "R"
    case unrated = "Unrated"
}

enum Country: String, Codable {
    case usa = "USA"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Kind: String, Codable {
    case featureMovie = "feature-movie"
}

enum WrapperType: String, Codable {
    case track = "track"
}


// MARK: - View Model

class SearchViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var selectedFilter: String = "Movies"
    @Published var results: [Result] = []

    func fetchResults(completion: @escaping (Result<BimserCaseSuccessResponse, Error>) -> ()) {
        // Construct the API endpoint URL with the search term and selected filter
        let url = "https://itunes.apple.com/search?term=\(searchTerm)&mediaType=\(selectedFilter)&limit=\(20)&offset=\(results.count)"
//        let parameters: [String: Any] = ["term": searchTerm, "media": selectedFilter, "limit": 20, "offset": results.count]
//        let url = endpoint + parameters.stringFromHttpParameters()
        print(url)
        // Make the GET request using Alamofire
        AF.request(url).responseDecodable(of: BimserCaseSuccessResponse.self) { response in
            switch response.result {
            case .success(let searchResults):
                completion(.success(searchResults))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - View

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        VStack(alignment: .leading) {
            // Search box
            HStack {
                TextField("Search...", text: $viewModel.searchTerm)
                Button(action: {
                    // Fetch results when the search button is tapped
                    self.viewModel.fetchResults { result in
                        switch result {
                        case .success(let searchResults):
                            self.viewModel.results.append(contentsOf: searchResults)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                }
            }
                .padding(.horizontal)

            // Filter options
            HStack(spacing: 16) {
                ForEach(["Movies", "Music", "Ebooks", "Podcasts"], id: \.self) { filter in
                    Button(filter) {
                        self.viewModel.selectedFilter = filter
                    }
                        .foregroundColor(self.viewModel.selectedFilter == filter ? .black : .gray)
                }
            }
                .padding(.horizontal)

            // Search results
            List {
                ForEach(viewModel.results, id: \.self) { result in
                    Text(result.collectionName)
//                    NavigationLink(destination: DetailView(result: result)) {
//                        SearchResultRow(result: result)
//
//
//                    }
                }
            }
        }
    }
}
//extension Dictionary {
//    func stringFromHttpParameters() -> String {
//        let parameterArray = map { (key, value) -> String in
//            let percentEscapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//            let percentEscapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//            return "\(percentEscapedKey)=\(percentEscapedValue)"
//        }
//
//        return parameterArray.joined(separator: "&")
//    }
//}
