//
//  Character.swift
//  RickAndMorty
//
//  Created by Gehad V on 22/08/2024.
//

import Foundation

class Character: Identifiable, Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: Gender
    let image: String
    let location: Location
}

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum Gender: String, Codable {
    //Female', 'Male', 'Genderless' or 'unknown'
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}



struct Location: Codable {
    let name: String
    let url: String
}

