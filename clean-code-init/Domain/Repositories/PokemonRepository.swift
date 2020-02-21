//
//  PokemonRepository.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 14/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol PokemonRepository {
    var pokeList: Single<[Pokemon]>  { get }
    func getPokemonDetails(url: URL) -> Single<PokemonDetails>
    func getPokemonImage(url: URL) -> Single<UIImage?>
}
