//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by Gehad V on 25/08/2024.
//

import Foundation
import RxSwift
protocol HomeViewModelProtocol {
    var reloadDataSubject: PublishSubject<Bool> {get}
    var charactersCount: Int {get}
    var filteringItems: [String] {get}
    var allCharacters: [Character] {get}
    mutating func getAllCharacters(filters: [Filter] ) async
    mutating func didChangeFilter(index: Int) async
    func getCurrentCharacter(index: Int) -> Character
}

extension HomeViewModelProtocol {
    mutating func getAllCharacters(filters: [Filter] = [Filter.page(0)] ) async -> () {
        return await getAllCharacters(filters: filters)
    }
}

struct HomeViewModel: HomeViewModelProtocol {
    
    private let useCase = CharacterUseCase(characterRepo: CharacterRepo())
    static var currentPage = 0
    var reloadDataSubject: PublishSubject<Bool> = PublishSubject()
    var allCharacters = [Character]()
    var filteringItems: [String] {
        return ["All","Alive", "Dead", "Unknown"]
    }
   
    var selectedFilterIdx = 0
 
    mutating internal func getAllCharacters(filters: [Filter] = [Filter.page(HomeViewModel.currentPage)]) async {
        guard let result = await useCase.getAllCharacters(filter: filters)?.results else {return }
        allCharacters.append(contentsOf: result)
        reloadDataSubject.onNext(true)
    }
    
    func getCurrentCharacter(index: Int) -> Character {
        return allCharacters[index]
    }
    
    var charactersCount: Int {
        return allCharacters.count
    }
    
    mutating func didChangeFilter(index: Int) async {
        selectedFilterIdx = filteringItems.enumerated().filter{$0.element == filteringItems[index]}.first.map{$0.offset} ?? 0
        HomeViewModel.currentPage = 0
        allCharacters.removeAll()
        await getAllCharacters(filters:[Filter.page(0), Filter.status(filteringItems[index])])
        reloadDataSubject.onNext(true)
    }
}
