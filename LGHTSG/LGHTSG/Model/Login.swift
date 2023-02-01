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
        let resultCode : Int
    }
    
    struct body : Decodable {
        let jwt : String
    }
}
