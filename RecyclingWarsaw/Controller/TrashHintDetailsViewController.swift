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
    }
    
}
