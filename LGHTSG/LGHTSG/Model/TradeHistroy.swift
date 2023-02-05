//
//  TradeHistroy.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/02/04.
//

import Foundation
struct TradeHistroy : Decodable {
    let header : HistoryHeader
    let body : [HistoryBody]?
    struct HistoryBody : Decodable {
        let transactionTime : String
        let price : Int
        let sellCheck : Int
    }
    struct HistoryHeader : Decodable {
        let resultMsg : String
        let resultCode : Int
    }
}

