//
//  File.swift
//  LGHTSG
//
//  Created by HA on 2023/01/27.
//

import Foundation

// MARK: - GeocodingModel
struct GeocodingModel: Codable {
    let addresses: [Address]
    let errorMessage: String
}

// MARK: - Address
struct Address: Codable {
    let roadAddress, jibunAddress, englishAddress: String
    let x, y: String
}
