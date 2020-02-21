//
//  DetailsViewController.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 14/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailsViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var viewModel: DetailsViewModelContract!
    var poke: Pokemon?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didRequirePokemonDetails()
        bind()
    }
    
    static func instantiate(viewModel: DetailsViewModelContract) -> DetailsViewController {
        let vc = DetailsViewController(nibName: nil, bundle: nil)
        vc.viewModel = viewModel
        return vc
    }
    
    func bind() {
        viewModel.pokeName.drive(nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.pokeDetails.drive(descriptionLabel.rx.text).disposed(by: disposeBag)
        viewModel.pokeImage.drive(profileImageView.rx.image).disposed(by: disposeBag)
    }
    
    func setup() {
        cardView.layer.cornerRadius = 20
    }
}
