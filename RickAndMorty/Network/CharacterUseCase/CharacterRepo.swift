//
//  RickAndMortyCharacterRepo.swift
//  RickAndMorty
//
//  Created by Gehad V on 25/08/2024.
//

import Foundation
import RxSwift

protocol CharacterRepoProtocol {
    mutating func getAllCharacters(filter: [Filter]) async -> AllCharactersResponseModel?
    mutating func getCharacterDetails(charId: Int) async -> Character?
}

class CharacterRepo: CharacterRepoProtocol {

    private lazy var store = CharacterStore()
    
    func getAllCharacters(filter: [Filter]) async -> AllCharactersResponseModel? {
        let router = CharacterRouter.allCharacter(filter)
        let response = await self.store.getAllCharacters(filter: filter, router: router)
        return response
    }
    
    func getCharacterDetails(charId: Int) async -> Character? {
        let response = await self.store.getCharacterDetails(id: charId, router: CharacterRouter.id(charId) )
        return response
    }
    
}
