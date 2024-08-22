//
//  Routable.swift
//  RickAndMorty
//
//  Created by Gehad V on 25/08/2024.
//

import Foundation

protocol Routable {
    var path: String {get}
    var queryItems: [URLQueryItem]? {get}
    var httpMethod: String {get}
}
