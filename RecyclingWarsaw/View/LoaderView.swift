//
//  LoaderView.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 18/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Lottie

class LoaderView: UIView{
    var blurEffectView: UIVisualEffectView?
    var activityIndicator: UIActivityIndicatorView?
    var animationView: AnimationView?
    
    init(animationName: String? = nil) {
        super.init(frame: .zero)
        
        setupView()
        setUpBlurEffectView()
        setupblurEffectViewConstraints()

        if let name = animationName{
            setUpLottieLoader(animationName: name)
            setUpLottieLoaderConstraints()
        }else{
            setUpActivityIndicator()
            setUpActivityIndicatorConstraints()
        }
    }
    
    private func setupView() {
      //backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLottieLoader(animationName : String){
        animationView = AnimationView(animation: Animation.named(animationName))
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 2
        addSubview(animationView!)
    }
    
    func setUpLottieLoaderConstraints(){
        animationView!.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(animationView!.snp.width)
        }
    }
    
    func setUpActivityIndicator(){
        activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator?.color = .label
        addSubview(activityIndicator!)
        //activityIndicator!.center = center
        //activityIndicator!.backgroundColor = .yellow
    }
    
    func setUpActivityIndicatorConstraints(){
        activityIndicator!.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }
    }
    
    func setUpBlurEffectView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemThinMaterial)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = bounds
        addSubview(blurEffectView!)
    }
    
    func setupblurEffectViewConstraints(){
        blurEffectView!.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
    }
    
    func show(){
        isHidden = false
        alpha = 0
        superview!.bringSubviewToFront(self)
        
        if activityIndicator != nil {
            activityIndicator!.startAnimating()
        }else{
            animationView?.play()
        }

        UIView.animate(withDuration: 1.5,animations: { [weak self] in
            self?.alpha = 1
        }, completion: { [weak self]
            (value: Bool) in
//            if self?.activityIndicator != nil {
//                self?.activityIndicator!.startAnimating()
//            }else{
//                self?.animationView?.play()
//            }
            print("obracanko")
        })
    }
    
    func hide(){
        alpha = 1
        UIView.animate(withDuration: 1.5, animations: { [weak self] in
            self?.alpha = 0
        }, completion: { [weak self]
            (value: Bool) in
            if self?.activityIndicator != nil {
                self?.activityIndicator!.stopAnimating()
            }else{
                self?.animationView?.stop()
            }
        })
        isHidden = true
    }
}
