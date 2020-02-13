//
//  LoadFromPlistProvider.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 04/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation


protocol LoadFromPlistProvider: class{
    func loadInfoFromPlist() -> [TrashDetails]?
}

class LoadFromPlistProviderImpl: LoadFromPlistProvider{
    
    func loadInfoFromPlist() -> [TrashDetails]?
    {
        let dataFilePath = URL(fileURLWithPath: Bundle.main.path(forResource: "TrashDetails", ofType: "plist")!)
        if let data = try? Data(contentsOf: dataFilePath) {
            let decoder = PropertyListDecoder()
            do{
                let trashDetails = try decoder.decode([TrashDetails].self, from: data)
                return trashDetails
            }catch{
                print("Error decoding item array: \(error)")
            }
        }
        return nil
    }
}
