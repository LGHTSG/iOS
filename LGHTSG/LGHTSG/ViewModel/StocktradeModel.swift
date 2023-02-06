//
//  StocktradeModel.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/02/03.
//


import Alamofire
import Foundation
class StocktradeModel {
    func reqeustTradeHistory(assetIdx : Int, catgegory: String, token : String, onCompleted : @escaping(TradeHistroy) -> Void){
        guard let url = URL(string: "http://api.lghtsg.site:8090/users/transactionHistory?category=\(catgegory)&assetIdx=\(assetIdx)") else {return }
        let headers : HTTPHeaders = ["x-access-token" : token]
        AF.request(url, headers: headers).responseDecodable(of: TradeHistroy.self) { response in
            switch response.result {
            case let .success(data):
                onCompleted(data)
            case let .failure(err):
                print(err)
            }
        }
        
    }
    func requestBuystock(assetIdx: Int, category: String, price : Int, transactionTime : String, token : String, onCompleted : @escaping(TradeDateError) -> Void){
        let urlString = "http://api.lghtsg.site:8090/users/my-asset/purchase"
        guard let url = URL(string: urlString) else {return print("erorr")}
        let headers : HTTPHeaders = ["x-access-token" : token]
        let bodyData : Parameters = [
            "assetIdx" : assetIdx,
            "category" : category,
            "price" : price,
            "transactionTime" : transactionTime
        ]
        AF.request(url, method: .post, parameters: bodyData, encoding: JSONEncoding.default ,headers : headers ).responseDecodable(of : TradeDateError.self){ response in
            switch response.result {
            case .success(let res):
                onCompleted(res)
            case .failure(_):
                print(NSDebugDescriptionErrorKey)
            }
        }
    }
    func requestSellstock(assetIdx: Int, category: String, price : Int, transactionTime : String, token : String, onCompleted : @escaping(TradeDateError) -> Void){
        let urlString = "http://api.lghtsg.site:8090/users/my-asset/sell"
        guard let url = URL(string: urlString) else {return print("erorr")}
        let headers : HTTPHeaders = ["x-access-token" : token]
        let bodyData : Parameters = [
            "assetIdx" : assetIdx,
            "category" : category,
            "price" : price,
            "transactionTime" : transactionTime
        ]
        AF.request(url, method: .post, parameters: bodyData, encoding: JSONEncoding.default ,headers : headers ).responseDecodable(of: TradeDateError.self){ response in
            switch response.result {
            case .success(let res):
                onCompleted(res)
            case .failure(_):
                print(NSDebugDescriptionErrorKey)
            }
        }
    }
}
