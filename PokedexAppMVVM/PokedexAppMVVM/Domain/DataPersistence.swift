//
//  DataPersistence.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 6/10/23.
//

import Foundation

final class DataPersintence {
    
    // MARK: - SINGLETON -
    static let shared = DataPersintence()
    
    // MARK: - PROPERTIES -
    private var pokemonList: [PokemonGeneralData] = [PokemonGeneralData]()
    private var pokemonDataList: [PokemonData] = [PokemonData]()
    var sortedPokemonDataList: [PokemonData] {
        pokemonDataList.sorted { (pokemon1, pokemon2) in
            return extractNumber(pokemon1.sprites.other.home.frontDefault) < extractNumber(pokemon2.sprites.other.home.frontDefault)
        }
    }
    
    // MARK: - FUNCTIONS -
    func savePokemonList(pokemonList: [PokemonGeneralData]) {
        self.pokemonList = pokemonList
    }
    
    func getPokemonList() -> [PokemonGeneralData] {
        return pokemonList
    }
    
    func savePokemonDataList(pokemonDataList: [PokemonData]) {
        self.pokemonDataList = pokemonDataList
    }
    
    func getPokemonDataList() -> [PokemonData] {
        return pokemonDataList
    }
    
    private func extractNumber(_ url: String) -> Int {
        if let numberRange = url.range(of: "\\d+", options: .regularExpression) {
            if let number = Int(url[numberRange]) {
                return number
            }
        }
        return 0
    }
    
}
