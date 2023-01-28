//
//  ResellPrice.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/24.
//

import Foundation
class ResellPrice : Decodable {
    let body : [body]
    struct body : Decodable{
        let name : String
        let price : Int
        let rateOfChange : Double
        let rateCalDateDiff : String
        let idx : Int
        let iconImage : String
    }
}
