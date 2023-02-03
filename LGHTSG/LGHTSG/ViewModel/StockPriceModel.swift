//
//  File.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/21.
//

import Foundation
import Alamofire
class StockPriceModel {
    var PriceLists :  [Int] = []
    var transactionTimeLists : [String] = []
    func requestStockPrice(stockIdx : Int, onCompleted : @escaping([Int],[String]) -> Void){
        let urlString = "http://api.lghtsg.site:8090/stocks/\(stockIdx)/prices"
        guard let url = URL(string: urlString) else {return print("erorr")}
        AF.request(url).responseDecodable(of: StockPrice.self) { [weak self]response in
            switch response.result {
            case let .success(data):
                guard let self = self else {return}
                data.body.forEach{
                    self.PriceLists.append($0.price)
                    self.transactionTimeLists.append(String($0.transactionTime))
                }
                onCompleted(self.PriceLists , self.transactionTimeLists)
                
            case let .failure(err):
                print(err)
            }
    
        }
    }
    func requestResellPrice(resellIdx : Int, onCompleted : @escaping([Int],[String]) -> Void){
        let urlString = "http://api.lghtsg.site:8090/resells/\(resellIdx)/prices"
        guard let url = URL(string: urlString) else {return print("erorr")}
        AF.request(url).responseDecodable(of: StockPrice.self) { [weak self]response in
            switch response.result {
            case let .success(data):
                guard let self = self else {return}
                data.body.forEach{
                    self.PriceLists.append($0.price)
                    self.transactionTimeLists.append($0.transactionTime)
                }
                onCompleted(self.PriceLists , self.transactionTimeLists)
            case let .failure(err):
                print(err)
            }
    
        }
    }
}
