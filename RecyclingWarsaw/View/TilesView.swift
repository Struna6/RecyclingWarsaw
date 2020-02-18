//
//  MainMenuView.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import UIKit

protocol TilesViewDelegate: class{
    func buttonPressed(in tilesView: TilesView, at index: IndexPath)
}
protocol TilesViewDataSource: class{
    func numberOfRows(in tilesView: TilesView) -> Int
    func numberOfButtons(in tilesView: TilesView, for row: Int) -> Int
    func button(in tilesView: TilesView, at index: IndexPath) -> UIButton
}

class TilesView: UIView{
    weak var delegate: TilesViewDelegate?
    weak var dataSource: TilesViewDataSource?{
        didSet{
            //uwaga usuwac obecne buttony
            
        }
    }
    var verticalSpacing = 5
    var horizontalSpacing = 5
    
    var wholeStackView: UIStackView!
    var rowsStackViews = [UIStackView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
        
        setUpWholeStackView()
        addSubview(wholeStackView)
        wholeStackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(verticalSpacing)
            $0.left.equalToSuperview().offset(horizontalSpacing)
            $0.bottom.equalToSuperview().offset(-verticalSpacing)
            $0.right.equalToSuperview().offset(-horizontalSpacing)
        }
    }
    
    func setUpButtons(){
        guard let rows = dataSource?.numberOfRows(in: self) else {return}

        for row in 0..<rows{
            let buttons = getButtons(at: row)
            setUpRowStackView(with: buttons)
        }
    }
    
    @objc private func actionWithParam(sender: UIButton){
        print("Pressed \(sender.tag)")
        //(delegate as! ViewController).tileTapped(chosenTag: sender.tag)
    }
    
    private func getButtons(at row: Int) -> [UIButton]{
        guard let columns = dataSource?.numberOfButtons(in: self, for: row) else {return []}
        var buttons = [UIButton]()
        for col in 0..<columns{
            guard dataSource != nil else {continue}
            let button = dataSource!.button(in: self, at: IndexPath(row: row, section: col))
            buttons.append(button)
        }
        return buttons
    }
    
    private func setUpWholeStackView(){
        wholeStackView = UIStackView()
        wholeStackView.axis = .vertical
        wholeStackView.distribution = .fillEqually
        wholeStackView.alignment = .fill
        wholeStackView.spacing = CGFloat(verticalSpacing)
    }
    
    private func setUpRowStackView(with buttons: [UIButton]){
        let stackView = UIStackView()
        wholeStackView.addArrangedSubview(stackView)
        wholeStackView.layoutIfNeeded()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = CGFloat(horizontalSpacing)
        for button in buttons{
            stackView.addArrangedSubview(button)
        }
        stackView.layoutIfNeeded()
        rowsStackViews.append(stackView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
