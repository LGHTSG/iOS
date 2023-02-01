//
//  email.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/27.
//

// MARK: - Model
struct email : Decodable {

    let body : String
    
    struct header : Decodable {
        let resultCode : Int
    }
    
}
