//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Gehad V on 21/08/2024.
//

import UIKit

class ViewController: UIViewController {

    var useCase : CharacterUseCase?
    override func viewDidLoad() {
        super.viewDidLoad()
        useCase = CharacterUseCase(characterRepo: CharacterRepo())
    }

    func testNetwork () async throws -> [Character]? {
        let pageFilter = Filter.page(1)
        let speciesFilter = Filter.status("Alive")
        return await useCase?.getAllCharacters(filter: [pageFilter, speciesFilter])?.results
//        return await useCase?.getCharacterDetails(charId: 2)
    }
    
    @IBAction func test(_ sender: Any) {
        Task {
            do {
                try await self.testNetwork()
            } catch {
                print("")
            }
        }
    }
}

