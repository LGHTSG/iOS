//
//  my-asset.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/02/03.
//

struct myasset : Decodable {
    let body : [myBody]
    struct myBody : Decodable {
        let assetIdx : Int
        let assetName : String
        let price : Int
        let rateOfChange : Double
        let transactionTime : String
        let rateCalDateDiff : String
        let iconImage : String
        let sellCheck : Int
        let category : String
    }
}
