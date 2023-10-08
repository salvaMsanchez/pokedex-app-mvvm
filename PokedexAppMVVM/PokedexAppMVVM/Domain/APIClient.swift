//
//  APIClient.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 4/10/23.
//

import Foundation

struct Constants {
    static let baseURL = "https://pokeapi.co/api/v2/"
}

enum APIError: Error {
    case urlError
    case decodingFailed
    case errorNil
    case noData
    case statusCode(code: Int?)
    case indexError
}

final class APIClient {
    
    // MARK: - SINGLETON -
    static let shared = APIClient()
    
    // MARK: - GET POKEMONS -
    func getPokemons(completion: @escaping (Result<[PokemonGeneralData], APIError>) -> Void) {

        guard let url = URL(string: "\(Constants.baseURL)pokemon/?offset=0&limit=151") else {
            completion(.failure(.urlError))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard error == nil else {
                completion(.failure(.errorNil))
                return
            }

            guard let data else {
                completion(.failure(.noData))
                return
            }

            let httpResponse = response as? HTTPURLResponse
            let statusCode = httpResponse?.statusCode
            guard statusCode == 200 else {
                completion(.failure(.statusCode(code: statusCode)))
                return
            }

            do {
                let results = try JSONDecoder().decode(PokemonsGeneralData.self, from: data)
                completion(.success(results.pokemons))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }

        task.resume()

    }
    
    // MARK: - GET POKEMON DATA -
    func getPokemonData(
        with pokemonURLData: String,
        completion: @escaping (Result<PokemonData, APIError>) -> Void
    ) {
        guard let url = URL(string: pokemonURLData) else {
            completion(.failure(.urlError))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard error == nil else {
                completion(.failure(.errorNil))
                return
            }
            guard let data else {
                completion(.failure(.noData))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            let statusCode = httpResponse?.statusCode
            guard statusCode == 200 else {
                completion(.failure(.statusCode(code: statusCode)))
                return
            }
            do {
                let results = try JSONDecoder().decode(PokemonData.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }

        task.resume()
    }
    
    // MARK: - GET POKEMON DESCRIPTION -
    func getPokemonDescription(
        with pokemonDataName: String,
        completion: @escaping (Result<PokemonDescription, APIError>) -> Void
    ) {
        guard let url = URL(string: "\(Constants.baseURL)pokemon-species/\(pokemonDataName)/") else {
            completion(.failure(.urlError))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard error == nil else {
                completion(.failure(.errorNil))
                return
            }
            guard let data else {
                completion(.failure(.noData))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            let statusCode = httpResponse?.statusCode
            guard statusCode == 200 else {
                completion(.failure(.statusCode(code: statusCode)))
                return
            }
            do {
                let results = try JSONDecoder().decode(PokemonDescription.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }

        task.resume()
    }
    
}
