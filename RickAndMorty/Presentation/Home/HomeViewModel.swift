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
    mutating func getAllCharacters(filters: [Filter] ) async
    mutating func didChangeFilter(index: Int) async
    func getCurrentCharacter(index: Int) -> Character
    mutating func loadMore() async
    mutating func clearFilter() async
}

extension HomeViewModelProtocol {
    mutating func getAllCharacters(filters: [Filter] = [Filter.page(0)] ) async -> () {
        return await getAllCharacters(filters: filters)
    }
}

struct HomeViewModel: HomeViewModelProtocol {
    
    private let useCase = CharacterUseCase(characterRepo: CharacterRepo())
    private var info: Info?
    private var currentPage = 0
    var reloadDataSubject: PublishSubject<Bool> = PublishSubject()
    private var allCharacters = [Character]()
    var filteringItems: [String] {
        return ["Alive", "Dead", "Unknown"]
    }
   
    var selectedFilterIdx = -1
 
    mutating internal func getAllCharacters(filters: [Filter] = [Filter.page(0)]) async {
        guard let result = await useCase.getAllCharacters(filter: filters) else {return }
        info = result.info
        allCharacters.append(contentsOf: result.results)
        reloadDataSubject.onNext(true)
    }
    
    func getCurrentCharacter(index: Int) -> Character {
        return allCharacters[index]
    }
    
    var charactersCount: Int {
        return allCharacters.count
    }
    
    mutating func didChangeFilter(index: Int) async {
        self.currentPage = 0
        allCharacters.removeAll()
        if index < 0 || index > filteringItems.count - 1 {
            await getAllCharacters(filters:[Filter.page(currentPage)])
        } else {
            await getAllCharacters(filters:[Filter.page(currentPage), Filter.status(filteringItems[index])])
        }
        selectedFilterIdx = index
        reloadDataSubject.onNext(true)

    }
    
    mutating func loadMore() async {
        guard let totalPages = self.info?.pages else {return}
        if currentPage < totalPages {
            currentPage += 1
            var filters = [Filter.page(currentPage)]
            if selectedFilterIdx >= 0 {
                filters.append(Filter.status(filteringItems[selectedFilterIdx]))
            }
            await getAllCharacters(filters:[Filter.page(currentPage)])
            reloadDataSubject.onNext(true)
        }
    }
    
    mutating func clearFilter() async {
        await didChangeFilter(index: -1)
    }
    
}
