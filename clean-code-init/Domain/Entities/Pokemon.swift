
//
//  File.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 13/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct PokemonDetails: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let photoUrl: String?
}
