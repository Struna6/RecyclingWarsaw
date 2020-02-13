//
//  TrashTypeDetailsViewController.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 04/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import UIKit

class TrashTypeDetailsViewController: UIViewController {

    var viewWithAdd: ViewWithAdd?
    var trashCategoryNameLabel: UILabel!
    var trashCategoryImage: UIImageView!
    var categoryDetailsLabel: UILabel!
    var trashFromVC : TrashDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString:(trashFromVC!.color!))
        
        //ViewWithAdd
        viewWithAdd = ViewWithAdd(frame: .zero)
        view.addSubview(viewWithAdd!)
        
        //TrashCategoryNameLabel
        setUpTrashCategoryNameLabel()
        
        //TrashCategoryImage
        setUpTrashCategoryImage()
        
        //CategoryDetailsLabel
        setUpCategoryDetailsLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViewWithAddConstraints()
        setUpLabelsAndImagesConstraints()
    }
    
    func setUpTrashCategoryNameLabel(){
        trashCategoryNameLabel = UILabel()
        //trashCategoryNameLabel.backgroundColor = .yellow //HelpfulColor
        trashCategoryNameLabel.text = trashFromVC!.name
        trashCategoryNameLabel.textAlignment = .center
        trashCategoryNameLabel.font = UIFont(descriptor:.preferredFontDescriptor(withTextStyle: .headline), size: 30)
        view.addSubview(trashCategoryNameLabel)
        trashCategoryNameLabel.textColor = .white
        trashCategoryNameLabel.adjustsFontSizeToFitWidth = true
        trashCategoryNameLabel.numberOfLines = 2
        //trashCategoryNameLabel.
    }
    
    func setUpTrashCategoryImage(){
        trashCategoryImage = UIImageView()
        trashCategoryImage.image = UIImage(named: trashFromVC!.imageName!)
        trashCategoryImage.contentMode = .scaleAspectFit
        //trashCategoryImage.backgroundColor = .gray //HelpfulColor
        view.addSubview(trashCategoryImage)
    }
    
    func setUpCategoryDetailsLabel(){
        categoryDetailsLabel = UILabel()
        categoryDetailsLabel.text = trashFromVC!.description
        categoryDetailsLabel.font = UIFont(descriptor:.preferredFontDescriptor(withTextStyle: .headline), size: 15)
        categoryDetailsLabel.adjustsFontSizeToFitWidth = true
        categoryDetailsLabel.textAlignment = .center
        //categoryDetailsLabel.backgroundColor = .purple //HelpfulColor
        categoryDetailsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        categoryDetailsLabel.numberOfLines = 0
        view.addSubview(categoryDetailsLabel)
        categoryDetailsLabel.textColor = .white
    }
    
    func setupViewWithAddConstraints(){
       viewWithAdd!.snp.makeConstraints { (make) -> Void in
           make.bottom.equalTo(view.safeAreaLayoutGuide).offset(0)
           make.left.equalTo(view).offset(0)
           make.right.equalTo(view).offset(0)
           make.height.equalTo(90)
       }
    }
    
    func setUpLabelsAndImagesConstraints(){
        trashCategoryNameLabel!.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(50)
        }
        trashCategoryImage!.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(trashCategoryNameLabel).offset(70)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(200)
        }
        categoryDetailsLabel!.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(viewWithAdd!.snp.top).offset(-20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(200)
        }
    }
}
