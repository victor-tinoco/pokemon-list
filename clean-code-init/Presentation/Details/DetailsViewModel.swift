//
//  DetailsViewModel.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 14/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol DetailsViewModelContract {
    var pokeImage: Driver<UIImage?> { get }
    var pokeDetails: Driver<String?> { get }
    var pokeName: Driver<String?> { get }
    func didRequirePokemonDetails()
}

class DetailsViewModel: DetailsViewModelContract {
    private let simplePoke: Pokemon
    private let pokeDetailsRelay: BehaviorRelay<PokemonDetails?> = BehaviorRelay(value: nil)
    private let pokeImageRelay: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    
    var pokeImage: Driver<UIImage?> { return pokeImageRelay.asDriver(onErrorJustReturn: nil) }
    var pokeDetails: Driver<String?> { return pokeDetailsRelay.map{ "Com \($0?.height ?? 0) de altura, e com \($0?.weight ?? 0) de largura." }.asDriver(onErrorJustReturn: nil) }
    var pokeName: Driver<String?> { return pokeDetailsRelay.map{ $0?.name }.asDriver(onErrorJustReturn: nil) }
    var viewState: Driver<Bool> { return BehaviorRelay.zip(pokeDetailsRelay, pokeImageRelay).map{ _, _ in true }.asDriver(onErrorJustReturn: false) }
    
    var useCase: PokemonUseCaseContract
    var disposeBag = DisposeBag()
    
    init(simplePoke: Pokemon, useCase: PokemonUseCaseContract) {
        self.simplePoke = simplePoke
        self.useCase = useCase
    }
    
    func didRequirePokemonDetails() {
        return useCase.getPokeDetails(url: URL(string: simplePoke.url)!).subscribe(onSuccess: { (poke) in
            self.pokeDetailsRelay.accept(poke)
            self.useCase.getPokeImage(url: URL(string: poke.photoUrl ?? "")!).subscribe(onSuccess: { image in
//                self.pokeImageRelay.accept(image)
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
                    self.pokeImageRelay.accept(image)
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}
