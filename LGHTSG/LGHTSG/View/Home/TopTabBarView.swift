//
//  .swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/13.
//
//
//import Foundation
//import UIKit
//final class TopTabBarView : UIView {
//    var tabbaritemsList : [String]
//    private lazy var segmentControl : UISegmentedControl = {
//        let segment = UISegmentedControl()
//        segment.selectedSegmentTintColor = .clear
//        //배경색 제거 , 구분 라인 제거
//        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
//        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
//        segment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold)], for: .normal)
//        for i in 0..<tabbaritemsList.count{
//            segment.insertSegment(withTitle: tabbaritemsList[i], at: i, animated: true)
//        }
//        segment.selectedSegmentIndex = 0
//        segment.addTarget(self, action: #selector(onChanged(_ :)), for: .valueChanged)
//        return segment
//    }()
//    @objc func onChanged(_ sender : UISegmentedControl){
//        if sender.selectedSegmentIndex == 0 {
//            print("0")
//        }
//        else {print("1")}
//    }
//    private lazy var underLineView : UIView = {
//        let view = UIView()
//        view.backgroundColor = .secondaryLabel
//        return view
//    }()
//    init?(tabbaritemsList : [String]){
//        self.tabbaritemsList = tabbaritemsList
//        super.init(frame: .zero)
//        layout()
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    private func addunderline() -> UIView{
//        let view = UIView()
//        view.backgroundColor = .secondaryLabel
//        return view
//    }
//}
//extension TopTabBarView {
//    func layout(){
//        addSubview(segmentControl)
//        segmentControl.addSubview(underLineView)
//        
//        segmentControl.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }
//        underLineView.snp.makeConstraints{
//            $0.leading.trailing.equalTo(segmentControl).inset(20)
//            $0.height.equalTo(10)
//            $0.bottom.equalToSuperview()
//        }
//    }
//}
