//
//  EstatePriceDetailModel.swift
//  LGHTSG
//
//  Created by HA on 2023/02/01.
//

import Foundation

// MARK: - EstatePriceDetailModel
struct EstatePriceDetailModel: Decodable {
    let body: [EstateBody]
    
    
    // MARK: - Body
    struct EstateBody: Decodable {
        let idx: Int
        let name: String
        let rateOfChange: Double
        let rateCalDateDiff: String
        let iconImage: String
        let transactionTime: String
        let price, s2Price: Int
        let s2TransactionTime: String
    }
    
}
