//
//  UniversalTilesView.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 20/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol TilesViewDataSource : class{
    func numberOfRows(in tilesView: TilesView) -> Int
    func numberOfElements(in tilesView: TilesView,at row: Int) -> Int
    func buttonForRow(in tilesView: TilesView, at indexPath: IndexPath) -> UIButton
}

protocol TilesViewDelegate : class{
    func didSelectElement(in tilesView: TilesView, at indexPath: IndexPath)
}

class TilesView: UIView{
    weak var delegate: TilesViewDelegate?
    weak var dataSource: TilesViewDataSource?{
        didSet{
            setUpRowsStackView()
            setUpRowElements()
        }
    }
    var elementsHorizontalSpacing: CGFloat = 0.0
    var rowsVerticalSpacing: CGFloat = 0.0
    
    var rowsStackView: UIStackView!
    
    init(){
        super.init(frame: .zero)
    }
    
    func setUpRowElements(){
        guard let numberOfRows = dataSource?.numberOfRows(in: self) else {return}
        var buttonTag = 0
        for row in 0..<numberOfRows{
            let rowStackView = UIStackView()
            rowsStackView.addArrangedSubview(rowStackView)
            setUpRowStackView(rowStackView)
            guard let numberOfElements = dataSource?.numberOfElements(in: self, at: row) else {continue}
            
            for element in 0..<numberOfElements{
                guard let button = dataSource?.buttonForRow(in: self, at: IndexPath(row: row, section: element)) else {continue}
                button.addTarget(self, action: #selector(actionWithParam(sender:)), for: .touchUpInside)
                button.tag = buttonTag
                buttonTag += 1
                rowStackView.addArrangedSubview(button)
            }
        }
    }
    
    @objc func actionWithParam(sender: UIButton){
        var indexPath: IndexPath?
        var howManyElements = 0
        guard let numberOfRows = dataSource?.numberOfRows(in: self) else {return}
        for row in 0..<numberOfRows{
            guard let numberOfElements = dataSource?.numberOfElements(in: self, at: row) else {continue}
            for element in 0..<numberOfElements{
                if sender.tag == howManyElements{
                    indexPath = IndexPath(row: row, section: element)
                    delegate?.didSelectElement(in: self, at: indexPath!)
                    return
                }
                howManyElements += 1
            }
        }
    }
    
    func setUpRowStackView(_ rowStackView: UIStackView){
        rowStackView.axis = .horizontal
        rowStackView.spacing = elementsHorizontalSpacing
        rowStackView.distribution = .fillEqually
    }
    
    func setUpRowsStackView(){
        rowsStackView = UIStackView()
        rowsStackView.axis = .vertical
        rowsStackView.spacing = rowsVerticalSpacing
        rowsStackView.distribution = .fillEqually
        addSubview(rowsStackView)
        rowsStackView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: rowsVerticalSpacing, left: elementsHorizontalSpacing, bottom: rowsVerticalSpacing, right: elementsHorizontalSpacing))
       }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

