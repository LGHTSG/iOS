//
//  EstateSaleCell.swift
//  LGHTSG
//
//  Created by HA on 2023/01/28.
//

import UIKit


class EstateSaleCell: UITableViewCell {
    
    static let identifier = "EstateSaleCell"
    
    lazy var number: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareEB", size: 10.0)
        return label
    }()
    
    lazy var area: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var pow: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareEB", size: 10.0)
        return label
    }()
    
    
    lazy var price: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var period: UILabel = {
        let label = UILabel()
        return label
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
        
        [number, title, area, price, period, pow]
            .forEach {contentView.addSubview($0)}
        
        number.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(1)
            $0.centerY.equalToSuperview()

        }

        title.snp.makeConstraints {
            $0.leading.equalTo(number.snp.trailing).offset(20)
            $0.top.equalToSuperview().inset(5)

        }
        area.snp.makeConstraints {
            $0.leading.equalTo(number.snp.trailing).offset(20)
            $0.top.equalTo(title.snp.bottom).offset(5)

        }
        pow.snp.makeConstraints{
            $0.leading.equalTo(area.snp.trailing).offset(2)
            $0.top.equalTo(title.snp.bottom).offset(3)
        }
     
        price.snp.makeConstraints {
            $0.leading.equalTo(pow.snp.trailing).offset(10)
            $0.top.equalTo(title.snp.bottom).offset(5)

        }
        period.snp.makeConstraints {
            $0.leading.equalTo(price.snp.trailing).offset(10)
            $0.top.equalTo(title.snp.bottom).offset(5)

        }
        
    }
}


