//
//  HomeViewController.swift
//  RickAndMorty
//
//  Created by Gehad V on 25/08/2024.
//

import UIKit
import RxSwift
import SwiftUI

class HomeViewController: UIViewController {

    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var charactersTableView: UITableView!
    var viewModel: HomeViewModelProtocol?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel()
        Task {
            await viewModel?.getAllCharacters()
        }
        self.setupUI()
        self.bind()
    }
    
    private func setupUI(){
        self.title = "Characters"
        self.setupCollectionView()
        self.setupTableView()
    }

    private func setupCollectionView() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.description())
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.selfSizingInvalidation = .enabledIncludingConstraints
    }
    
    private func setupTableView() {
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.description())

    }
    
    private func bind() {
        self.viewModel?.reloadDataSubject.asObservable().subscribe(onNext: { shouldReload in
            guard shouldReload != false else {return }
            DispatchQueue.main.async {
                self.charactersTableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
                                
    private func navigateToDetails(character: Character) {
        let detailsView = ChracterDetailsView(character: character)
        let hostingController = UIHostingController(rootView: detailsView)
        hostingController.view.backgroundColor = UIColor(red: 32/255, green: 35/255, blue: 41/255, alpha: 1)
        self.navigationController?.pushViewController(hostingController, animated: true)
    }
    
    @IBAction func removeFilterPressed(_ sender: Any)  {
        Task {
            await self.viewModel?.clearFilter()
            self.filterCollectionView.reloadData()
        }
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.filteringItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.description(), for: indexPath) as? FilterCollectionViewCell,
              let cellData = self.viewModel?.filteringItems[indexPath.row] else {return UICollectionViewCell()}
        cell.configure(with: cellData, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Task {
            await viewModel?.didChangeFilter(index: indexPath.row)
        }
    }
    
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.charactersCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.description(), for: indexPath) as? CharacterTableViewCell,
              let data = self.viewModel?.getCurrentCharacter(index: indexPath.row) else {  return UITableViewCell() }
        cell.configure(with: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCharacter = self.viewModel?.getCurrentCharacter(index: indexPath.row) else {return}
        self.navigateToDetails(character: selectedCharacter )
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let lastIndex = (self.viewModel?.charactersCount), indexPath.row == lastIndex-1 else {return}
        Task {
            await self.viewModel?.loadMore()
        }
    }
}
