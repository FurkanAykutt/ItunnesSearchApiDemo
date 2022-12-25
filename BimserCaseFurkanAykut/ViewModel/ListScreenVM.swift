//
//  ListScreenVM.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import Foundation

class ListScreenVM: ObservableObject {

    //MARK: Properties
    @Published var searchTerm: String = ""
    @Published var selectedFilter: String = "Movies"
    @Published var results: [ItunnesResult] = []

    let limit: Int = 20
    var page: Int = 0

    @Published var isListLoaded: Bool = false
    @Published var isListLoading: Bool = false
    @Published var errorHappenedGetList: Bool = false
    @Published var errorMessage: String = ""


    //MARK: Get list method
    func getList() {
        let offset: Int = page * limit
        loading(loaded: &self.isListLoaded, loading: &self.isListLoading, error: &self.errorHappenedGetList)

        URLSession.shared.sendGetRequestWithParameter(Endpoints.shared.baseURL, parameters: ["term": searchTerm, "mediaType": selectedFilter.lowercased(), "limit": String(limit), "offset": String(offset)], type: ItunnesSuccessResponse.self, token: nil) { response in
            switch response {

            case .success(let result):
                DispatchQueue.main.async {
                    print(result)
                    loadSuccessfully(loaded: &self.isListLoaded, loading: &self.isListLoading, error: &self.errorHappenedGetList)
                    self.results.append(contentsOf: result.results ?? [])
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    errorHappened(error: &self.errorHappenedGetList, loading: &self.isListLoading)
                    self.errorMessage = "Beklenmedik bir hata oluştu."
                    print(error)
                }
            }
        }
    }
}
