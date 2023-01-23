//
//  ExploreViewController.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/11.
//

import UIKit
import SnapKit
class ExploreViewController : UIViewController {
    var segmentControl = UnderlineSegmentedControl(items: ["Top", "부동산", "주식", "리셀"])
    let underline1 = UnderlineView()
    let underline2 = UnderlineView()
    let underline3 = UnderlineView()
    let underline4 = UnderlineView()
    let stockView = StockView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTobTabbar()
        setView()
    }
    func setTobTabbar(){
        view.addSubview(segmentControl)
        view.addSubview(underline1)
        view.addSubview(underline2)
        view.addSubview(underline3)
        view.addSubview(underline4)
        segmentControl.addTarget(self, action: #selector(clickfoursegment), for: .valueChanged)
        segmentControl.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        underline1.backgroundColor = .white
        underline1.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 4)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
        underline2.snp.makeConstraints{
            $0.leading.equalTo(underline1.snp.trailing).offset(4.5)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 4)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
        underline3.snp.makeConstraints{
            $0.leading.equalTo(underline2.snp.trailing).offset(3.5)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 4)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
        underline4.snp.makeConstraints{
            $0.leading.equalTo(underline3.snp.trailing).offset(4.5)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 4)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
    }
    @objc func clickfoursegment(_ sender : UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            underline1.backgroundColor = .white
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor  = .darkGray
            stockView.alpha = 0
        case 1:
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .white
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor = .darkGray
            stockView.alpha = 0
        case 2:
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .white
            underline4.backgroundColor = .darkGray
            stockView.alpha = 1
        case 3:
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor = .white
            stockView.alpha = 0
        default: break
        }
    }
}
extension ExploreViewController {
    
    private func setView(){
        self.view.addSubview(stockView)
        stockView.alpha = 0
        stockView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(23)
            $0.top.equalTo(underline4.snp.bottom).offset(32)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
