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
        
        
        button1?.backgroundColor = UIColor(red:254/255, green:183/255, blue:43/255, alpha:1.00)//.yellow
        button2?.backgroundColor = UIColor(red:153/255, green:95/255, blue:53/255, alpha:1.00)//.brown
        button3?.backgroundColor = UIColor(red:59/255, green:175/255, blue:40/255, alpha:1.00)//.green
        button4?.backgroundColor = UIColor(red:83/255, green:88/255, blue:90/255, alpha:1.00)//.gray
        button5?.backgroundColor = UIColor(red:16/255, green:113/255, blue:206/255, alpha:1.00)//.blue
        button6?.backgroundColor = UIColor(red:252/255, green:102/255, blue:32/255, alpha:1.00)//.orange
        button7?.backgroundColor = UIColor(red:36/255, green:33/255, blue:33/255, alpha:1.00) //.black
        
        
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
        
        button1.setImage(UIImage(named: "Metale"), for: .normal)
        
        button2.setImage(UIImage(named: "Bio"), for: .normal)
        button3.setImage(UIImage(named: "Szkło"), for: .normal)
        button4.setImage(UIImage(named: "Zielone"), for: .normal)
        button5.setImage(UIImage(named: "Papier"), for: .normal)
        button6.setImage(UIImage(named: "Wielkogabarytowe"), for: .normal)
        button7.setImage(UIImage(named: "Zmieszane"), for: .normal)

        button1.imageView?.contentMode = .scaleAspectFit
        button2.imageView?.contentMode = .scaleAspectFit
        button3.imageView?.contentMode = .scaleAspectFit
        button4.imageView?.contentMode = .scaleAspectFit
        button5.imageView?.contentMode = .scaleAspectFit
        button6.imageView?.contentMode = .scaleAspectFit
        button7.imageView?.contentMode = .scaleAspectFit
        
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
