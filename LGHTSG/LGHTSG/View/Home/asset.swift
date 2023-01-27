//
//  asset.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/13.
//

import Foundation
struct asset : Decodable {
    let body : [body]
    struct body : Decodable{
        let name : String
        let price : Int
        let rateOfChange : Double
        let rateCalDateDiff : String
        let iconImage : String
    }

}
