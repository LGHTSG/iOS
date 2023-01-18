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
import Charts
import CoreLocation

class EstateController: UIViewController, ChartViewDelegate {
    
    //MARK: - Map
    
    private lazy var mapView: NMFMapView = {
        let map = NMFMapView()
        let camera = map.cameraPosition
        print(camera)
        
        return map
     }()
     
    private lazy var replaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var replaceView2: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var replaceView3: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()

    private lazy var locationView: NMFNaverMapView = {
        let locView = NMFNaverMapView()
        locView.showLocationButton = true
        
        return locView
    }()
    
      
    //MARK: - DropDown

    private lazy var dropDownView: UIView = {
        let dropView = UIView()
        dropView.backgroundColor = UIColor(named: "dropdown")
        dropView.layer.cornerRadius = 5
        dropView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        dropView.frame.size.height = 38
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
        drop.backgroundColor = UIColor(named: "dropdown")
        drop.selectionBackgroundColor = .gray
        drop.dismissMode = .automatic
     
        return drop
    }()
    
    private lazy var lineImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Line"))
        return image
    }()
    
    private lazy var lineImage2: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Line"))
        return image
    }()
    
    //MARK: - TwoButton

    var flag = true
    
    private lazy var priceButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("가격", for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        flag = true
        btn.addTarget(self, action: #selector(didTapPriceBtn), for: .touchUpInside)
        return btn
    }()
    
    private lazy var saleButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("매물", for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        btn.backgroundColor = UIColor(named: "dropdown")
        btn.setTitleColor(.white, for: .normal)
        flag = false
        btn.addTarget(self, action: #selector(didTapSaleBtn), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - SegmentController
  
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

    //MARK: - ForSale

    // 매물누르면 스크롤뷰 나와야함.
    private lazy var saleView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        scroll.showsVerticalScrollIndicator = false
        
        return scroll
    }()
    
    //var lineChart = LineChartView()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setMarker()
        setDropDown()
       // setChart()
    
    }
    
   /* override func viewDidLayoutSubviews() {
        lineChart.frame = CGRect(x: 15, y: 537, width: 360, height: 170)
        lineChart.backgroundColor = .white
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        for x in 0..<10{
            entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }*/
    
   
    //MARK: - Configure
    
    private func configure (){
        view.backgroundColor = .black
        view.addSubview(replaceView)
        mapView.addSubview(locationView)
        //view.addSubview(scrollView)
      
        dropDown.bottomOffset = CGPoint(x: 0, y: dropDownView.bounds.height + 1)

        [dropDownView, dropDownLabel, dropDown, chevronView, priceButton, saleButton,lineImage,lineImage2,segmentCtrl,replaceView2]
          .forEach {view.addSubview($0)}
        
        
        
        replaceView2.snp.makeConstraints{
            $0.top.equalTo(lineImage2.snp.bottom).offset(14)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-127)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
            
        }
        
        
        saleButton.snp.makeConstraints{
            $0.leading.equalTo(priceButton.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(170)
            $0.top.equalTo(replaceView.snp.bottom).offset(24)
        }
        
        priceButton.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(275)
            $0.top.equalTo(replaceView.snp.bottom).offset(24)
            
        }
        
        replaceView.snp.makeConstraints{
            $0.top.equalTo(dropDownView.snp.bottom).offset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-375)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
       
        }
        
        locationView.snp.makeConstraints{
            $0.top.equalTo(mapView.snp.bottom).offset(5)
        }
        
        dropDownView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(86)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(38)
        }
     
        dropDownLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(94)
            $0.leading.equalToSuperview().inset(25)
            
        }
        chevronView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(94)
            $0.trailing.equalToSuperview().inset(30)
            
        }
        
        segmentCtrl.snp.makeConstraints{
            $0.top.equalTo(replaceView2.snp.bottom).offset(8)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-91)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)

        }
        lineImage.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(123)
            $0.width.equalTo(360)
        }
        
        lineImage2.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(replaceView.snp.bottom).offset(56)
        }
        
       /* scrollView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(replaceView.snp.bottom).offset(64)
            $0.width.equalTo(360)
            $0.height.equalTo(220)
        
        }*/
    }
    
    //MARK: - Helper
    /*
    private func setChart(){
        lineChart.delegate = self
    }
    */
    
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
    
    private func setDropDown(){
        
        dropDown.selectionAction = { [weak self] (index, item) in
            self!.dropDownLabel.text = item
            self!.chevronView.image = UIImage.init(systemName: "chevron.right")
        }
        
        dropDown.cancelAction = { [weak self] in
            self!.chevronView.image = UIImage.init(systemName: "chevron.right")
            
        }
    }
        
    @objc func didTapPriceBtn(){
        if flag == true {
            saleButton.backgroundColor = UIColor(named: "dropdown")
            saleButton.setTitleColor(.white, for: .normal)
            priceButton.backgroundColor = .white
            priceButton.setTitleColor(.black, for: .normal)
        }
        flag = false
    }
    
    @objc func didTapSaleBtn(){
        if flag == false {
            priceButton.backgroundColor = UIColor(named: "dropdown")
            priceButton.setTitleColor(.white, for: .normal)
            saleButton.backgroundColor = .white
            saleButton.setTitleColor(.black, for: .normal)

        }
        flag = true
        
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
    var infoWindow = NMFInfoWindow()
    var defaultInfoWindowImage = NMFInfoWindowDefaultTextSource.data()
}

    //MARK: - extension
extension EstateController: NMFMapViewTouchDelegate {
   func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
       infoWindow.close()
       
       let latlngStr = String(format: "좌표:(%.5f, %.5f)", latlng.lat, latlng.lng)
       defaultInfoWindowImage.title = latlngStr
       infoWindow.position = latlng
       infoWindow.open(with: mapView)
   }
}

    //MARK: - SwiftUI

    struct MyViewController_PreViews: PreviewProvider {
        static var previews: some View {
            EstateController().toPreview() //원하는 VC를 여기다 입력하면 된다.
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
