//
//  HomeViewModel.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 5/10/23.
//

import Foundation

// MARK: - PROTOCOL -
protocol HomeViewModelProtocol {
    var dataCount: Int { get }
    func onCellSelected(giving name: String)
    func data(at index: Int) -> HomeCellModel?
    func data(with name: String) -> HomeCellModel?
    func getPokemons() -> [HomeCellModel]
    func getPokemonName(at index: Int) -> String
}

// MARK: - CLASS -
final class HomeViewModel {
    
    public var pokemons: [HomeCellModel] = [HomeCellModel]()
    
    private weak var viewDelegate: HomeViewProtocol?
    init(viewDelegate: HomeViewProtocol? = nil, pokemons: [HomeCellModel]) {
        self.viewDelegate = viewDelegate
        self.pokemons = pokemons
    }
    
}

// MARK: - EXTENSION -
extension HomeViewModel: HomeViewModelProtocol {
    func getPokemonName(at index: Int) -> String {
        return pokemons[index].name
    }
    
    func data(with name: String) -> HomeCellModel? {
        for pokemon in pokemons {
            if pokemon.name == name {
                return pokemon
            }
        }
        return HomeCellModel(index: 0, name: "", type: "", photo: "")
    }
    
    var dataCount: Int {
        pokemons.count
    }
    
    func getPokemons() -> [HomeCellModel] {
        return pokemons
    }
    
    func data(at index: Int) -> HomeCellModel? {
        guard index < dataCount else {
            return nil
        }
        return pokemons[index]
    }
    
    func onCellSelected(giving name: String) {
        APIClient.shared.getPokemonDescription(with: name) { [weak self] result in
            switch result {
                case .success(let pokemonDescription):
                    guard let data = self?.data(with: name) else {
                        return
                    }
                    let description = pokemonDescription.flavorTextEntries[0].flavorText.replacingOccurrences(of: "\n", with: " ")
                    let descriptionCleaned = description.replacingOccurrences(of: "\u{0C}", with: " ")
                    let detailModel = Mapper.toDetailModel(with: data.index - 1,
                                                           and: descriptionCleaned)
                    DispatchQueue.main.async {
                        self?.viewDelegate?.navigateToDetail(with: detailModel)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
