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

protocol InitialViewControllerDelegate {
    func didRequireNextPage() -> UIViewController
}

class InitialViewController: UIViewController {
//  MARK: - IBOutlets
    @IBOutlet weak var nextPageButton: UIButton!
    
    private var _delegate: InitialViewControllerDelegate?
    private var _window: UIWindow?
    
    var disposeBag = DisposeBag()
    
//  MARK: - View Controller Life Cicle
    static func instantiate(delegate: InitialViewControllerDelegate) -> InitialViewController {
        let vc = InitialViewController()
        vc._delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPageButton.rx.tap.bind { _ in
            let vc = self._delegate?.didRequireNextPage()
            self._window = UIWindow()
            let navig = UINavigationController(rootViewController: vc!)
            self._window?.rootViewController = navig
            self._window?.makeKeyAndVisible()
        }.disposed(by: disposeBag)
    }
}
