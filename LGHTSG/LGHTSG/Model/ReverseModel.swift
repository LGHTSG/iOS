//
//  ReverseModel.swift
//  LGHTSG
//
//  Created by HA on 2023/01/25.
//

import Foundation

// MARK: - ReverseModel
class ReverseModel: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let region: Region
}

// MARK: - Region
struct Region: Codable {
    let area1, area2, area3: Area
}

// MARK: - Area
struct Area: Codable {
    let name: String
}

