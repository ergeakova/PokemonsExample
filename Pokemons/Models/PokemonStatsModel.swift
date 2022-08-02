//
//  PokemonStatsModel.swift
//  Pokemons
//
//  Created by Erge Gevher Akova on 2.08.2022.
//

import Foundation

struct PokemonStatsModel: Codable{
    let name: String
    let sprites: SpriteModel
    let stats: [StatsModel]
}
