//
//  HttpMethod.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import Foundation

final class HttpMethod {
    
    private init() { }

    static let shared = HttpMethod()

    let get = "GET"
    let post = "POST"
    let delete = "DELETE"
    let put = "PUT"

}
