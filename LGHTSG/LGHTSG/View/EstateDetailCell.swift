//
//  EstateDetailCell.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/27.
//

import UIKit
class EstateDetailCell: UITableViewCell {
    
    static let identifier = "EstateDetailCell"
    
    lazy var date: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareR", size: 14.0)
        label.textColor = .white
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareR", size: 14.0)
        label.textColor = .white
        return label
    }()
    
    lazy var buysell: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumSquareR", size: 14.0)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        self.backgroundColor = .black
        
        self.cellSetting()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetting() {
        self.backgroundColor = .black
        
        [date, price, buysell]
            .forEach {contentView.addSubview($0)}
        
        date.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(1)
            $0.centerY.equalToSuperview()


        }
        price.snp.makeConstraints {
            $0.leading.equalTo(date.snp.trailing ).offset(69)
            $0.centerY.equalToSuperview()

        }
        buysell.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()

        }
        
    }
}
