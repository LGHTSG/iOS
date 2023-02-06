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

class EstateController: UIViewController, ChartViewDelegate, CLLocationManagerDelegate, NMFMapViewTouchDelegate, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, UIGestureRecognizerDelegate{
    var estateModel = EstatePriceModel()
    //MARK: - SearchBar
    var items = [String]()
        var samples = [String]()
        let disposeBag = DisposeBag()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchTextField.font = UIFont(name: "NanumSquareB", size: 15)
        search.tintColor = .white
        search.barTintColor = .black
        search.searchTextField.textColor = .white
        search.searchTextField.backgroundColor = UIColor(named: "dropdown")
        search.searchTextField.leftView?.tintColor = .white
         return search
    }()
    var Areaname = "대전광역시+유성구+계산동"
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
    //MARK: - Chart
    var pricelists = [Int]()
    var timeLists = [String]()
    lazy var lineChartView : LineChartView = {
        let chartView = LineChartView()
        return chartView
    }()
    func setLineData(lineChartView: LineChartView, lineChartDataEntries: [ChartDataEntry], xAxis : [String], recentPrice : Double) {
        // Entry들을 이용해 Data Set 만들기(그런데 우리는 각 포인트를 나타내줄 필요가 없어서 지워줌
        let lineChartdataSet = LineChartDataSet(entries: lineChartDataEntries, label: "가격")
        lineChartdataSet.drawValuesEnabled = false
        lineChartdataSet.drawCirclesEnabled = false
        lineChartdataSet.colors = [.blue]
        //선택했을때 라인 지워주기
        lineChartdataSet.drawHorizontalHighlightIndicatorEnabled = false
        lineChartdataSet.highlightColor = .white
   
        // DataSet을 차트 데이터로 넣기
        let lineChartData = LineChartData(dataSet: lineChartdataSet)
        // 데이터 출력
        lineChartView.data = lineChartData
        // 선제거
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.enabled = false // 왼쪽 label 값 지워주기
        lineChartView.rightAxis.enabled = false // right
        lineChartView.xAxis.enabled = false // 위쪽 label
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        // 아래 뜨는 어떤항목인지 알려주는 label 제거
        lineChartView.legend.enabled = false
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxis)
        
        let marker = ChartMarker(pricedate: xAxis, recentprice: recentPrice)

        marker.chartView = lineChartView
        marker.chartx = view.frame.width - 10
        lineChartView.marker = marker
        lineChartView.drawMarkers = true
        // 데이터 소수점 제거
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        lineChartView.data?.setValueFormatter(DefaultValueFormatter(formatter:formatter))
    }
    // entry 만들기
    func entryData(yvalues: [Int]) -> [ChartDataEntry] {
        // entry 담을 array
        var lineDataEntries: [ChartDataEntry] = []
        // 담기
        for i in 0 ..< yvalues.count {
            let lineDataEntry = ChartDataEntry(x: Double(i), y: Double(yvalues[i]))
            lineDataEntries.append(lineDataEntry)
        }
        // 반환
        return lineDataEntries
    }
    private func setLineChartView(Areaname : String) {
        estateModel.requestStockPrice(EstateName: Areaname, onCompleted: { (pricelists, transctiontime) in
            DispatchQueue.main.async {
                self.view.addSubview(self.lineChartView)
                let sortedtimeLists = transctiontime.sorted{$0.compare($1, options: .numeric) == .orderedAscending}
                self.pricelists = pricelists
                self.timeLists = sortedtimeLists
                self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: pricelists), xAxis: sortedtimeLists, recentPrice : Double(pricelists.last!))
            }})}
    


      
    //MARK: - DropDown
    
    private lazy var lineImage2: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Line2"))
        return image
    }()
    
    //MARK: - TwoButton

    var flag = true
    
    private lazy var priceButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "NanumSquareEB", size: 15)
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
        btn.titleLabel?.font = UIFont(name: "NanumSquareEB", size: 15)
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
        getEstateList(name: Areaname)
        getAreaList()
        input()
        setLineChartView(Areaname: Areaname)
        // MARK: 키보드 올라갔을 때 화면 터치해서 내려가게함
               let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
               tapGesture.delegate = self
               self.view.addGestureRecognizer(tapGesture)
    }
   
   
    //MARK: - Configure
    
    private func configure (){
        view.backgroundColor = .black
        view.addSubview(mapView)
      
        [priceButton, saleButton,lineImage2,segmentCtrl,lineChartView,tableView1,searchBar,tableView2]
          .forEach {view.addSubview($0)}
        
        
        tableView2.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom)
            $0.bottom.equalTo(mapView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        //매물 버튼
        tableView1.snp.makeConstraints{
            $0.top.equalTo(lineImage2.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        lineChartView.snp.makeConstraints{
            $0.top.equalTo(lineImage2.snp.bottom).offset(5)
            $0.bottom.equalTo(segmentCtrl.snp.top).offset(-5)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            
        }
        
        saleButton.snp.makeConstraints{
            $0.leading.equalTo(priceButton.snp.trailing).offset(5)
            $0.top.equalTo(mapView.snp.bottom).offset(15)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
        
        priceButton.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalTo(mapView.snp.bottom).offset(15)
            $0.width.equalTo(100)
            $0.height.equalTo(30)

        }
        
        mapView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.bottom.equalTo(view.snp.centerY).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
       
        }
        
        searchBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-15)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(38)
        }
     
        segmentCtrl.snp.makeConstraints{
            $0.height.equalTo(28)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()

        }
        
        lineImage2.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(priceButton.snp.bottom).offset(-2)
        }
        
    }
  
  
    //MARK: - EstateList
    var nameLists = [String]()
    var rateOfChange = [Double]()
    var rateCalDateDiff = [String]()
    var price = [Int]()
    
    //파라미터로 시군구 스트링으로 받아서 업데이트.
    func getEstateList(name : String) {
        let urlSTR = "http://api.lghtsg.site:8090/realestates?area=\(name)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of : EstatePriceDetailModel.self) { response in
                switch response.result {
                case .success(let res):
                    do {
                        
                        for index in 0..<res.body.count {
                            self.nameLists.append(res.body[index].name)
                            self.rateCalDateDiff.append(res.body[index].rateCalDateDiff)
                            self.rateOfChange.append(res.body[index].rateOfChange)
                            self.price.append(res.body[index].price)
                        }

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
                        self.price.removeAll()
                        self.rateOfChange.removeAll()
                        self.rateCalDateDiff.removeAll()
                        self.nameLists.removeAll()
                        self.tableView1.reloadData()
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
                        self.getEstateList(name: alabel)
                        self.setLineChartView(Areaname : alabel)
                        
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
        lineChartView.alpha = 1
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
        lineChartView.alpha = 0
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
            
            cell.number.font = UIFont(name: "NanumSquareB", size: 13)
            cell.title.font = UIFont(name: "NanumSquareB", size: 13)
            cell.area.font = UIFont(name: "NanumSquareB", size: 13)
            cell.pow.font = UIFont(name: "NanumSquareB", size: 13)
            cell.price.font = UIFont(name: "NanumSquareB", size: 13)
            cell.period.font = UIFont(name: "NanumSquareB", size: 13)

            
            cell.number.text = String(indexPath.row + 1)
            cell.number.textColor = .white
            cell.title.text = self.nameLists[indexPath.row]
            cell.title.textColor = .white
            cell.area.text = "\(self.price[indexPath.row])원/m"
            cell.area.textColor = .gray
            cell.pow.text = "2"
            cell.pow.textColor = .gray
            cell.price.text = "\(self.rateOfChange[indexPath.row])%"
            if self.rateOfChange[indexPath.row] > 0 {
                cell.price.textColor = .systemRed
            }else{
                cell.price.textColor = .systemBlue
            }
                
            cell.period.text = self.rateCalDateDiff[indexPath.row]
            cell.period.textColor = .gray
            return cell
        }
        
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchItemCell.identifier, for: indexPath) as? SearchItemCell else { return UITableViewCell() }
            cell.name.font = UIFont(name: "NanumSquareB", size: 13)
            cell.name.text = self.items[indexPath.row]
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
