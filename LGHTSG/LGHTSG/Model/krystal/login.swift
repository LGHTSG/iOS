//
//  LoginDataModel.swift
//  LGHTSG
//

import Foundation

// MARK: - Model
struct Login : Decodable {
    let body : body
    let header : header
    
    struct header : Decodable {
        let resultMsg : String
        let resultCode : Int
    }
    
    
    struct body : Decodable {
        let accessToken : String
    }
}
