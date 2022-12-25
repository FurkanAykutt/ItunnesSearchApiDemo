//
//  ResponseHandleMethods.swift
//  BimserCaseFurkanAykut
//
//  Created by Ebubekir Aykut on 24.12.2022.
//

import Foundation

func errorHappened(error: inout Bool, loading: inout Bool) {
    error = true
    loading = false
}

func loadSuccessfully(loaded: inout Bool, loading: inout Bool, error: inout Bool) {
    error = false
    loading = false
    loaded = true
}

func loading(loaded: inout Bool, loading: inout Bool, error: inout Bool) {
    error = false
    loading = true
    loaded = false
}
