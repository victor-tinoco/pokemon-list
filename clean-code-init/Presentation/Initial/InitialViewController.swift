//
//  InitialViewController.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 12/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class InitialViewController: UIViewController {
//  MARK: - IBOutlets
    @IBOutlet weak var nextPageButton: UIButton!
    
    var disposeBag = DisposeBag()
    var window = UIWindow()
    
//  MARK: - View Controller Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPageButton.rx.tap.bind { _ in
            let view = EmailViewModel(userUseCase: UserUseCase(userRepos: UserImpl()), pokeUseCase: PokemonUseCase(pokeRepos: PokemonImpl()))
            let vc = EmailViewController.instantiate(viewModel: view)
            let navig = UINavigationController(rootViewController: vc)
            self.window.rootViewController = navig
            self.window.makeKeyAndVisible()
        }.disposed(by: disposeBag)
    }
}
