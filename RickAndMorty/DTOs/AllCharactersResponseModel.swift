//
//  AllCharactersResponeModel.swift
//  RickAndMorty
//
//  Created by Gehad V on 25/08/2024.
//

import Foundation

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}


struct AllCharactersResponseModel: Decodable {
    let info: Info
    let results: [Character]
}
