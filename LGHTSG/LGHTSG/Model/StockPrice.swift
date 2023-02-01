//
//  StockPrice.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/21.
//

import Foundation
struct StockPrice : Decodable {
    let body : [StockBody]
    struct StockBody : Decodable {
        let price : Int
        let transactionTime : String
    }
}
//struct StockHeader : Decodable{
//    let resultMsg : String
//    let resultCode : String
//}
