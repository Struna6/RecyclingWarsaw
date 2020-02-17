//
//  MainMenuView.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import UIKit

class TilesView: UIView{
    
   weak var delegate: TilesViewDelegate?
   weak var dataSource: TilesViewDataSource?
    
    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    var button4: UIButton!
    var button5: UIButton!
    var button6: UIButton!
    var button7: UIButton!
    var button8: UIButton!
    
    var leftVerticalStackView: UIStackView!
    var rightVerticalStackView: UIStackView!
    var leftAndRightHorizontalStackView: UIStackView!
    var leftAndRightAndBottomVerticalStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .gray
        button1 = UIButton(frame: .zero)
        button2 = UIButton(frame: .zero)
        button3 = UIButton(frame: .zero)
        button4 = UIButton(frame: .zero)
        button5 = UIButton(frame: .zero)
        button6 = UIButton(frame: .zero)
        button7 = UIButton(frame: .zero)
        button8 = UIButton(frame: .zero)
        
        setUpLeftVerticalStackView()
        setUpRightVerticalStackView()
        setUpLeftAndRightHorizontalStackView()
        //setUpLeftAndRightAndBottomVerticalStackView()
        
        addSubview(leftAndRightHorizontalStackView)
        leftAndRightHorizontalStackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
            $0.left.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
        }
    }
    
    func setUpButtons(){
        setUpButton(button: button1, chosenTag: 1) //tag - 1 to index w plist
        setUpButton(button: button2, chosenTag: 2)
        setUpButton(button: button3, chosenTag: 3)
        setUpButton(button: button4, chosenTag: 4)
        setUpButton(button: button5, chosenTag: 5)
        setUpButton(button: button6, chosenTag: 6)
        setUpButton(button: button7, chosenTag: 7)
        setUpButton(button: button8, chosenTag: 12)
    }
    
    func setUpButton(button: UIButton, chosenTag:Int){
        button.tag = chosenTag
        button.backgroundColor = dataSource?.getBackgroundColor(index: chosenTag - 1)
        button.setImage(dataSource?.getImage(index: chosenTag - 1), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setBackgroundColor(color: (button.backgroundColor?.darker())!, forState: UIControl.State.highlighted)
        button.addTarget(self, action: #selector(actionWithParam(sender:)), for: .touchUpInside)
    }
    
    @objc func actionWithParam(sender: UIButton){
        print("Pressed \(sender.tag)")
        (delegate as! ViewController).tileTapped(chosenTag: sender.tag)
    }
    
    func setUpLeftVerticalStackView(){
        leftVerticalStackView = UIStackView()
        leftVerticalStackView.axis = .vertical
        leftVerticalStackView.addArrangedSubview(button1)
        leftVerticalStackView.addArrangedSubview(button2)
        leftVerticalStackView.addArrangedSubview(button3)
        leftVerticalStackView.addArrangedSubview(button7)
        leftVerticalStackView.spacing = 0
        leftVerticalStackView.distribution = .fillEqually
    }
    
    func setUpRightVerticalStackView(){
        rightVerticalStackView = UIStackView()
        rightVerticalStackView.axis = .vertical
        rightVerticalStackView.addArrangedSubview(button4)
        rightVerticalStackView.addArrangedSubview(button5)
        rightVerticalStackView.addArrangedSubview(button6)
        rightVerticalStackView.addArrangedSubview(button8)
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
        
       leftAndRightHorizontalStackView.alpha = 0.9
   }
    
//    func setUpLeftAndRightAndBottomVerticalStackView(){
//        leftAndRightAndBottomVerticalStackView = UIStackView()
//        leftAndRightAndBottomVerticalStackView.axis = .vertical
//        leftAndRightAndBottomVerticalStackView.addArrangedSubview(leftAndRightHorizontalStackView)
//        leftAndRightAndBottomVerticalStackView.addArrangedSubview(button7)
//        leftAndRightAndBottomVerticalStackView.distribution = .fillProportionally
//    }
    
    private func setupView() {
     // backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        }else{
            return nil
        }
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
