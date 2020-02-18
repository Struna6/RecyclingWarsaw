//
//  BlurView.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 18/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import UIKit

class BlurView : UIVisualEffectView{
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(duration:Double){
        alpha = 0
        isHidden = false
        //superview!.bringSubviewToFront(self)
        UIView.animate(withDuration: duration,animations: { [weak self] in
            self?.alpha = 1
        })
    }
    
    func hide(duration:Double,completion: @escaping () -> Void){
        alpha = 1
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.alpha = 0
        }, completion: { [weak self]
            (value: Bool) in
            self?.isHidden = true
            completion()
        })
    }
}
