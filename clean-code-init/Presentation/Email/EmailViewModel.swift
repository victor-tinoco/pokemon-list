//
//  EmailViewModel.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 13/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol EmailViewModelContract {
    var pokeList: Driver<[Pokemon]> { get }
    func didRequireEmail() -> String
    func didRequirePokemonsList()
    func getPokemon(index: Int) -> Pokemon
}

class EmailViewModel: EmailViewModelContract {
    private let pokeListRelay:BehaviorRelay<[Pokemon]> = BehaviorRelay(value: [])
    
    var pokeList: Driver<[Pokemon]> { return pokeListRelay.asDriver(onErrorJustReturn: []) }
    
    var userUseCase: UserUseCaseContract
    var pokeUseCase: PokemonUseCaseContract
    var disposeBag = DisposeBag()
    
    init(userUseCase: UserUseCaseContract, pokeUseCase: PokemonUseCaseContract) {
        self.userUseCase = userUseCase
        self.pokeUseCase = pokeUseCase
    }
    
    func didRequireEmail() -> String {
        return userUseCase.getEmail()?.email ?? ""
    }
    
    func didRequirePokemonsList() {
        pokeUseCase.getPokeList().subscribe(onSuccess: { (res) in
            self.pokeListRelay.accept(res)
        }).disposed(by: disposeBag)
    }
    
    func getPokemon(index: Int) -> Pokemon {
        return pokeListRelay.value[index]
    }
}
