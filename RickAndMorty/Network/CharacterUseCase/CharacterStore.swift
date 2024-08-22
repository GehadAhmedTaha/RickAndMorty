//
//  CharacterStore.swift
//  RickAndMorty
//
//  Created by Gehad V on 25/08/2024.
//

import Foundation
import RxSwift


class CharacterStore {
    
    func getAllCharacters(filter: [Filter], router: Routable) async -> AllCharactersResponseModel?{
        do {
            let response = try await NetworkManager(baseUrl: router.path).performRequest(router: router, decodeTo: AllCharactersResponseModel.self)
            return response
        } catch {
            return nil
        }
    }
    
    func getCharacterDetails(id: Int, router: Routable) async -> Character? {
        do {
            let response = try await NetworkManager(baseUrl: router.path).performRequest(router: router, decodeTo: Character.self)
            return response
        } catch {
            return nil
        }

    }
    
}
