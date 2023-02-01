//
//  LoginData.swift
//  LGHTSG

import Foundation
import Alamofire

class JoinApiModel {
    
    var urlString : String?
    
    func requestJoinDataModel(bodyData : Parameters, onCompleted : @escaping(join) -> Void){

        urlString = "http://api.lghtsg.site:8090/users/sign-up"
        
        guard let urlString = urlString else{ return}
        guard let url = URL(string: urlString) else {return print("erorr")}
        
        
        let header : HTTPHeaders = [
                   "Content-Type" : "application/json"
               ]
        
        
        AF.request(url, method: .post, parameters: bodyData, encoding: JSONEncoding(), headers: header).validate().responseDecodable(of: join.self){ response in
            switch response.result {
<<<<<<< Updated upstream
            case .success(let response):
                onCompleted(response)
            case .failure(let error):
=======
            case .success(let res):
                print(response.debugDescription)
                onCompleted(res)
            case .failure(let error):
                print(response.debugDescription)
>>>>>>> Stashed changes
                print(error.localizedDescription)
            }
        }

    }
    
}
