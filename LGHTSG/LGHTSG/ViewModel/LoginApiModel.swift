//
//  LoginData.swift
//  LGHTSG

import Foundation
import Alamofire

class LoginApiModel {
    
    var urlString : String?
    
    func requestLoginDataModel(bodyData : Parameters, onCompleted : @escaping(Login.body) -> Void){

        urlString = "http://api.lghtsg.site:8090/users/log-in"
        
        guard let urlString = urlString else{ return}
        guard let url = URL(string: urlString) else {return print("erorr")}
        
        
        let header : HTTPHeaders = [
                   "Content-Type" : "application/json"
               ]
        
        AF.request(url, method: .post, parameters: bodyData, encoding: JSONEncoding(), headers: header).validate().responseDecodable(of: Login.self){ response in
            switch response.result {
            case .success(let response):
                onCompleted(response.body)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        


    }
    
}
