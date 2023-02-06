//
//  ResellPrice.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/02/06.
//

import Foundation
struct ResellPrice : Decodable {
    let body : [StockBody]
    struct StockBody : Decodable {
        let price : Int
        let transactionTime : String
    }
}
