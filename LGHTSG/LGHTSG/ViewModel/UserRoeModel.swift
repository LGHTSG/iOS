//
//  UserRoeModel.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/02/06.
//

import Foundation
import Alamofire
class UserRoeModel {
    func getUserROE(token : String, onCompleted : @escaping(usersROE.roeBoDY) -> Void){
        let urlString = "http://api.lghtsg.site:8090/users/roe"
        guard let url = URL(string: urlString) else {return print("erorr")}
        let headers : HTTPHeaders = ["x-access-token" : token]
        AF.request(url, headers : headers).responseDecodable(of: usersROE.self){ response in
            switch response.result {
            case .success(let res):
                onCompleted(res.body)
                
            case .failure(_):
                print(NSDebugDescriptionErrorKey)
            }
        }
        
    }
}
