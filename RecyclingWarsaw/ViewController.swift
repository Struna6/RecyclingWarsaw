//
//  ViewController.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   var trashHintsLoaderImpl : TrashHintsLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        trashHintsLoaderImpl = TrashHintsLoaderImpl()
        trashHintsLoaderImpl?.loadTrashHints(text: "Cera", completion: { (elements) in
            if elements != nil {
                for el in elements!{
                print(el.label)
            }
            }
            else{
                print("dupa nil")
            }
        })
    }
}

