//
//  StockController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/17.
//

import UIKit
import SwiftUI
import SnapKit
import DropDown

class EstateDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //MARK: - Chart
    
    private lazy var replaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    //MARK: - Label
    private lazy var dealLabel: UILabel = {
        let label = UILabel()
        label.text = "거래 이력"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private lazy var revenueLabel: UILabel = {
        let label = UILabel()
        label.text = "구매 시점에 비해 얼마 올랐어요"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    //MARK: - lineImage
    private lazy var lineImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Line2"))
        return image
    }()
    
    //MARK: - SegmentControl
    
    private lazy var segmentCtrl: UISegmentedControl = {
        let items = ["1주", "3달", "1년", "5년"]
        let seg = UISegmentedControl(items: items)
        seg.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        seg.layer.cornerRadius = 5.0
        seg.backgroundColor = UIColor(named: "dropdown")
        seg.tintColor = .lightGray
        seg.selectedSegmentTintColor = .white
        seg.selectedSegmentIndex = 1
        
        return seg
    }()
    
    //MARK: - Button
    
    private lazy var sellButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("판매", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        return btn
        
    }()
    
    //MARK: - TableView

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
        
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configure()
    }
    
    //MARK: - Configure

    func configure(){
        view.backgroundColor = .black
        
        [sellButton, tableView, lineImage,dealLabel, revenueLabel, segmentCtrl,replaceView]
          .forEach {view.addSubview($0)}
        
        replaceView.snp.makeConstraints{
            $0.bottom.equalTo(segmentCtrl.snp.top).offset(-8)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(218)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        segmentCtrl.snp.makeConstraints{
            $0.bottom.equalTo(revenueLabel.snp.top).offset(-24)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
            
        }
        
        revenueLabel.snp.makeConstraints{
            $0.bottom.equalTo(dealLabel.snp.top).offset(-24)
            $0.leading.equalToSuperview().inset(33)

        }
        
        dealLabel.snp.makeConstraints{
            $0.bottom.equalTo(lineImage.snp.top).offset(-5)
            $0.leading.equalToSuperview().inset(33)
        }
        
        lineImage.snp.makeConstraints{
            $0.bottom.equalTo(tableView.snp.top).offset(-9)
            $0.leading.equalToSuperview().inset(33)
            $0.trailing.equalToSuperview().inset(33)
        
            $0.height.equalTo(3)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(518)
            $0.bottom.equalTo(sellButton.snp.top).offset(-10)
            $0.leading.equalToSuperview().inset(33)
            $0.trailing.equalToSuperview().inset(33)
        }
        
        sellButton.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-97)
            $0.leading.equalToSuperview().inset(33)
            $0.trailing.equalToSuperview().inset(33)

        }
    }
    
    //MARK: - TableViewSetting

    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EstateDetailCell.self, forCellReuseIdentifier: EstateDetailCell.identifier)
    }
    
    //cell 높이조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 30
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EstateDetailCell.identifier, for: indexPath) as? EstateDetailCell else { return UITableViewCell() }
        
        cell.date.text = "hello"
        cell.date.textColor = .white
        cell.price.text = "hello"
        cell.price.textColor = .white
        cell.buysell.text = "hello"
        cell.buysell.textColor = .white
        
        return cell
    }
    
    //MARK: - Helper
    
    @objc func indexChanged(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
                case 0:
                    print("1주")
                case 1:
                    print("3달")
                case 2:
                    print("1년")
                case 3:
                    print("5년")
                default:
                    break
            }
    }
}


//MARK: - SwiftUI

struct MysViewController_PreViews: PreviewProvider {
    static var previews: some View {
        EstateDetailController().toPreview() //원하는 VC를 여기다 입력하면 된다.
    }
}
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

    func tosPreview() -> some View {
        Preview(viewController: self)
    }
}
