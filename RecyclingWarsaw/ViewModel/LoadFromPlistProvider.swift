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
    func loadMenuInfoFromPlist() -> [[TrashDetails]]?
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
    
    func loadMenuInfoFromPlist() -> [[TrashDetails]]?{
        var trashDetailsTwoDimensions = [[TrashDetails]]()
        let chosenElements = loadInfoFromPlist()?.filter(){
            ($0.inMenu ?? false)
        }

        let first: [TrashDetails] = Array(chosenElements![0...1])
        let second: [TrashDetails] = Array(chosenElements![2...3])
        let third: [TrashDetails] = Array(chosenElements![4...5])
        let forth: [TrashDetails] = Array(chosenElements![6...7])
        
        trashDetailsTwoDimensions = [first,second,third,forth]
        
        return trashDetailsTwoDimensions
    }

}
