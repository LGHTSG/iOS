//
//  TopViewCell.swift
//  LGHTSG
//
//  Created by HA on 2023/01/31.
//

import UIKit

class TopViewCell: UITableViewCell {
    private enum Constant {
    static let thumbnailSize = 70.0
      static let thumbnailCGSize = CGSize(width: Constant.thumbnailSize, height: Constant.thumbnailSize)
      static let borderWidth = 2.0
      static let spacing = 4.0
    }
    static let identifier = "TopViewCell"
    
    lazy var number: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareB", size: 14.0)
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "NanumSquareB", size: 14.0)
        return label
    }()
    
    lazy var percentage: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        return label
    }()
    
    lazy var period: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        return label
    }()
    
    var iconImage = UIImageView()
/*
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        //imageview.image = UIImage(named: "dog")
        imageView.layer.cornerRadius = (Constant.thumbnailSize - Constant.spacing * 2) / 2.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        /*
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)) //이미지뷰 만들기
        imageView.layer.cornerRadius = myView.frame.width / 2 //프레임을 원으로 만들기
        let imageView = UIImage(named: "bruceLee.gif") //이미지 객체 생성
        imageView.image = imageView //이미지를 이미지뷰에 넣기
        imageView.contentMode = UIViewContentMode.ScaleAspectFill //이미지 비율 바로잡기
        imageView.clipsToBounds = true //이미지를 뷰 프레임에 맞게 clip하기*/
        return imageView
       
    }()*/
    
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
       
        iconImage.clipsToBounds = true
        iconImage.layer.cornerRadius = 16.5
        iconImage.snp.makeConstraints{
           /* $0.leading.equalTo(number.snp.trailing).offset(9)
            $0.trailing.equalTo(number.snp.trailing).offset(53)
            $0.centerY.equalToSuperview()
       */
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalToSuperview().inset(5)
            $0.height.width.equalTo(33)
            
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
