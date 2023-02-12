//
//  RankViewCell.swift
//  LGHTSG
//
//  Created by HA on 2023/01/31.
//

import UIKit

class RankViewCell: UITableViewCell {
    private enum Constant {
    static let thumbnailSize = 70.0
      static let thumbnailCGSize = CGSize(width: Constant.thumbnailSize, height: Constant.thumbnailSize)
      static let borderWidth = 2.0
      static let spacing = 4.0
    }
    static let identifier = "RankViewCell"

    lazy var number: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareB", size: 14.0)
        return label
    }()
    
    lazy var userAsset: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "NanumSquareB", size: 14.0)
        return label
    }()
    
    lazy var transCount: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        return label
    }()
    
    var iconImage = UIImageView()

  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 6, bottom: 12, right: 6))
       /* self.containerView.layer.cornerRadius = 8
        self.containerView.layer.masksToBounds = true*/
        self.cellSetting()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetting() {
        self.backgroundColor = .black
        
        [number, userName, userAsset, transCount, iconImage]
            .forEach {contentView.addSubview($0)}
       
      
        iconImage.clipsToBounds = true
        iconImage.layer.cornerRadius = 16.5
        iconImage.snp.makeConstraints{
        
            $0.leading.equalTo(number.snp.trailing).offset(15)
            $0.top.equalToSuperview().inset(10)
            $0.height.width.equalTo(33)
            
        }
        
        number.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }

        userName.snp.makeConstraints {
            $0.leading.equalTo(iconImage.snp.trailing).offset(21)
            $0.top.equalToSuperview().inset(15)
        }
        
        userAsset.snp.makeConstraints {
            $0.leading.equalTo(iconImage.snp.trailing).offset(21)
            $0.top.equalTo(userName.snp.bottom).offset(5)
        }
        
     
        transCount.snp.makeConstraints {
            $0.leading.equalTo(userAsset.snp.trailing).offset(21)
            $0.top.equalTo(userName.snp.bottom).offset(5)
        }
    }
}
