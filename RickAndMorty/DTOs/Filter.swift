//
//  Filters.swift
//  RickAndMorty
//
//  Created by Gehad V on 25/08/2024.
//

import Foundation

enum Filter {
    case status(String)
    case page(Int)
    
    func queryParam() -> URLQueryItem {
        switch self {
        case .status(let status):
            return URLQueryItem(name: "status", value: status)

        case .page(let pageNum):
            return URLQueryItem(name: "page", value: "\(pageNum)")

        }
    }
}
