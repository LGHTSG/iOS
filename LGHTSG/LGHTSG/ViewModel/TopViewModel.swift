//
//  TopViewModel.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/02/08.
//

import Foundation
import Alamofire
class topViewModel {
    func getAreaList(onCompleted : @escaping([EstatePriceDetailModel.EstateBody])-> Void) {
        let urlSTR = "http://api.lghtsg.site:8090/realestates?order=descending&sort=price&area=서울특별시+강남구"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of : EstatePriceDetailModel.self) { response in
                switch response.result {
                case .success(let res):
                    onCompleted(res.body)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    
}
