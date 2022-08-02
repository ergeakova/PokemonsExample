//
//  PokemonsResultModel.swift
//  Pokemons
//
//  Created by Erge Gevher Akova on 1.08.2022.
//

import Foundation

struct PokemonsResultModel: Codable{
    let count: Int
    let next: String
    let results: [ResultModel]
}

