//
//  MapController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/12.
//

import UIKit
import NMapsMap
import SnapKit
import Charts
import Alamofire
import CoreLocation
import RxSwift
import RxCocoa

class EstateController: UIViewController, ChartViewDelegate, CLLocationManagerDelegate, NMFMapViewTouchDelegate, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate{
    
    //MARK: - SearchBar
    var items = [String]()
        var samples = [String]()
        let disposeBag = DisposeBag()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.tintColor = .white
        search.barTintColor = .black
        search.searchTextField.textColor = .white
        search.searchTextField.backgroundColor = UIColor(named: "dropdown")
        search.searchTextField.leftView?.tintColor = .white
         return search
    }()
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView2.alpha = 1
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView2.alpha = 1
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tableView2.alpha = 1
        return true
    }
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        tableView2.alpha = 1

    }

    private func input(){
          self.searchBar.rx.text.orEmpty
              .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
              .distinctUntilChanged()
              .subscribe(onNext: { t in
                  //검색이랑 검색어가 같으면 prefix로 정렬.
                  self.items = self.samples.filter{ $0.hasSuffix(t) || $0.hasPrefix(t) }
                  self.tableView2.reloadData()
              })
              .disposed(by: disposeBag)
      }
    
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
    
    private lazy var tableView1: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.alpha = 0
        return table
        
    }()
    
    private lazy var tableView2: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.alpha = 0
        return table
        
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.touchDelegate = self
        searchBar.delegate = self
        configure()
        setUpLocation()
        setupTableView()
        //reverseget(coords: coord)
        getEstateList()
        getAreaList()
        input()
    }
   
   
    //MARK: - Configure
    
    private func configure (){
        view.backgroundColor = .black
        view.addSubview(mapView)
      
        [priceButton, saleButton,lineImage2,segmentCtrl,replaceView2,tableView1,searchBar,tableView2]
          .forEach {view.addSubview($0)}
        
        tableView2.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom).offset(0)
            $0.bottom.equalTo(mapView.snp.bottom).offset(0)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        
        tableView1.snp.makeConstraints{
            $0.top.equalTo(lineImage2.snp.bottom).offset(14)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-91)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
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
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-375)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
       
        }
        
        searchBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(86)
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(38)
        }
     
        segmentCtrl.snp.makeConstraints{
            $0.top.equalTo(replaceView2.snp.bottom).offset(8)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-91)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)

        }
        
        lineImage2.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(mapView.snp.bottom).offset(56)
        }
        
    }
  
    //MARK: - EstateList
    var idxList = [Int]()
    var nameLists = [String]()
    var rateOfChange = [Double]()
    var rateCalDateDiff = [String]()
    var price = [Int]()
    
    //파라미터로 시군구 스트링으로 받아서 업데이트.
    func getEstateList() {
        let url = "http://api.lghtsg.site:8090/realestates?area=대전광역시+유성구+노은동"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(EstateModel.self, from: res)
                        self.nameLists.append(data.body.name)
                        self.idxList.append(data.body.idx)
                        self.rateOfChange.append(data.body.rateOfChange)
                        self.rateCalDateDiff.append(data.body.rateCalDateDiff)
                        self.price.append(data.body.price)
                        
                        self.tableView1.reloadData()
                    } catch {
                        print("erorr in decode")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    
    //MARK: -AreaList
    func getAreaList() {
        let url = "http://api.lghtsg.site:8090/realestates/area-relation-list"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(AreaListModel.self, from: res)
                        self.samples.append(contentsOf: data.body)
                        self.tableView2.reloadData()
                        
                    } catch {
                        print("erorr in decode")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    
    
    //MARK: - reverseget
    
    //지도 좌표값을 받아서 그 좌표값이 가지는 지역명으로 바꿔주는 함수. 바꿔준후 searchbar에 시군구 입력해줌.
    func reverseget(coords : String) {
        var alabel = ""
        let url = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=\(coord)&sourcecrs=epsg:4326&output=json&orders=legalcode,admcode,roadaddr"
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
                        self.searchBar.searchTextField.text = alabel
                        print(alabel)
                        
                    } catch {
                        print("erorr in decode")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
    }
    
    let marker = NMFMarker()
    var coord = ""
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        coord = "\(latlng.lng)" + "," + "\(latlng.lat)"
        reverseget(coords: coord)
        marker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
        marker.isHideCollidedMarkers = true
        marker.mapView = mapView
        
    }

    //MARK: - geocoding
       
    //도시이름으로 검색하면 그 지도 좌표값으로 카메라 이동하는 함수
    func geocodeget(cityName: String) {
        let url = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="
        let encodeAddress = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
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
                        lat.append(contentsOf: data.addresses[0].x)
                        let latString = String(lat)
                        lng.append(contentsOf: data.addresses[0].y)
                        let lngString = String(lng)
                        let label1 = latString + " " + lngString
                        print(label1)
                        let myDouble = (latString as NSString).doubleValue
                        let myDouble1 = (lngString as NSString).doubleValue
                        
                        let coord2 = NMGLatLng(lat: myDouble1, lng: myDouble)
                        
                        let cameraUpdate = NMFCameraUpdate(scrollTo: coord2)
                        cameraUpdate.animation = .easeIn
                        cameraUpdate.animationDuration = 2
                        self.mapView.moveCamera(cameraUpdate)
                        
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
        
        let mylat = locationManager.location?.coordinate.latitude ?? 0
        let mylng = locationManager.location?.coordinate.longitude ?? 0
        //let changeString: String = String(mylng) + "," + String(mylat)
        //reverseget(coords: changeString)
        //print(changeString)

        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: mylat, lng: mylng))
        cameraUpdate.animation = .easeIn
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 2
        mapView.moveCamera(cameraUpdate)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //MARK: - setDropDown
    @objc func didTapPriceBtn(){
        replaceView2.alpha = 1
        segmentCtrl.alpha = 1
        tableView1.alpha = 0
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
        tableView1.alpha = 1
        if flag == false {
            priceButton.backgroundColor = UIColor(named: "dropdown")
            priceButton.setTitleColor(.white, for: .normal)
            saleButton.backgroundColor = .white
            saleButton.setTitleColor(.black, for: .normal)
            
        }
        flag = true
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
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.register(EstateSaleCell.self, forCellReuseIdentifier: EstateSaleCell.identifier)
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.register(SearchItemCell.self, forCellReuseIdentifier: SearchItemCell.identifier)
    }
    
    //cell 높이조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableView1{
            
            return 55
        }else{
            return 40
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1{
            return nameLists.count
        }
        else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView1{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EstateSaleCell.identifier, for: indexPath) as? EstateSaleCell else { return UITableViewCell() }
           // cell.number = self.idxList[indexPath.row]
            cell.number.textColor = .white
            cell.title.text = self.nameLists[indexPath.row]
            cell.title.textColor = .white
            cell.area.text = "22,303,921 원/m"
            cell.area.textColor = .gray
            cell.price.text = "+ 3.0%"
            cell.price.textColor = .red
            cell.period.text = "3달 전 대비"
            cell.period.textColor = .gray
            return cell
        }
        
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchItemCell.identifier, for: indexPath) as? SearchItemCell else { return UITableViewCell() }
            cell.hello.text = self.items[indexPath.row]
            return cell
        }
    }
    // cell row 선택 시 옵션
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableView1{
        }
        else{
            tableView2.deselectRow(at: indexPath, animated: true)
            print(self.items[indexPath.row])
            self.searchBar.searchTextField.text = self.items[indexPath.row]
            geocodeget(cityName: self.searchBar.searchTextField.text!)
            tableView2.alpha = 0
        }
    }
    
}
