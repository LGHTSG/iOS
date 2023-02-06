//
//  user.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/28.
//

import Foundation
// MARK: - Model

struct user : Decodable {
    let body : body

    struct body : Decodable {
        let email : String
        let name : String
    }
}
