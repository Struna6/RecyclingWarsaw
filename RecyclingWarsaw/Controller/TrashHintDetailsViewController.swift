//
//  TrashHintDetailsViewController.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 12/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import UIKit

class TrashHintDetailsViewController: TrashTypeDetailsViewController{
    var mainInfo = ""
    var additionalInfo = ""
    var trashHintName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpCategoryDetailsLabel(){
        super.setUpCategoryDetailsLabel()
        categoryDetailsLabel.text = "\(trashHintName) - \(mainInfo) \(additionalInfo)"
    }
    
    override func setUpTrashCategoryImage(){
        super.setUpTrashCategoryImage()
        trashCategoryImage.image = UIImage(named: trashFromVC!.tileImageName!)
    }
    
    override func setUpTrashCategoryNameLabel(){
        super.setUpTrashCategoryNameLabel()
        trashCategoryNameLabel.text = trashHintName
        trashCategoryNameLabel.backgroundColor = colorView.backgroundColor?.lighter(by: 5.0)//TODO
        trashCategoryNameLabel.layer.shadowColor = colorView.backgroundColor?.darker()?.cgColor
        trashCategoryNameLabel.layer.shadowOffset = CGSize(width: 0, height: 5)
        trashCategoryNameLabel.layer.shadowRadius = 2.0
        trashCategoryNameLabel.layer.shadowOpacity = 0.5
    }
}
