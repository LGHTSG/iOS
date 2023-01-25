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
import Alamofire
import CoreLocation


class EstateController: UIViewController, ChartViewDelegate, CLLocationManagerDelegate {
        
    //MARK: - Map
    
    private lazy var mapView: NMFMapView = {
        let map = NMFMapView()
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
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setMarker()
        setDropDown()
        setUpLocation()
        get()
    }
    
   
    //MARK: - Configure
    
    private func configure (){
        view.backgroundColor = .black
        view.addSubview(mapView)
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
            $0.top.equalTo(mapView.snp.bottom).offset(24)
        }
        
        priceButton.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(275)
            $0.top.equalTo(mapView.snp.bottom).offset(24)
            
        }
        
        mapView.snp.makeConstraints{
            $0.top.equalTo(dropDownView.snp.bottom).offset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-375)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
       
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
            $0.top.equalTo(mapView.snp.bottom).offset(56)
        }
        
       /* scrollView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mapView.snp.bottom).offset(64)
            $0.width.equalTo(360)
            $0.height.equalTo(220)
        
        }*/
    }
  

    //MARK: - Helper
    var model: [Result]?
    var label: [Result]?

    func get(){
        let url = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=129.1133567,35.2982640&sourcecrs=epsg:4326&output=json&orders=addr,admcode,roadaddr"
        
        AF.request(url, method: .get, headers: [ "X-NCP-APIGW-API-KEY-ID" : "t1d90xy372","X-NCP-APIGW-API-KEY" : "1iHB4AscQ8qLpAlct1s4h098xjv22nuxSzf9IbPu"
        ])
          .validate()
          .responseDecodable(of: ReverseModel.self, completionHandler: { response in
              self.model = response.value?.results
              self.label = self.model
              print(self.label!)
        })
    }

    //MARK: - Location
    var locationManager = CLLocationManager()
    
    func setUpLocation(){
        locationManager.delegate = self
        //거리정확도설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //사용자에게허용받기alert띄우기
        locationManager.requestWhenInUseAuthorization()
        //아이폰설정에서의위치서비스가켜진상태라면
        locationManager.startUpdatingLocation()//위치정보받아오기시작
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: (locationManager.location?.coordinate.latitude)!, lng: (locationManager.location?.coordinate.longitude)!))
        
        cameraUpdate.animation = .easeIn
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        mapView.moveCamera(cameraUpdate)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print("didUpdateLocations")
        if let location = locations.first {
            
            print("lat: \(location.coordinate.latitude)")
            print("lon: \(location.coordinate.longitude)")

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //MARK: - setMarker
     func setMarker(){
        
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
    
     func setDropDown(){
        
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
