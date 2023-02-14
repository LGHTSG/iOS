//
//  HomeTableCell.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/14.
//
import MarqueeLabel
import Foundation
import UIKit
import SnapKit
import Kingfisher

class HomeTableCell : UITableViewCell {
    var countLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareB", size: 16.0)
        label.textColor = .white
        return label
    }()

    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareEB", size: 14.0)
        label.textColor = .white
        return label
    }()
    private lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareB", size: 14.0)
        label.textColor = UIColor.systemGray
        return label
    }()
    private lazy var pricePercent : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareB", size: 12.0)
        label.textColor = UIColor.red
        return label
    }()
    private lazy var changeDate : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareB", size: 12.0)
        label.textColor = UIColor.systemGray
        return label
    }()
    var iconimage = UIImageView()
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0))
//    }
}
extension HomeTableCell {
    func setup(with assetinfo : asset.body){
        [countLabel, nameLabel, priceLabel, pricePercent, changeDate, iconimage].forEach{
            addSubview($0)
        }
        self.backgroundColor = .black
        [countLabel, nameLabel, priceLabel, pricePercent, changeDate, iconimage].forEach{
            addSubview($0)
        }
        

        nameLabel.text = assetinfo.name
        priceLabel.text = String(assetinfo.price.withCommas())+"원"
        changeDate.text = assetinfo.rateCalDateDiff
        let stringofratechange = String(assetinfo.rateOfChange)
        if(stringofratechange[stringofratechange.startIndex] == "-"){
            pricePercent.text = "\(stringofratechange)%"
            pricePercent.textColor = .systemBlue
        }else {
            pricePercent.text = "+\(stringofratechange)%"
            pricePercent.textColor = .systemRed
        }
        let url = URL(string: assetinfo.iconImage)
        iconimage.clipsToBounds = true
        iconimage.layer.cornerRadius = 22
        iconimage.kf.setImage(with: url)
        countLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
        iconimage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(30)
            $0.top.equalToSuperview()
            $0.height.width.equalTo(44)
            $0.bottom.equalToSuperview().offset(-12)
        }
        nameLabel.snp.makeConstraints{
            $0.leading.equalTo(iconimage.snp.trailing).offset(16.34)
            $0.top.equalToSuperview()
            
        }
        priceLabel.snp.makeConstraints{
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }

        changeDate.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(priceLabel.snp.top)
        }
        pricePercent.snp.makeConstraints{
            $0.leading.equalTo(priceLabel.snp.trailing).offset(8)
            $0.top.equalTo(priceLabel.snp.top)
        }
    }
    func setup(with resellinfo : resellData.body){

        self.backgroundColor = .black

      [countLabel, nameLabel, priceLabel, pricePercent, changeDate, iconimage].forEach{
            addSubview($0)
        }
        
        

        
        
        nameLabel.text = resellinfo.name
        priceLabel.text = String(resellinfo.price.withCommas())+"원"
        changeDate.text = resellinfo.rateCalDateDiff
        let stringofratechange = String( resellinfo.rateOfChange)
        if(stringofratechange[stringofratechange.startIndex] == "-"){
            pricePercent.text = "\(stringofratechange)%"
            pricePercent.textColor = .systemBlue
        }else {
            pricePercent.text = "+\(stringofratechange)%"
            pricePercent.textColor = .systemRed
        }
        
        let url = URL(string: resellinfo.imageUrl)
        // kf 이미지 둥그렇게

        iconimage.clipsToBounds = true
        iconimage.layer.cornerRadius = 20   
        iconimage.backgroundColor = .white
        iconimage.kf.setImage(with: url )
        
        countLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
        iconimage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(30)
            $0.top.equalToSuperview()
            $0.height.width.equalTo(44)
            $0.bottom.equalToSuperview().offset(-12)
        }
        nameLabel.snp.makeConstraints{
            $0.leading.equalTo(iconimage.snp.trailing).offset(16.34)
            $0.top.equalToSuperview()
            
        }
        priceLabel.snp.makeConstraints{
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }

        changeDate.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(priceLabel.snp.top)
        }
        pricePercent.snp.makeConstraints{
            $0.leading.equalTo(priceLabel.snp.trailing).offset(8)
            $0.top.equalTo(priceLabel.snp.top)
        }
    }
    func setup(home : myasset.myBody){
        [countLabel, nameLabel, priceLabel, pricePercent, changeDate, iconimage].forEach{
            addSubview($0)
        }
        nameLabel.text = home.assetName
        priceLabel.text = String(home.price.withCommas())+"원"
        changeDate.text = home.rateCalDateDiff
        pricePercent.text = String(home.rateOfChange)
        let url = URL(string: home.iconImage)
        let stringofratechange = String(home.rateOfChange)
        if(stringofratechange[stringofratechange.startIndex] == "-"){
            pricePercent.text = "\(stringofratechange)%"
            pricePercent.textColor = .systemBlue
        }else {
            pricePercent.text = "+\(stringofratechange)%"
            pricePercent.textColor = .systemRed
        }
        // kf 이미지 둥그렇
        iconimage.clipsToBounds = true
        iconimage.layer.cornerRadius = 22
        iconimage.backgroundColor = .white
        iconimage.kf.setImage(with: url )
        countLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
        iconimage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(30)
            $0.top.equalToSuperview()
            $0.height.width.equalTo(44)
            $0.bottom.equalToSuperview().offset(-12)
        }
        nameLabel.snp.makeConstraints{
            $0.leading.equalTo(iconimage.snp.trailing).offset(16.34)
            $0.top.equalToSuperview()
        }
        priceLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(nameLabel.snp.leading)
        }

        changeDate.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(pricePercent.snp.top)
        }
        pricePercent.snp.makeConstraints{
            $0.leading.equalTo(priceLabel.snp.trailing).offset(8)
            $0.top.equalTo(priceLabel.snp.top)
        }
    }
}
extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
