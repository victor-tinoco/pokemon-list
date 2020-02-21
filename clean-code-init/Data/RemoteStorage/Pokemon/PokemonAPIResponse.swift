//
//  PokemonAPIResponse.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 13/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation

struct PokemonAPIResponse: Codable {
    let name: String
    let url: String
}

extension PokemonAPIResponse {
    func map() -> Pokemon {
        return Pokemon(name: self.name, url: self.url)
    }
}
