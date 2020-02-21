//
//  UserUseCase.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 13/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol PokemonUseCaseContract {
    func getPokeList() -> Single<[Pokemon]>
    func getPokeDetails(url: URL) -> Single<PokemonDetails>
    func getPokeImage(url: URL) -> Single<UIImage?>
}

class PokemonUseCase: PokemonUseCaseContract {
    private var pokeRepos: PokemonRepository
    private var disposeBag = DisposeBag()
    
    init(pokeRepos: PokemonRepository) {
        self.pokeRepos = pokeRepos
    }
    
    func getPokeList() -> Single<[Pokemon]> {
        return pokeRepos.pokeList
    }
    
    func getPokeDetails(url: URL) -> Single<PokemonDetails> {
        return pokeRepos.getPokemonDetails(url: url)
    }
    
    func getPokeImage(url: URL) -> Single<UIImage?> {
        return pokeRepos.getPokemonImage(url: url)
    }
}
