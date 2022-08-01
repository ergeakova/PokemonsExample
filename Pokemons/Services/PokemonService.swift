//
//  PokemonService.swift
//  Pokemons
//
//  Created by Erge Gevher Akova on 1.08.2022.
//

import Foundation

class PokemonService: ObservableObject{
    static var shared = PokemonService()
    let defaultUrl = "https://pokeapi.co/api/v2/pokemon/"
    var urlString = "https://pokeapi.co/api/v2/pokemon/"
    var allPokemonCount = 0

    private init(){
        
    }
    
    func getResults() async throws -> Pokemons{
        print("url===>\(urlString)")
        var url =  URL(string: urlString)
        let (data, _ ) = try await URLSession.shared.data(from: url! )
        let result = try JSONDecoder().decode(Pokemons.self, from: data)
       
        
        if let allCount = result.count as? Int{
            allPokemonCount = allCount
        }
        
        if let next = result.next as? String {
            urlString = next
        }
        
        print("urlString===>\(urlString)")
        return result
     
    }
}
