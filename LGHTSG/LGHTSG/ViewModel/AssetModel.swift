//
//  AssetModel.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/14.
//
// 일단 assetmodel이라고 임의의 url넣어놨는데 나의자산, 판매한자산의 model을 따로 만들생각.
import Foundation
protocol AssetModelProtocol {
    func assetRetrived(assets : [asset])
}
class AssetModel {
    var delegate : AssetModelProtocol?
    func getAsset(){
        let urlString = "요청할 url"
        let url = URL(string: urlString)
        guard let url = url else{return} //url 없으면 멈추도록
        let dataTask = URLSession.shared.dataTask(with: url){
            (data, res, err) in
            if err == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                    let asset = try decoder.decode(asset.self, from: data!) //asset decodable 형식의 swift인스턴스로 파싱
                    DispatchQueue.main.async {
                        self.delegate?.assetRetrived(assets: [asset])
                    }
                }catch{print("erorr json")}
            }
        }
        dataTask.resume()
    }
}
