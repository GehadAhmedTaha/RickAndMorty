//
//  CharacterRoute.swift
//  RickAndMorty
//
//  Created by Gehad V on 22/08/2024.
//

import Foundation

let baseUrl = "https://rickandmortyapi.com/api/character/"

enum CharacterRouter: Routable {
    
    case id(Int)
    case allCharacter([Filter])
    
    var path: String {
        switch self {
        case .id(let charId) :
            return "\(baseUrl)\(charId)"
        case .allCharacter(_):
            return baseUrl
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .id(_):
            return nil
        case .allCharacter(let filters):
            return  filters.map{$0.queryParam()}
        }
    }
    
    var httpMethod: String {
        switch self {
        default:
            return "GET"
        }
    }
    
}
