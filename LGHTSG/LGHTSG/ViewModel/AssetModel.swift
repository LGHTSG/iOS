//
//  AssetModel.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/14.
//
//
import Alamofire
import Foundation
class AssetModel {
    func requestMyAsset(token : String, onCompleted : @escaping([myasset.myBody]) -> Void){
        let urlString = "http://api.lghtsg.site:8090/users/my-asset"
        guard let url = URL(string: urlString) else {return print("erorr")}
        let headers : HTTPHeaders = ["x-access-token" : token]
        AF.request(url, headers : headers).responseDecodable(of: myasset.self){ response in
            switch response.result {
            case .success(let res):
                onCompleted(res.body)
                
            case .failure(_):
                print(NSDebugDescriptionErrorKey)
            }
        }
    }
    func deleteMyAsset(token : String, transactionIdx : Int, category : String, onCompleted : @escaping(TradeDateError) -> Void){
        let urlString = "http://api.lghtsg.site:8090/users/my-asset/delete-list"
        guard let url = URL(string: urlString) else {return}
        let headers : HTTPHeaders = ["x-access-token" : token]
        let body : Parameters = [
            "assetIdx" : transactionIdx,
            "category" : category
        ]
        AF.request(url, method: .patch, parameters: body,  encoding: JSONEncoding.default, headers: headers ).responseDecodable(of: TradeDateError.self){
            response in
            switch response.result{
            case let .success(data):
                onCompleted(data)
            case let .failure(err):
                print(err)
            }
        }}
}
