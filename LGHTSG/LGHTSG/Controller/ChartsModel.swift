//
//  ChartsModel.swift
//  LGHTSG
//
//  Created by HA on 2023/01/16.
//

import Foundation
struct ChartsModel {
    
    let periods: [Period]
    
    struct Period {
        let name: String
        let prices: [Double]
    }
    
}
