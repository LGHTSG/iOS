//
//  usersROE.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/02/06.
//

import Foundation
struct usersROE : Decodable {
    let body : roeBoDY
    struct roeBoDY : Decodable {
        let rate : Double
    }
}
