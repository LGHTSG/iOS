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
    let header : header
    
    struct header : Decodable {
        let resultCode : Int
    }
    
    struct body : Decodable {
        let userIdx : Int
    }
}
