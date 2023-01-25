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
        let price : String
        let rateOfChange : String
        let rateCalDateDiff : String
        let image1 : String
    }
}
