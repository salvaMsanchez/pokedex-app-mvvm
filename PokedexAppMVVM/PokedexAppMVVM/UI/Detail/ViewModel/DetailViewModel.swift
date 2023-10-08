//
//  DetailViewModel.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 6/10/23.
//

import Foundation

// MARK: - PROTOCOL -
protocol DetailViewModelProtocol {
    var pokemonDetailData: DetailModel { get }
    func onViewsLoaded()
}

// MARK: - CLASS -
final class DetailViewModel {
    
    private weak var viewDelegate: DetailViewProtocol?
    public var pokemon: DetailModel?
    
    init(viewDelegate: DetailViewProtocol? = nil, pokemon: DetailModel? = nil) {
        self.viewDelegate = viewDelegate
        self.pokemon = pokemon
    }
    
    func loadData() {
        viewDelegate?.configureDetailData()
    }
    
}

// MARK: - EXTENSION -
extension DetailViewModel: DetailViewModelProtocol {
    func onViewsLoaded() {
        loadData()
    }
    
    var pokemonDetailData: DetailModel {
        guard let pokemon else {
            return .init(name: "", photo: "", height: 0, weight: 0, attack: 0, defense: 0, type: "", description: "")
        }
        return pokemon
    }
}
