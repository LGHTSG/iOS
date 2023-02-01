//
//  EstateModel.swift
//  LGHTSG
//
//  Created by HA on 2023/01/30.
//

import Foundation

// MARK: - EstateModel
struct EstateModel: Decodable {
    let body: Body
}

// MARK: - Body
struct Body: Decodable {
    let idx: Int
    let name: String
    let rateOfChange: Double
    let rateCalDateDiff: String
    let price: Int
}


