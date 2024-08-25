//
//  HomeViewController.swift
//  RickAndMorty
//
//  Created by Gehad V on 25/08/2024.
//

import UIKit
import RxSwift

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
        filterCollectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")

    }
    
    private func setupTableView() {
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")

    }
    
    private func bind() {
        self.viewModel?.reloadDataSubject.asObservable().subscribe(onNext: { shouldReload in
            guard shouldReload != false else {return }
            DispatchQueue.main.async {
                self.charactersTableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
                                                                       
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.filteringItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as? FilterCollectionViewCell ?? UICollectionViewCell()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as? FilterTableViewCell ?? UITableViewCell()
        return cell
    }
    
    
}
