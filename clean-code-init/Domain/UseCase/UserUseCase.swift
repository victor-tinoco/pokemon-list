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

protocol UserUseCaseContract {
    func getEmail() -> User?
}

class UserUseCase: UserUseCaseContract {
    
    private var userRepos: UserRepository
    private var disposeBag = DisposeBag()
    
    init(userRepos: UserRepository) {
        self.userRepos = userRepos
    }
    
    func getEmail() -> User? {
        return userRepos.user?.map()
    }
}
