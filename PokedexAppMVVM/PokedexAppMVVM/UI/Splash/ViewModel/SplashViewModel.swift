//
//  SplashViewModel.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 5/10/23.
//

import Foundation
import UIKit

// MARK: - PROTOCOL -
protocol SplashViewModelProtocol {
    func onViewsLoaded()
}

// MARK: - CLASS -
final class SplashViewModel {
    
    private var pokemonList: [PokemonGeneralData] = [PokemonGeneralData]()
    private var pokemons: [HomeCellModel] = [HomeCellModel]()
    
    private weak var viewDelegate: SplashViewProtocol?
    init(viewDelegate: SplashViewProtocol? = nil) {
        self.viewDelegate = viewDelegate
    }
    
    private func loadData() {
        viewDelegate?.showLoading(true)
        APIClient.shared.getPokemons { [weak self] result in
            switch result {
                case .success(let pokemonList):
                    self?.pokemonList = pokemonList
                    DataPersintence.shared.savePokemonList(pokemonList: pokemonList)
                    self?.loadComplexData()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func loadComplexData() {
        let dispatchGroup = DispatchGroup()
        var pokemonDataList = [PokemonData]()
        pokemonList.forEach { pokemon in
            dispatchGroup.enter()
            APIClient.shared.getPokemonData(with: pokemon.url) { result in
                defer {
                    dispatchGroup.leave()
                }
                switch result {
                    case .success(let pokemonData):
                        pokemonDataList.append(pokemonData)
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            DataPersintence.shared.savePokemonDataList(pokemonDataList: pokemonDataList)
            self?.apiCallFinished()
        }
    }
    
    private func apiCallFinished() {
        let pokemonDataListSorted = DataPersintence.shared.sortedPokemonDataList
        pokemons = Mapper.toHomeCellModel(with: pokemonDataListSorted)
        viewDelegate?.navigateToHome(pokemons: pokemons)
    }
    
}

// MARK: - EXTENSION -
extension SplashViewModel: SplashViewModelProtocol {
    func onViewsLoaded() {
        loadData()
    }
}
