//
//  SearchPokemonViewController.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 6/10/23.
//

import Foundation
import UIKit

// MARK: - PROTOCOL -
protocol SearchPokemonViewProtocol: AnyObject {
    func navigateToDetail(with data: DetailModel?)
}

// MARK: - CLASS -
final class SearchPokemonViewController: UIViewController {
    
    var viewModel: SearchPokemonViewModelProtocol?
    
    // MARK: - PROPERTIES -
//    public var pokemons: [HomeCellModel] = [HomeCellModel]()
    
    public let searchPokemonTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchPokemonTableView)
        searchPokemonTableView.dataSource = self
        searchPokemonTableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchPokemonTableView.frame = view.bounds
    }
    
}

// MARK: - TABLE VIEW EXTENSION -
extension SearchPokemonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        if let data = viewModel?.data(at: indexPath.row) {
            cell.configure(with: data)
        }
//        cell.configure(with: pokemons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonName = viewModel?.getPokemonName(at: indexPath.row)
        viewModel?.onCellSelected(giving: pokemonName ?? "")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - PROTOCOL EXTENSION -
extension SearchPokemonViewController: SearchPokemonViewProtocol {
    func navigateToDetail(with data: DetailModel?) {
        let nextVC = DetailViewController()
        nextVC.viewModel = DetailViewModel(viewDelegate: nextVC, pokemon: data)
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .flipHorizontal
        present(nextVC, animated: true)
    }
}
