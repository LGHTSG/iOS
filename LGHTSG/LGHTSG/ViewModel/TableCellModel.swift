//
//  TableCellModel.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/23.
//

import Foundation
import Alamofire

class TableCellModel {
    var urlString : String?
    func requestTableCellModel(segmentIndex: Int  , onCompleted : @escaping([asset.body]) -> Void){
        switch segmentIndex{
        case 0:
            urlString = "http://api.lghtsg.site:8090/stocks?sort=fluctuation&order=descending"
        case 1:
            urlString = "http://api.lghtsg.site:8090/stocks?sort=fluctuation&order=ascending"
        case 2:
            urlString = "http://api.lghtsg.site:8090/stocks?sort=trading-volume"
        case 3:
            urlString = "http://api.lghtsg.site:8090/stocks?sort=market-cap"
        default:
            break
        }
        guard let urlString = urlString else{ return}
        guard let url = URL(string: urlString) else {return print("erorr")}
        AF.request(url).responseDecodable(of: asset.self) {response in
            switch response.result {
            case let .success(data):
                onCompleted(data.body)
            case let .failure(err):
                print(err)
            }
        }
    }
    func requestResellModel(segmentIndex: Int  , onCompleted : @escaping([resellData.body]) -> Void){
        switch segmentIndex{
        case 0:
            urlString = "http://api.lghtsg.site:8090/resells?sort=fluctuation&order=descending"
        case 1:
            urlString = "http://api.lghtsg.site:8090/resells?sort=fluctuation&order=ascending"
        case 2:
            urlString = "http://api.lghtsg.site:8090/resells "
        default:
            break
        }
        guard let urlString = urlString else{ return}
        guard let url = URL(string: urlString) else {return print("erorr")}
        AF.request(url).responseDecodable(of: resellData.self) {response in
            switch response.result {
            case let .success(data):
                onCompleted(data.body)
            case let .failure(err):
                print(err)
            }
    
        }
    }
}
