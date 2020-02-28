//
//  DI.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 21/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation
import UIKit

class DI {
    var window: UIWindow?
    var navig: UINavigationController?
    
    func start() -> InitialViewController {
        let vc =  InitialViewController.instantiate(delegate: self)
        return vc
    }
}

extension DI: InitialViewControllerDelegate {
    func didRequireNextPage() -> UIViewController {
        let view = EmailViewModel(userUseCase: UserUseCase(userRepos: UserImpl()), pokeUseCase: PokemonUseCase(pokeRepos: PokemonImpl()))
        let vc = EmailViewController.instantiate(viewModel: view, delegate: self)
        return vc
    }
}

extension DI: EmailViewControllerDelegate {
    func didSelectPokemon(simplePokemon: Pokemon) -> UIViewController {
        let vm = DetailsViewModel(simplePoke: simplePokemon, useCase: PokemonUseCase(pokeRepos: PokemonImpl()))
        let vc = DetailsViewController.instantiate(viewModel: vm)
        return vc
    }
}
