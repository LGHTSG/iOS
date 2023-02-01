//
//  LoginModel.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/25.
//

import Foundation
import Alamofire

class LoginModel {
        
    let url = "http://api.lghtsg.site:8090/users/log-in"
    let header : HTTPHeaders = [
               "Content-Type" : "application/json"
           ]
    
    func requestLogin(bodyData : Parameters) {
        
        // [http 요청 수행 실시]
        print("")
        print("====================================")
        print("requestLogin() :: Post Body Json 방식 http 요청 실시]")
        print("주 소 :: \(url)")
        print("데이터 :: \(bodyData.description) ")
        print("====================================")
        print("")
        
        
        AF.request(
                   url, // [주소]
                   method: .post, // [전송 타입]
                   parameters: bodyData, // [전송 데이터]
                   encoding: JSONEncoding.default, // [인코딩 스타일]
                   headers: header // [헤더 지정]
               )
               .validate(statusCode: 200..<512)
               .responseData { response in
                   switch response.result {
                   case .success(let res):
                       do {
                           print("")
                           print("====================================")
                           print("응답 코드 :: \(response.response?.statusCode ?? 0)")
                           print("응답 데이터 :: \(String(data: res, encoding: .utf8) ?? "")")
                           print("====================================")
                           print("")
                       }
                       catch (let err){
                           print("")
                           print("====================================")
                           print("-------------------------------")
                           print("catch :: ", err.localizedDescription)
                           print("====================================")
                           print("")
                       }
                       break
                   case .failure(let err):
                       print("")
                       print("====================================")
                       print("-------------------------------")
                       print("응답 코드 :: \(response.response?.statusCode ?? 0)")
                       print("-------------------------------")
                       print("에 러 :: \(err.localizedDescription)")
                       print("====================================")
                       print("")
                       break
                   }
               }

        }
}
