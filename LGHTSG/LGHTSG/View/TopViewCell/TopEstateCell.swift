//
//  TopEstateCell.swift
//  LGHTSG
//
//  Created by HA on 2023/01/31.
//

class TopEstateCell: UITableViewCell {
    
    static let identifier = "TopEstateCell"
    
    lazy var hello: UILabel = {
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
        
        [hello]
            .forEach {contentView.addSubview($0)}
        
        hello.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            
        }
    }
}
