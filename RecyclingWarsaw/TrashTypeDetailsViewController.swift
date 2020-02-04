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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        print("Chosen tag is \(chosenTag)")
    }


}
