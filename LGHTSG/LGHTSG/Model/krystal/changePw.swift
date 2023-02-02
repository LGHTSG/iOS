//
//  changePw.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/31.
//

import Foundation

struct changePw : Decodable {

    var body : String
    
    init(body: String) {
        self.body = body
    }
}
