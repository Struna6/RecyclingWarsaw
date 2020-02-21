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

class SearchBarTopView: UIView{
    var searchBar: UISearchBar?
    var activityIndicator: LoaderView!
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
      searchBar = UISearchBar()
        if #available(iOS 13.0, *) {
            searchBar?.backgroundColor = .systemBackground
        } else {
            searchBar?.backgroundColor = .white
        }
      searchBar?.searchBarStyle = .minimal
      searchBar?.placeholder = "Wyszukaj produkt"
      addSubview(searchBar!)
      activityIndicator = LoaderView(addBlur:false)
      activityIndicator.isHidden = true
      addSubview(activityIndicator)
      setUpSearchBarConstraints()
      setUpActivityIndicatorConstraints()
      activityIndicator.show()
    }
    
    private func setupView() {
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
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
    
    private func setUpActivityIndicatorConstraints(){
        activityIndicator!.snp.makeConstraints { (make) -> Void in
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalTo(activityIndicator!.snp.height)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
}
