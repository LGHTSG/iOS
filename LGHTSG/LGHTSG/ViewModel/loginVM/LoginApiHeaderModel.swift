//
//  LoginApiHeaderModel.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/26.
//

import Foundation
import Alamofire

class LoginApiHeaderModel {
    
    var urlString : String?
    
    func requestLoginDataModel(bodyData : Parameters, onCompleted : @escaping(Login.header) -> Void){

        urlString = "http://api.lghtsg.site:8090/users/log-in"
        
        guard let urlString = urlString else{ return}
        guard let url = URL(string: urlString) else {return print("erorr")}
        
        
        let header : HTTPHeaders = [
                   "Content-Type" : "application/json"
               ]
        
        
        AF.request(url, method: .post, parameters: bodyData, encoding: JSONEncoding(), headers: header).validate().responseDecodable(of: Login.header.self){ response in
            
            switch response.result {
            
            case .success(let res):
                onCompleted(res)
                
            case .failure(_):
                //print(response.debugDescription)
                let result = response.debugDescription
                var sstartIndex = 0
                var eendIndex = 0
                
                for i in stride(from: result.count-18 , to: 0, by: -1){
                    
                    let first = result[result.index(result.startIndex, offsetBy: i)]
                    let eight = result[result.index(result.startIndex, offsetBy: i+17)]
                    if first == "B" && eight == "h" {
                        sstartIndex = i+17
                        break
                    }
                }
                for j in sstartIndex...result.count-58 {
                    let first = result[result.index(result.startIndex, offsetBy: j)]
                    let second = result[result.index(result.startIndex, offsetBy: j+56)]
                    let third = result[result.index(result.startIndex, offsetBy: j+57)]
                    if first == "h" && second == "}" && third == "}" {
                        eendIndex = j+57
                        break
                    }
                }
                var resultt : String = ""
                for i in stride(from: eendIndex, to: sstartIndex, by: -1) {
                    let first : String = String(result[result.index(result.startIndex, offsetBy: i)])
                    resultt = resultt + first
                }
                //print(resultt)
                UserDefaults.standard.set(resultt, forKey: "loginHeader")
                print("등록되었음")
            }
        }

    }
    
}
