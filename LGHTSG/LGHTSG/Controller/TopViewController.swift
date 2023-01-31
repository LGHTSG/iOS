//
//  TopViewController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/30.
//

import UIKit
import SnapKit



class TopViewController: UIViewController{
    //MARK: - TopTitle
    private lazy var topView1: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        /*view.addSubview(topLabel1)
        view.addSubview(chevron)
        */return view
    }()
    
    private lazy var topView2: UIView = {
        let view = UIView()
        view.addSubview(topLabel2)
        view.addSubview(chevron)
        return view
    }()
    
    private lazy var topView3: UIView = {
        let view = UIView()
        view.addSubview(topLabel3)
        view.addSubview(chevron)
        return view
    }()
    
    private lazy var topLabel1: UILabel = {
        let label = UILabel()
        label.text = "#강남구 집값 Top 10"
        return label
    }()
    
    private lazy var topLabel2: UILabel = {
        let label = UILabel()
        label.text = "#23년 새롭게 바귄 시총 순위"
        return label
    }()
    
    private lazy var topLabel3: UILabel = {
        let label = UILabel()
        label.text = "#어제 급등한 리셀"
        return label
    }()
    
    private lazy var chevron: UIImageView = {
        let image = UIImageView(image: UIImage(named: "chevron.right"))
        return image
    }()

    
    //MARK: - tableView
    private lazy var tableView1: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    private lazy var tableView2: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    private lazy var tableView3: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    //MARK: - TableView
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
        return 2
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
    //MARK: - Configure
    func configure(){
        view.backgroundColor = .black
        
        [topView1/*, topView2, topView3, topLabel1, topLabel2, topLabel3*/]
          .forEach {view.addSubview($0)}
        
        topView1.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-570)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(25)
        }
        /*
        topView2.snp.makeConstraints{
            $0.bottom.equalTo(revenueLabel.snp.top).offset(-24)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
            
        }
        
        topView3.snp.makeConstraints{
            $0.bottom.equalTo(dealLabel.snp.top).offset(-24)
            $0.leading.equalToSuperview().inset(33)

        }
        
        topLabel1.snp.makeConstraints{
            $0.bottom.equalTo(lineImage.snp.top).offset(-5)
            $0.leading.equalToSuperview().inset(33)
        }
        
        topLabel2.snp.makeConstraints{
            $0.bottom.equalTo(tableView.snp.top).offset(-9)
            $0.leading.equalToSuperview().inset(33)
            $0.trailing.equalToSuperview().inset(33)
        
            $0.height.equalTo(3)
        }
        
        topLabel3.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(518)
            $0.bottom.equalTo(sellButton.snp.top).offset(-10)
            $0.leading.equalToSuperview().inset(33)
            $0.trailing.equalToSuperview().inset(33)
        }*/

    }

    
    
}
