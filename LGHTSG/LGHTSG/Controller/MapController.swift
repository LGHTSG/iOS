//
//  MapController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/12.
//

import UIKit
import NMapsMap
import DropDown
import SnapKit
import SwiftUI

class MapController: UIViewController {
    
    //MARK: - Map
    
    private lazy var mapView: NMFMapView = {
     let map = NMFMapView(frame: CGRect(x: 50, y: 110, width: 360, height: 270))
          return map
     }()
     
    
    private lazy var replaceView: UIView = {
        
        let uview = UIView(frame: CGRect(x: 15, y: 200, width: 360, height: 270))
        uview.backgroundColor = .white
        return uview
    }()
  
    //MARK: - DropDown

    private lazy var dropDownView: UIView = {
        let dropView = UIView(frame: CGRect(x: 15, y: 144, width: 360, height: 38))
        dropView.backgroundColor = .darkGray
    
        dropView.layer.cornerRadius = 5
        dropView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTopItem(_:)))
                dropView.addGestureRecognizer(tapGesture)
                dropView.isUserInteractionEnabled = true
        
        return dropView
    }()
    
    private lazy var chevronView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "chevron.right")
        img.tintColor = .white
        
        return img
    }()
    
    
    private lazy var dropDownLabel: UILabel = {
        let dropLabel = UILabel()
        dropLabel.text = "선택해주세요"
        dropLabel.textColor = .white
        return dropLabel
    }()
    
    private lazy var dropDown: DropDown = {
        let drop = DropDown()
        drop.dataSource = ["item1", "item2", "item3", "item4", "item5", "item6"]
        drop.textColor = .white
        drop.anchorView = dropDownView
        drop.bottomOffset = CGPoint(x: 0, y: dropDownView.bounds.height)
        drop.backgroundColor = .darkGray
        drop.selectionBackgroundColor = .gray
        drop.dismissMode = .automatic
     
        
        return drop
    }()
    
    //MARK: - TwoButton

    private lazy var priceButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 15, y: 493, width: 100, height: 30))
        btn.setTitle("가격", for: .normal)
        
        btn.layer.cornerRadius = 10
        btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        btn.backgroundColor = .darkGray
        
        return btn
    }()
    
    private lazy var saleButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 120, y: 493, width: 100, height: 30))
        btn.setTitle("매물", for: .normal)

        btn.layer.cornerRadius = 10
        btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        btn.backgroundColor = .darkGray
     
        return btn
    }()
    //MARK: - SegmentController
    private lazy var segmentCtrl: UISegmentedControl = {
        let items = ["1주", "3달", "1년", "5년"]
        let seg = UISegmentedControl(items: items)
        seg.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        seg.layer.cornerRadius = 5.0
        seg.backgroundColor = .darkGray
        seg.tintColor = .lightGray
        seg.selectedSegmentTintColor = .white
        
        return seg
    }()

    
    
    //MARK: - ForSale

    // 매물누르면 스크롤뷰 나와야함.
    private lazy var saleView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        scroll.showsVerticalScrollIndicator = false
        
        return scroll
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setMarker()
        setDropDown()
    }
    
    //MARK: - Helper
    
    private func setMarker(){
        
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 37.360553, lng: 127.110446)
        marker.iconTintColor = UIColor.red
        marker.width = 30
        marker.height = 40
        marker.mapView = mapView
    
        let infoWindow = NMFInfoWindow()
        let dataSource = NMFInfoWindowDefaultTextSource.data()
        dataSource.title = "분당중학교"
        infoWindow.dataSource = dataSource
        
        infoWindow.open(with: marker)
    }
    
    private func configure (){
        view.backgroundColor = .black
        view.addSubview(mapView)
        //view.addSubview(scrollView)
        
        [dropDownView, dropDownLabel, dropDown, chevronView, priceButton, saleButton,segmentCtrl]
          .forEach {view.addSubview($0)}

        dropDownLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(94)
            $0.leading.equalToSuperview().inset(25)
            
        }
        chevronView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(94)
            $0.trailing.equalToSuperview().inset(30)
            
        }
        
        segmentCtrl.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(priceButton.snp.bottom).offset(202)

            $0.width.equalTo(360)
            $0.height.equalTo(27.5)

        }
        
       /* scrollView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(replaceView.snp.bottom).offset(64)
            $0.width.equalTo(360)
            $0.height.equalTo(220)
        
        }*/
    }
    
    
    private func setDropDown(){
        
        dropDown.selectionAction = { [weak self] (index, item) in
            self!.dropDownLabel.text = item
            self!.chevronView.image = UIImage.init(systemName: "chevron.right")
        }
        
        dropDown.cancelAction = { [weak self] in
            self!.chevronView.image = UIImage.init(systemName: "chevron.right")
            
        }
    }
        
    @objc func didTapTopItem(_ gesture: UITapGestureRecognizer){
        dropDown.show()
        self.chevronView.image = UIImage.init(systemName: "chevron.down")
        
    }
    
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

    struct MyViewController_PreViews: PreviewProvider {
        static var previews: some View {
            MapController().toPreview() //원하는 VC를 여기다 입력하면 된다.
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

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
