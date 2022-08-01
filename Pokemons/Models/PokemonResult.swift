//
//  PokemonResult.swift
//  Pokemons
//
//  Created by Erge Gevher Akova on 1.08.2022.
//

import Foundation

struct Pokemons: Codable{
    let count: Int
    let next: String
    let results: [Result]
}

struct Result: Codable{
    let name: String
    let url: String
}

struct PokemonStats: Codable{
    let name: String
    let sprites: Sprite
    let Stats: [Stats]
}

struct Sprite: Codable{
    let front_default: String
}

struct Stats: Codable{
    let base_state: Int
    let stat: stat
}

struct Stat: Codable{
    let name: String
}
