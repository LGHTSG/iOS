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
    
    /*private lazy var mapView: NMFMapView = {
     let map = NMFMapView(frame: CGRect(x: 50, y: 110, width: 300, height: 300))
          return map
     }()
     */
    
    private lazy var replaceView: UIView = {
        
        let uview = UIView(frame: CGRect(x: 50, y: 110, width: 300, height: 300))
        uview.backgroundColor = .blue
        return uview
    }()
     
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    
    
    //MARK: - Helper
    
    private func configure (){
        view.addSubview(replaceView)

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
