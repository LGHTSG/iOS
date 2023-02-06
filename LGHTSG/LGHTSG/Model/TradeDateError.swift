//
//  TradeDateError.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/02/04.
//

import Foundation
struct TradeDateError : Decodable {
    let header : tradeheader
    struct tradeheader : Decodable {
        let resultMsg : String
        let resultCode : Int
    }
}
