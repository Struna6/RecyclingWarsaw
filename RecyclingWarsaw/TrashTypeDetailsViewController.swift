//
//  TrashTypeDetailsViewController.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 04/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import UIKit

class TrashTypeDetailsViewController: UIViewController {

    var chosenTag : Int?
    var viewWithAdd : ViewWithAdd?
    
    var trashCategoryNameLabel : UILabel!
    var trashCategoryImage : UIImageView!
    var categoryDetailsLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        print("Chosen tag is \(chosenTag)")
        
        //ViewWithAdd
        viewWithAdd = ViewWithAdd(frame: .zero)
        view.addSubview(viewWithAdd!)
        
        //LabelsAndImage
        trashCategoryNameLabel = UILabel()
        trashCategoryImage = UIImageView()
        categoryDetailsLabel = UILabel()
        
        
        view.backgroundColor = .green
        
        trashCategoryNameLabel.backgroundColor = .yellow
        trashCategoryNameLabel.text = "Szkło"
        trashCategoryNameLabel.textAlignment = .center
        trashCategoryNameLabel.font = UIFont(descriptor:.preferredFontDescriptor(withTextStyle: .headline), size: 30)
        
        trashCategoryImage.image = UIImage(named: "Szkło")
        trashCategoryImage.contentMode = .scaleAspectFit
        trashCategoryImage.backgroundColor = .gray
        
        categoryDetailsLabel.text = "Szklane butelki, szklane okulary, szyby, szklane kubki, szklanki, produktu zrobiobne ze szkła i inne szklane rzeczy"
        categoryDetailsLabel.font = UIFont(descriptor:.preferredFontDescriptor(withTextStyle: .headline), size: 18)
        categoryDetailsLabel.textAlignment = .center
        categoryDetailsLabel.backgroundColor = .purple
        categoryDetailsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        categoryDetailsLabel.numberOfLines = 5
        
        view.addSubview(trashCategoryNameLabel)
        view.addSubview(trashCategoryImage)
        view.addSubview(categoryDetailsLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViewWithAddConstraints()
        setUpLabelsAndImagesConstraints()
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
            make.top.equalTo(trashCategoryNameLabel).offset(50)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(200)
        }
        categoryDetailsLabel!.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(viewWithAdd!.snp.top).offset(-20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(150)
        }
    }
}
