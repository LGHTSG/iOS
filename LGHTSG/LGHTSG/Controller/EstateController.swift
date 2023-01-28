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
import Charts
import Alamofire
import CoreLocation


class EstateController: UIViewController, ChartViewDelegate, CLLocationManagerDelegate, NMFMapViewTouchDelegate, UITableViewDelegate,UITableViewDataSource{
    
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
        dropView.addSubview(cityTextField)
        return dropView
    }()
    
    private lazy var cityTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    //실시간으로 tf 바뀌는거 받아오는거
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.dropDown.dataSource[0] = self.cityTextField.text!
    }

    
    private lazy var chevronView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "chevron.right")
        img.tintColor = .white
        
        return img
    }()
    
    var items = [String]()
        let samples = ["서울", "부산", "온수", "건대", "온수", "부천", "송파", "가", "가나", "가나다", "가나다라", "가카타파하", "에이", "a", "ab", "abc", "apple", "mac", "azxy"]
    
    
    private lazy var dropDown: DropDown = {
        let drop = DropDown()
        drop.dataSource = samples
        //drop.dataSource = ["item1", "item2", "item3", "item4", "item5", "item6"]
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
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.alpha = 0
        return table
        
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.touchDelegate = self
        configure()
        setDropDown()
        setUpLocation()
        setupTableView()
        reverseget()
        geocodeget()
    }
   
   
    //MARK: - Configure
    
    private func configure (){
        view.backgroundColor = .black
        view.addSubview(mapView)
        //view.addSubview(scrollView)
      
        dropDown.bottomOffset = CGPoint(x: 0, y: dropDownView.bounds.height + 1)
        [dropDownView, dropDown, chevronView, priceButton, saleButton,lineImage,lineImage2,segmentCtrl,replaceView2,tableView]
          .forEach {view.addSubview($0)}
        
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(lineImage2.snp.bottom).offset(14)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-91)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        cityTextField.snp.makeConstraints{
            $0.top.equalTo(dropDownView.snp.top).offset(6)
            $0.leading.equalTo(dropDownView.snp.leading).offset(10)
            $0.trailing.equalTo(dropDownView.snp.trailing).offset(-30)
            $0.bottom.equalTo(dropDownView.snp.bottom).offset(-6)
        }
        
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
        
    }
  

    //MARK: - Helper
    
    
    //좌표 찍으면 tf에 주소가 찍혀야함.
    func reverseget() {
        var alabel = ""
        let url = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=126.647063,37.450851&sourcecrs=epsg:4326&output=json&orders=legalcode,admcode,roadaddr"
        let header: HTTPHeaders = [ "X-NCP-APIGW-API-KEY-ID" : "t1d90xy372","X-NCP-APIGW-API-KEY" : "1iHB4AscQ8qLpAlct1s4h098xjv22nuxSzf9IbPu" ]
        var si : [Character] = []
        var gu : [Character] = []
        var dong : [Character] = []
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(ReverseModel.self, from: res)
                        //self.model.append(contentsOf: data.results)
                        si.append(contentsOf: data.results[0].region.area1.name)
                        let siString = String(si)
                        gu.append(contentsOf: data.results[0].region.area2.name)
                        let guString = String(gu)
                        dong.append(contentsOf: data.results[0].region.area3.name)
                        let dongString = String(dong)
                        alabel = siString + " " + guString + " " + dongString
                        self.cityTextField.text = alabel
                        print(alabel)
                        
                    } catch {
                        print("erorr in decode")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }

    }
    //마커 1개만 찍고싶음 추가하자..
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        //print("\(latlng.lat), \(latlng.lng)")
        let coord = "\(latlng.lng)" + "," + "\(latlng.lat)"
        print(coord)
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
        marker.isHideCollidedMarkers = true
        marker.mapView = mapView
        
    }

    //MARK: - geocoding
    
    

    // 텍스트를 입력받아 그 값을 토대로 좌표제공 받아 카메라 이동 및 마커 찍어주면 됨.
    // 한글입력하면 좌표 추출완료. 그러면 tf값을 hello로 일단 옮기자. 그러면 tf값의 도시의 그 좌표값이 나오는데 그걸로 카메라 이동 및 좌표찍기
    func geocodeget() {
        let url = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="
        let hello = "인천광역시 미추홀구 용현동"
        let encodeAddress = hello.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        var lat : [Character] = []
        var lng : [Character] = []
        
        let header: HTTPHeaders = [ "X-NCP-APIGW-API-KEY-ID" : "t1d90xy372","X-NCP-APIGW-API-KEY" : "1iHB4AscQ8qLpAlct1s4h098xjv22nuxSzf9IbPu" ]
        
        AF.request(url + encodeAddress, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(GeocodingModel.self, from: res)
                        //self.model.append(contentsOf: data.results)
                        lat.append(contentsOf: data.addresses[0].x)
                        let latString = String(lat)
                        lng.append(contentsOf: data.addresses[0].y)
                        let lngString = String(lng)
                        var label1 = latString + " " + lngString
                        print(label1)
                        
                    } catch {
                        print("erorr in decode")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
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
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
        
        cameraUpdate.animation = .easeIn
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        mapView.moveCamera(cameraUpdate)
        
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.mapView = mapView
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //MARK: - setDropDown
     
     func setDropDown(){
        dropDown.selectionAction = { [weak self] (index, item) in
            self!.cityTextField.text = item
            self!.chevronView.image = UIImage.init(systemName: "chevron.right")
        }
        dropDown.cancelAction = { [weak self] in
            self!.chevronView.image = UIImage.init(systemName: "chevron.right")
        }
    }
        
    @objc func didTapPriceBtn(){
        replaceView2.alpha = 1
        segmentCtrl.alpha = 1
        tableView.alpha = 0
        if flag == true {
            saleButton.backgroundColor = UIColor(named: "dropdown")
            saleButton.setTitleColor(.white, for: .normal)
            priceButton.backgroundColor = .white
            priceButton.setTitleColor(.black, for: .normal)
        }
        flag = false
        
    }
    
    @objc func didTapSaleBtn(){
        replaceView2.alpha = 0
        segmentCtrl.alpha = 0
        tableView.alpha = 1
        if flag == false {
            priceButton.backgroundColor = UIColor(named: "dropdown")
            priceButton.setTitleColor(.white, for: .normal)
            saleButton.backgroundColor = .white
            saleButton.setTitleColor(.black, for: .normal)
            
        }
        flag = true
        
    }
    
    @objc func didTapTopItem(_ gesture: UITapGestureRecognizer){
        guard let text = cityTextField.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
               return
           }
        cityTextField.resignFirstResponder()
        
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
    //MARK: - TableView
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EstateSaleCell.self, forCellReuseIdentifier: EstateSaleCell.identifier)
    }
    
    //cell 높이조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 55
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EstateSaleCell.identifier, for: indexPath) as? EstateSaleCell else { return UITableViewCell() }
        
        cell.number.text = "1"
        cell.number.textColor = .white
        cell.title.text = "서울특별시 강남구 논현동 아파트"
        cell.title.textColor = .white
        cell.area.text = "22,303,921 원/m"
        cell.area.textColor = .gray
        cell.price.text = "+ 3.0%"
        cell.price.textColor = .red
        cell.period.text = "3달 전 대비"
        cell.period.textColor = .gray
        
        return cell
    }
    
}
