//
//  HomeTableCell.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/14.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
class HomeTableCell : UITableViewCell {
    var countLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    private lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.systemGray
        return label
    }()
    private lazy var pricePercent : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.red
        return label
    }()
    private lazy var changeDate : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight : .medium)
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
        nameLabel.text = assetinfo.name
        priceLabel.text = String(assetinfo.price)+"원"
        changeDate.text = assetinfo.rateCalDateDiff
        pricePercent.text = String(assetinfo.rafeOfChange)
        let url = URL(string: assetinfo.iconImage)
        iconimage.kf.setImage(with: url)
        countLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
        iconimage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(23.66)
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
        pricePercent.snp.makeConstraints{
            $0.leading.equalTo(priceLabel.snp.trailing).offset(8)
            $0.top.equalTo(priceLabel.snp.top)
        }
        changeDate.snp.makeConstraints{
            $0.leading.equalTo(pricePercent.snp.trailing).offset(9)
            $0.top.equalTo(pricePercent.snp.top)
        }
    }
    func setup(with resellinfo : ResellPrice.body){
        [countLabel, nameLabel, priceLabel, pricePercent, changeDate, iconimage].forEach{
            addSubview($0)
        }
        nameLabel.text = resellinfo.name
        priceLabel.text = String(resellinfo.price)+"원"
        changeDate.text = resellinfo.rateCalDateDiff
        if(resellinfo.rateOfChange[resellinfo.rateOfChange.startIndex] == "-"){
            pricePercent.textColor = .blue
        }else {
            pricePercent.textColor = .red
        }
        pricePercent.text = String(resellinfo.rateOfChange)
        let url = URL(string: resellinfo.image1)
        iconimage.kf.setImage(with: url)
        countLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
        iconimage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(23.66)
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
        pricePercent.snp.makeConstraints{
            $0.leading.equalTo(priceLabel.snp.trailing).offset(8)
            $0.top.equalTo(priceLabel.snp.top)
        }
        changeDate.snp.makeConstraints{
            $0.leading.equalTo(pricePercent.snp.trailing).offset(9)
            $0.top.equalTo(pricePercent.snp.top)
        }
    }
    func setuppp(){
        [countLabel, nameLabel, priceLabel, pricePercent, changeDate, iconimage].forEach{
            addSubview($0)
        }
        nameLabel.text = "서울특별시 강남구 논현동 동현아파트"
        priceLabel.text = "22,303,921원/m2"
        changeDate.text = "3달전 대비"
        pricePercent.text = "+3.0%"
        iconimage.image = UIImage(systemName: "star")
        countLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
        iconimage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(23.66)
            $0.top.equalToSuperview()
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
        pricePercent.snp.makeConstraints{
            $0.leading.equalTo(priceLabel.snp.trailing).offset(8)
            $0.top.equalTo(priceLabel.snp.top)
        }
        changeDate.snp.makeConstraints{
            $0.leading.equalTo(pricePercent.snp.trailing).offset(9)
            $0.top.equalTo(pricePercent.snp.top)
        }
    }
}
