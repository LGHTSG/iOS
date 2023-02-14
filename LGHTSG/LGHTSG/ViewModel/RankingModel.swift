//
//  RankingModel.swift
//  LGHTSG
//
//  Created by HA on 2023/02/11.
//

import Foundation

// MARK: - RankingModel
struct RankingModel: Codable {
    let body: [zBody]
}

// MARK: - Body
struct zBody: Codable {
    let userIdx: Int
    let userName: String
    let userAsset: Int
   // let profileImg: URL
}


