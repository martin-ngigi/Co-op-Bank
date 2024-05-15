//
//  FetchState.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

enum FetchState: Comparable{
    case good
    case isLoading
    case noResults
    case error(String)
}
