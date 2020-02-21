//
//  PokemonListAPIResponse.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 14/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation

struct PokemonListAPIResponse: Codable {
    let count: Int
    let next:  String
    let previous: String?
    let results: [PokemonAPIResponse]
}

extension PokemonListAPIResponse {
    func map() -> [Pokemon] {
        var list: [Pokemon] = []
        
        self.results.forEach { (poke) in
            list.append(Pokemon(name: poke.name, url: poke.url))
        }
        
        return list
    }
}
