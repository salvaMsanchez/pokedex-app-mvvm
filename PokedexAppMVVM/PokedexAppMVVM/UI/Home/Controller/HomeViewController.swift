//
//  HomeViewController.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 4/10/23.
//

import Foundation
import UIKit

// MARK: - PROTOCOL -
protocol HomeViewProtocol: AnyObject {
    func navigateToDetail(with data: DetailModel?)
}

// MARK: - CLASS -
final class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol?
    
    // MARK: - PROPERTIES -
//    public var pokemons: [HomeCellModel] = [HomeCellModel]()
    
    private let pokedexTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "homeBackground")
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchPokemonViewController())
        controller.searchBar.placeholder = "Search for a Pokémon"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    // MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pokédex"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(pokedexTableView)
        pokedexTableView.dataSource = self
        pokedexTableView.delegate = self
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .label

        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pokedexTableView.frame = view.bounds
    }
    
}

// MARK: - TABLE VIEW EXTENSION -
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataCount ?? 0
//        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        if let data = viewModel?.data(at: indexPath.row) {
            cell.configure(with: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel?.onCellSelected(at: indexPath.row)
        let pokemonName = viewModel?.getPokemonName(at: indexPath.row)
        viewModel?.onCellSelected(giving: pokemonName ?? "")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SEARCH CONTROLLER EXTENSION -
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar

        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchPokemonViewController else {
            return
        }

        let pokemonsSearched = SearchAlgorithm.searchPokemonAlgorithm(pokemons: viewModel?.getPokemons() ?? [], query: query)
        
        resultsController.viewModel = SearchPokemonViewModel(viewDelegate: resultsController, pokemons: pokemonsSearched)
        
//        resultsController.pokemons = pokemonsSearched
        resultsController.searchPokemonTableView.reloadData()

    }
}

// MARK: - PROTOCOL EXTENSION -
extension HomeViewController: HomeViewProtocol {
    func navigateToDetail(with data: DetailModel?) {
        let nextVC = DetailViewController()
        nextVC.viewModel = DetailViewModel(viewDelegate: nextVC, pokemon: data)
//        navigationController?.pushViewController(nextVC, animated: true)
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .flipHorizontal
        present(nextVC, animated: true)
    }
}
