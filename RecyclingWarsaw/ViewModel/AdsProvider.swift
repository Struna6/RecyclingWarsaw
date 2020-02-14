//
//  AdsProvider.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 14/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import Firebase


class AdsProvider{
   static func initiateBannerAds(baner:GADBannerView,VC: UIViewController,id: String){
      baner.adUnitID = id
      baner.rootViewController = VC
      baner.adSize = kGADAdSizeSmartBannerPortrait
      baner.load(GADRequest())
    }
}

//extension AdsProvider: GADBannerViewDelegate{
//
//}
/*baner.delegate = self*/
