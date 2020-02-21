//
//  File.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 14/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

struct PokemonDetailsAPIResponse: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: SpritesAPIResponse
}

struct SpritesAPIResponse: Codable{
    let frontDefault: String?
}

extension PokemonDetailsAPIResponse {
    func map() -> PokemonDetails {
        return PokemonDetails(id: self.id, name: self.name, height: self.height, weight: self.height, photoUrl: self.sprites.frontDefault)
    }
}
