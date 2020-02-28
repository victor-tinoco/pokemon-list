//
//  EmailViewController.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 13/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol EmailViewControllerDelegate {
    func didSelectPokemon(simplePokemon: Pokemon) -> UIViewController
}

class EmailViewController: UIViewController {
//  MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
//  MARK: - Variables
    private var _delegate: EmailViewControllerDelegate!
    private var _window: UIWindow?
    
    var viewModel: EmailViewModelContract!
    var pokeList: [Pokemon] = []
    var disposeBag = DisposeBag()
    
//  MARK: - View Controller Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = viewModel.didRequireEmail()
        viewModel.didRequirePokemonsList()
        bind()
    }
    
    static func instantiate(viewModel: EmailViewModelContract, delegate: EmailViewControllerDelegate) -> EmailViewController {
        let vc = EmailViewController(nibName: nil, bundle: nil)
        vc.viewModel = viewModel
        vc._delegate = delegate
        return vc
    }
    
    private func bind() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
        viewModel.pokeList.map{ $0 }.drive(tableView.rx.items(cellIdentifier: "cell")) { index, model, cell in
            cell.textLabel?.text = model.name
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.bind { indexPath in
            self.viewModel.didRequirePokemonsList()
            let pokemon = self.viewModel.getPokemon(index: indexPath.row)
            let vc = self._delegate.didSelectPokemon(simplePokemon: pokemon)
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }
}
