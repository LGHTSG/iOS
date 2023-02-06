//
//  ResellFluctuationModel.swift
//  LGHTSG
//
//  Created by HA on 2023/02/04.
//

import Foundation

// MARK: - ResellFluctuationModel
struct ResellFluctuationModel: Codable {
    let body: [rBody]
}

// MARK: - Body
struct rBody: Codable {
    let name: String
    let rateOfChange: Double
    let rateCalDateDiff: String
    let price: Int
    let imageURL: String


}
