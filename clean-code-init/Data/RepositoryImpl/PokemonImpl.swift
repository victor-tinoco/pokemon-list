//
//  PokemonImpl.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 14/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PokemonImpl: PokemonRepository {
    let listService = PokemonListService()
    var detailsService: PokemonDetailsService?
    
    var pokeList: Single<[Pokemon]> {
        let pokemon: Single<PokemonListAPIResponse> = listService.getDecodedResponse()
        return pokemon.map { (apiRespo) in
            return apiRespo.map()
        }
    }
    
    func getPokemonDetails(url: URL) -> Single<PokemonDetails> {
        detailsService = PokemonDetailsService(pokemonURL: url)
        let pokemon: Single<PokemonDetailsAPIResponse> = detailsService!.getDecodedResponse()
        return pokemon.map { (apiRespo) in
            return apiRespo.map()
        }
    }
    
    func getPokemonImage(url: URL) -> Single<UIImage?> {
        detailsService = PokemonDetailsService(pokemonURL: url)
        let pokemon: Single<Data> = detailsService!.getDataResponse()
        return pokemon.map { UIImage(data: $0) }
    }
}
