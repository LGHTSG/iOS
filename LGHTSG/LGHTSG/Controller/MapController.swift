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
    
    //MARK: - Properties
    
    private lazy var mapView: NMFMapView = {
     let map = NMFMapView(frame: CGRect(x: 50, y: 110, width: 337, height: 314))
          return map
     }()
     
    
    private lazy var replaceView: UIView = {
        
        let uview = UIView(frame: CGRect(x: 27, y: 88, width: 337, height: 314))
        uview.backgroundColor = .blue
        return uview
    }()
  
    
    private lazy var dropDown: DropDown = {
        let drop = DropDown()
        drop.dataSource = ["item1", "item2", "item3", "item4", "item5", "item6"]
        drop.layer.cornerRadius = 5
        drop.backgroundColor = .lightGray
        drop.selectionBackgroundColor = .gray
        drop.setupCornerRadius(5)
        drop.dismissMode = .automatic
        drop.show()
        
        return drop
    }()
    
    private lazy var scrollView: UIScrollView = {
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
        view.addSubview(replaceView)
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(replaceView.snp.bottom).offset(57)
            $0.width.equalTo(362)
            $0.height.equalTo(280)
        
        }
    }
    
   
}
    

    //MARK: - swiftUI

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
