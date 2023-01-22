//
//  File.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/22.
//

import Foundation
struct realEstates :Decodable {
    let body : [EstateBody]
    struct EstateBody : Decodable {
        let datetime : String
        let price : Int
    }
}
