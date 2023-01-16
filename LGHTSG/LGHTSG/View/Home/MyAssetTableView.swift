//
//  MyAssetView.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/12.
//

import Foundation
import UIKit
class MyAssetTableView : UITableView{
    
    self.delegate = self
    self.datasource = self}
extension MyAssetTableView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
