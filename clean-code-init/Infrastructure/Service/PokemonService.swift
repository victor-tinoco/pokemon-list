//
//  PokemonService.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 17/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation

class PokemonListService: MoyaService {
    
    override var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2/")!
    }
    
    override var path: String {
        return "pokemon/"
    }
}

class PokemonDetailsService: MoyaService {
    
    var pokemonURL: URL
    
    init(pokemonURL: URL) {
        self.pokemonURL = pokemonURL
    }
    
    override var baseURL: URL {
        return pokemonURL
    }
}
