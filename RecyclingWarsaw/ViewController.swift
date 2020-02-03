//
//  ViewController.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   var elementsLoaderImpl : ElementsLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        elementsLoaderImpl = ElementsLoaderImpl()
        elementsLoaderImpl?.loadElements(text: "Kube", completion: { (elements) in
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

