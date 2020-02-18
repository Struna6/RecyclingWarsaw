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
        animationView?.backgroundBehavior = .pauseAndRestore
        animationView?.animationSpeed = 1
//        animationView?.play(toFrame: 75)
        addSubview(animationView!)
    }
    
    func setUpLottieLoaderConstraints(){
        animationView!.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
            make.width.equalToSuperview()//.multipliedBy(1)
            make.height.equalTo(animationView!.snp.width)
        }
    }
    
    func setUpActivityIndicator(){
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView.init(style: .large)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            activityIndicator?.color = .label
        } else {
            // Fallback on earlier versions
        }
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
        var blurEffect : UIBlurEffect
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemThinMaterial)
        } else {
            blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        }
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
            animationView?.play(toFrame: 110)
        }

        UIView.animate(withDuration: 1.5,animations: { [weak self] in
            self?.alpha = 1
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
            self?.isHidden = true
        })
    }
}
