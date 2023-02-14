//
//  EstatePriceModel.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/22.
//

import Foundation
import Alamofire
class EstatePriceModel {
    var PriceLists :  [Int] = []
    var transactionTimeLists : [String] = []
    func requestStockPrice(EstateName : String, onCompleted : @escaping([Int],[String]) -> Void){
        PriceLists = []
                transactionTimeLists = []
        let urlString = "http://api.lghtsg.site:8090/realestates/prices?area=\(EstateName)"
        let encodedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        AF.request(url).responseDecodable(of: realEstates.self) { [weak self] response in
            switch response.result {
            case let .success(data):
                guard let self = self else {return}
                data.body.forEach{
                    self.PriceLists.append($0.price)
                    self.transactionTimeLists.append($0.datetime)
                }
                onCompleted(self.PriceLists , self.transactionTimeLists)
            case let .failure(err):
                print(err)
            }
    
        }
    }
    
    func requestIdxPrice(idx : Int, onCompleted : @escaping([Int],[String]) -> Void){
            let urlString = "http://api.lghtsg.site:8090/realestates/\(idx)/prices"
        let encodedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        AF.request(url).responseDecodable(of: realEstates.self) { [weak self] response in
            switch response.result {
            case let .success(data):
                guard let self = self else {return}
                data.body.forEach{
                    self.PriceLists.append($0.price)
                    self.transactionTimeLists.append($0.datetime)
                }
                onCompleted(self.PriceLists , self.transactionTimeLists)
            case let .failure(err):
                print(err)
            }
    
        }
    }
}
