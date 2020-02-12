//
//  ViewWithTableView.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 10/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ViewWithTableView: UIView{
    var tableView: UITableView?
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      tableView = UITableView()
      addSubview(tableView!)
      tableView?.backgroundColor = .red
    }
    
    func setConstraints(){
        tableView!.snp.makeConstraints{
          $0.top.equalToSuperview().offset(0)
          $0.left.equalToSuperview().offset(0)
          $0.right.equalToSuperview().offset(0)
          $0.bottom.equalToSuperview().offset(0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
