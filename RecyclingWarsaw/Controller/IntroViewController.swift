//
//  IntroViewController.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 24/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import UIKit
import SnapKit

class IntroViewController: UIViewController {

    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named:"Intro"))
        imageView?.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *){
            view.backgroundColor = .systemBackground
        }else{
            view.backgroundColor = .white
        }
        view.addSubview(imageView!)
        setUpImageViewConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.6) {
            let viewController = ViewController()
            viewController.modalPresentationStyle = .overFullScreen
            if #available(iOS 13.0, *){
                self.present(viewController, animated: true, completion: nil)
            }else{
                let navigationController = UINavigationController(rootViewController: viewController)
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }
    
    func setUpImageViewConstraints(){
        imageView!.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(0)
        }
    }
}
