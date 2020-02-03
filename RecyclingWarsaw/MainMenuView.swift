//
//  MainMenuView.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import UIKit

class MainMenuView : UIView{
    
    var button1 : UIButton!
    var button2 : UIButton!
    var button3 : UIButton!
    var button4 : UIButton!
    var button5 : UIButton!
    var button6 : UIButton!
    var button7 : UIButton!
    
    var leftVerticalStackView : UIStackView!
    var rightVerticalStackView : UIStackView!
    var leftAndRightHorizontalStackView : UIStackView!
    var leftAndRightAndBottomVerticalStackView : UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        print(frame.width)
        print(frame.height)
        button1 = UIButton(frame: .zero)
        button2 = UIButton(frame: .zero)
        button3 = UIButton(frame: .zero)
        button4 = UIButton(frame: .zero)
        button5 = UIButton(frame: .zero)
        button6 = UIButton(frame: .zero)
        button7 = UIButton(frame: .zero)
        
        
        button1?.backgroundColor = .yellow
        button2?.backgroundColor = .brown
        button3?.backgroundColor = .green
        button4?.backgroundColor = .blue
        button5?.backgroundColor = .gray
        button6?.backgroundColor = .orange
        button7?.backgroundColor = .black
        
        setUpLeftVerticalStackView()
        setUpRightVerticalStackView()
        setUpLeftAndRightHorizontalStackView()
        setUpLeftAndRightAndBottomVerticalStackView()
        
        addSubview(leftAndRightAndBottomVerticalStackView)
        leftAndRightAndBottomVerticalStackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.left.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
        }
        
    }
    func setUpLeftVerticalStackView(){
        leftVerticalStackView = UIStackView()
        leftVerticalStackView.axis = .vertical
        leftVerticalStackView.addArrangedSubview(button1)
        leftVerticalStackView.addArrangedSubview(button2)
        leftVerticalStackView.addArrangedSubview(button3)
        leftVerticalStackView.spacing = 0
        leftVerticalStackView.distribution = .fillEqually
    }
    func setUpRightVerticalStackView(){
        rightVerticalStackView = UIStackView()
        rightVerticalStackView.axis = .vertical
        rightVerticalStackView.addArrangedSubview(button4)
        rightVerticalStackView.addArrangedSubview(button5)
        rightVerticalStackView.addArrangedSubview(button6)
        rightVerticalStackView.spacing = 0
        rightVerticalStackView.distribution = .fillEqually
    }
    func setUpLeftAndRightHorizontalStackView(){
       leftAndRightHorizontalStackView = UIStackView()
       leftAndRightHorizontalStackView.axis = .horizontal
       leftAndRightHorizontalStackView.addArrangedSubview(leftVerticalStackView)
       leftAndRightHorizontalStackView.addArrangedSubview(rightVerticalStackView)
       leftAndRightHorizontalStackView.spacing = 0
       leftAndRightHorizontalStackView.distribution = .fillEqually
   }
    func setUpLeftAndRightAndBottomVerticalStackView(){
        leftAndRightAndBottomVerticalStackView = UIStackView()
        leftAndRightAndBottomVerticalStackView.axis = .vertical
        leftAndRightAndBottomVerticalStackView.addArrangedSubview(leftAndRightHorizontalStackView)
        leftAndRightAndBottomVerticalStackView.addArrangedSubview(button7)
        leftAndRightAndBottomVerticalStackView.distribution = .fillProportionally
    }
    
    
    private func setupView() {
      backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
