//
//  StockVolumeModel.swift
//  LGHTSG
//
//  Created by HA on 2023/02/04.
//

import Foundation

// MARK: - StockVolumeModel

struct StockVolumeModel: Codable {
    let body: [sBody]
}

// MARK: - Body
struct sBody: Codable {
    let name: String
    let rateOfChange: Double
    let rateCalDateDiff: String
    let iconImage: String
    let price, tradingVolume: Int
}
