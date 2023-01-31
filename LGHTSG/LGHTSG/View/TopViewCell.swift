//
//  TopViewCell.swift
//  LGHTSG
//
//  Created by HA on 2023/01/31.
//

import UIKit

class TopViewCell: UITableViewCell {
    
    static let identifier = "TopViewCell"
    
    lazy var number: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    lazy var percentage: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    lazy var period: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()

        imageView.tintColor = .white
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        
        return imageView
       
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        self.cellSetting()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetting() {
        self.backgroundColor = .black
        
        [number, title, price, percentage, period, iconImage]
            .forEach {contentView.addSubview($0)}
        
        iconImage.snp.makeConstraints{
            $0.leading.equalTo(number.snp.trailing).offset(9)
            $0.trailing.equalTo(number.snp.trailing).offset(53)
            $0.centerY.equalToSuperview()
        }
        
        number.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(1)
            $0.centerY.equalToSuperview()
        }

        title.snp.makeConstraints {
            $0.leading.equalTo(iconImage.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(5)
        }
        
        price.snp.makeConstraints {
            $0.leading.equalTo(iconImage.snp.trailing).offset(16)
            $0.top.equalTo(title.snp.bottom).offset(5)
        }
        
        percentage.snp.makeConstraints {
            $0.leading.equalTo(price.snp.trailing).offset(8)
            $0.top.equalTo(title.snp.bottom).offset(5)
        }
        
        period.snp.makeConstraints {
            $0.leading.equalTo(percentage.snp.trailing).offset(8)
            $0.top.equalTo(title.snp.bottom).offset(5)
        }
    }
}
