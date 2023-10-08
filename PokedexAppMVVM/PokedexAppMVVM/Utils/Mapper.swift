//
//  Mapper.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 5/10/23.
//

import Foundation

final class Mapper {
    
    static func toHomeCellModel(
        with pokemonDataList: [PokemonData]
    ) -> [HomeCellModel] {
        var homeCellModelList: [HomeCellModel] = [HomeCellModel]()
        pokemonDataList.enumerated().forEach { index, pokemon in
            let homeCellModelElement: HomeCellModel = HomeCellModel(index: index + 1,
                                                                    name: pokemon.forms[0].name,
                                                                    type: pokemon.types[0].type.name,
                                                                    photo: pokemon.sprites.other.home.frontDefault)
            homeCellModelList.append(homeCellModelElement)
        }
        return homeCellModelList
    }
    
    static func toDetailModel(
        with index: Int,
        and description: String
    ) -> DetailModel {
        let pokemonDataList = DataPersintence.shared.sortedPokemonDataList
        if !pokemonDataList.isEmpty {
            let pokemonData: PokemonData = pokemonDataList[index]
            let pokemonType: String = pokemonData.types[0].type.name
            let detailModel: DetailModel = .init(name: pokemonData.forms[0].name,
                                                 photo: pokemonData.sprites.other.home.frontDefault,
                                                 height: pokemonData.height,
                                                 weight: pokemonData.weight,
                                                 attack: pokemonData.stats[1].baseStat,
                                                 defense: pokemonData.stats[2].baseStat,
                                                 type: pokemonType,
                                                 description: description)
            return detailModel
        }
        return .init(name: "", photo: "", height: 0, weight: 0, attack: 0, defense: 0, type: "", description: "")
    }
      
}
