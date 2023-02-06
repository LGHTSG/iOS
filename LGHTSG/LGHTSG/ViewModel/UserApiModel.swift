//
//  userApiModel.swift
//  LGHTSG
//


import Foundation
import Alamofire


class UserApiModel {
    
    var urlString : String?
    
    func requestUserDataModel(bodyData : String, onCompleted : @escaping(user.body) -> Void){

        urlString = "http://api.lghtsg.site:8090/users/info"
        
        guard let urlString = urlString else{ return}
        guard let url = URL(string: urlString) else {return print("erorr")}
        
        
        let header : HTTPHeaders = [
            "x-access-token" : bodyData]
        
        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate().responseDecodable(of: user.self){ response in
            switch response.result {
            case .success(let response):
                UserDefaults.standard.set(true, forKey: "loginSuccess")
                onCompleted(response.body)
            case .failure(let error):
                print("error가 나왔음")
                print(response.debugDescription)
                UserDefaults.standard.set(false, forKey: "loginSuccess")

            }
        }
        


    }
    
}
