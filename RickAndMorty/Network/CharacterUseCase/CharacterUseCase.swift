//
//  RickAndMortyCharacterUseCase.swift
//  RickAndMorty
//
//  Created by Gehad V on 25/08/2024.
//

import Foundation
import RxSwift

protocol CharacterUseCaseProtocol {
    func getAllCharacters(filter: [Filter]) async -> AllCharactersResponseModel?
    func getCharacterDetails(charId: Int) async ->Character?
}

class CharacterUseCase: CharacterUseCaseProtocol {
    var characterRepo: CharacterRepoProtocol
    
    init(characterRepo: CharacterRepoProtocol) {
        self.characterRepo = characterRepo
    }
    
    func getAllCharacters(filter: [Filter]) async -> AllCharactersResponseModel? {
        return await characterRepo.getAllCharacters(filter: filter)
    }
    
    func getCharacterDetails(charId: Int) async -> Character? {
        return await characterRepo.getCharacterDetails(charId: charId)
    }
    
}
