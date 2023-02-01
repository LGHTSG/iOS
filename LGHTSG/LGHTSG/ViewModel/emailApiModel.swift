//
//  LoginData.swift
//  LGHTSG

import Foundation
import Alamofire

class emailApiModel {
    
    var urlString : String?
    
    func requestEmailDataModel(bodyData : Parameters, onCompleted : @escaping(email) -> Void){

        urlString = "http://api.lghtsg.site:8090/users/sign-up/email-check"
        
        guard let urlString = urlString else{ return}
        guard let url = URL(string: urlString) else {return print("erorr")}
        
        
        let header : HTTPHeaders = [
                   "Content-Type" : "application/json"
               ]
        
        
        AF.request(url, method: .post, parameters: bodyData, encoding: JSONEncoding(), headers: header).validate().responseDecodable(of: email.self){ response in
            switch response.result {
            case .success(let response):
                onCompleted(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
}
