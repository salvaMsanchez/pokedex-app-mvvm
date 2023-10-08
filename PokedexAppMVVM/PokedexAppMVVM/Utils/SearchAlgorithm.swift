//
//  searchAlgorithm.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 6/10/23.
//

import Foundation

final class SearchAlgorithm {
    
    // Función para calcular la similitud de Jaccard entre dos strings
    private static func jaccardSimilarity(_ s1: String, _ s2: String) -> Double {
        let set1 = Set(s1)
        let set2 = Set(s2)
        let intersection = set1.intersection(set2)
        let union = set1.union(set2)
        
        return Double(intersection.count) / Double(union.count)
    }

    // Función para encontrar todas las coincidencias cercanas en un array de strings usando la similitud de Jaccard
    private static func findNearestMatchesJaccard(input: String, options: [HomeCellModel]) -> [HomeCellModel] {
        var matches: [HomeCellModel] = [HomeCellModel]()
        let umbralSimilitud: Double = 0.65 
        
        for option in options {
            let similarity = jaccardSimilarity(input, option.name)
            if similarity >= umbralSimilitud {
                matches.append(option)
            }
        }
        
        return matches
    }
    
    static func searchPokemonAlgorithm(pokemons: [HomeCellModel], query: String) -> [HomeCellModel] {
        let matches = findNearestMatchesJaccard(input: query.lowercased(), options: pokemons.map { $0 })
        
        return matches
    }
    
}
