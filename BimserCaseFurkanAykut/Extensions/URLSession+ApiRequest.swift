//
//  URLSession+ApiRequest.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import SwiftUI
import Foundation


extension URLSession {

    func sendGetRequestWithParameter<T: Codable>(_ url: String, parameters: [String: String?], type: T.Type, token: String?, completionHandler: @escaping (Result<T, Error>) -> Void) {
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)

        request.httpMethod = HttpMethod.shared.get
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("ios", forHTTPHeaderField: "application")
        request.setValue("tr", forHTTPHeaderField: "srvslt-locale")

        if (token != nil) {
            request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse,
                let error = self.checkStatus(response.statusCode) {
                completionHandler(.failure(error))
            }

            if let data = data {
                do {
                    let result = try JSONDecoder().decode(type.self, from: data)
                    completionHandler(.success(result))
                    return
                }
                catch {
                    print(error)
                    completionHandler(.failure(NetworkError.unableToParse))
                    return
                }
            }
            print(error?.localizedDescription)
            completionHandler(.failure(NetworkError.noData))
        }
        task.resume()

        print("\(components)")
        print("REQUEST : \(request)")
        print("PARAMS : \(String(describing: parameters))")
    }
 

    private func checkStatus(_ status: Int) -> NetworkError? {
        switch status {
        case 200...399:
            print(status)
            print("Success")
            return nil
        case 400...499:
            print(status)
            print(NetworkError.badRequest.errorDescription)
            return .badRequest
        case 404:
            print(status)
            print(NetworkError.notFound.errorDescription)
            return .notFound
        case 500...599:
            print(status)
            print(NetworkError.serverError.errorDescription)
            return .serverError
        default:
            print(status)
            print(NetworkError.unknown.errorDescription)
            return .unknown
        }
    }

    enum NetworkError: LocalizedError {

        case invalidEndpoint
        case unableToComplete
        case badRequest
        case notFound
        case serverError
        case noData
        case unableToParse
        case unknown

        var errorDescription: String {
            switch self {
            case .invalidEndpoint:
                return "Endpoint URL is invalid"
            case .unableToComplete:
                return "Could not complete operation"
            case .badRequest:
                return "Bad request"
            case .notFound:
                return "Not found"
            case .serverError:
                return "Internal server error"
            case .noData:
                return "No data on response"
            case .unableToParse:
                return "Unable to parse response data"
            default:
                return "Unknown error"
            }
        }

    }
}

