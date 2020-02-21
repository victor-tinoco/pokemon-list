//
//  UserAPIResponse.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 12/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation

struct UserAPIResponse: Codable {
    let email: String
    let age: Int
    let birthday: Date
}

extension UserAPIResponse {
    func map() -> User {
        return User(email: self.email)
    }
}
