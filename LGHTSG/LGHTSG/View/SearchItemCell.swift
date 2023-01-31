//
//  SearchItemCell.swift.swift
//  LGHTSG
//
//  Created by HA on 2023/01/29.
//

import UIKit


class SearchItemCell: UITableViewCell {
    
    static let identifier = "SearchItemCell"
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = .white
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
        self.backgroundColor = UIColor(named: "dropdown")
        
        [name]
            .forEach {contentView.addSubview($0)}
        
        name.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            
        }
    }
}
