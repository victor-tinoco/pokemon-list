//
//  UserImpl.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 13/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserImpl: UserRepository {
    let moyaService: MoyaService = MoyaService()
    
    var user: UserAPIResponse? {
        guard let x: UserAPIResponse = CacheService().retrieve(fromKey: "user_key") else { return nil }
        return x
    }
}
