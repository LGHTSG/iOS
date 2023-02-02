//
//  ChangePwApiModel.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/31.
//

import Foundation
import Alamofire


class ChangePwApiModel {
    
    var urlString : String?
    
    func requestChangeDataModel(bodyData : Parameters, onCompleted : @escaping(changePw) -> Void){

        urlString = "http://api.lghtsg.site:8090/users/changeInfo/pw-not-login"
        
        guard let urlString = urlString else{ return}
        guard let url = URL(string: urlString) else {return print("erorr")}
        
        
        let header : HTTPHeaders = [
                   "Content-Type" : "application/json"
               ]
        
        
        AF.request(url, method: .patch, parameters: bodyData, encoding: JSONEncoding(), headers: header).validate().responseDecodable(of: changePw.self){ response in
            switch response.result {
            case .success(let response):
                onCompleted(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
}
