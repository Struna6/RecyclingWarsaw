//
//  SearchBarTopView.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SearchBarTopView : UIView{
    var searchBar : UISearchBar?
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
      searchBar = UISearchBar()
      searchBar?.backgroundColor = .white
      addSubview(searchBar!)
      setUpSearchBarConstraints()
    }
    
    private func setupView() {
      backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSearchBarConstraints(){
        searchBar!.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
    }
}
