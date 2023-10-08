//
//  Pokemon.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 4/10/23.
//

import Foundation

//struct PokemonModel {
//    let index: Int
//    let name: String
//    let photo: String
//    let height: Int
//    let weight: Int
//    let type: [String]
//}

struct PokemonGeneralData: Decodable {
    let name: String
    let url: String
}

struct PokemonsGeneralData: Decodable {
    let pokemons: [PokemonGeneralData]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pokemons = try container.decode([PokemonGeneralData].self, forKey: .results)
    }
}

struct PokemonData: Decodable {
    let height: Int
    let forms: [Forms]
    let stats: [Stat]
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int
}

// MARK: - Stat
struct Stat: Decodable {
    let baseStat: Int

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
    }
}

struct Forms: Decodable {
    let name: String
    let url: String
}

// MARK: - TypeElement
struct TypeElement: Decodable {
    let slot: Int
    let type: Species
}

// MARK: - Species
struct Species: Decodable {
    let name: String
    let url: String
}

// MARK: - Sprites
class Sprites: Decodable {
    let other: Other
}

// MARK: - Other
struct Other: Decodable {
    let home: Home
}

// MARK: - Home
struct Home: Decodable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}



// MARK: - PROVISIONAL - 
struct PokemonDescription: Decodable {
    let flavorTextEntries: [FlavorTextEntry]
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
    }
}
