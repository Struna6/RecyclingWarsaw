//
//  ElementsLoader.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation

protocol TrashHintsLoader : class{
    func loadTrashHints(text:String,completion: @escaping ([TrashHint]?) -> Void)
}

class TrashHintsLoaderImpl : TrashHintsLoader{
    func loadTrashHints(text:String,completion: @escaping ([TrashHint]?) -> Void) {
        let urlSession = URLSession(configuration : .ephemeral)
        let urlString = "https://segregujna5.um.warszawa.pl/wp-admin/admin-ajax.php?action=search_waste&phrase="+text
        let url = URL(string:urlString)!
        var request = URLRequest(url:url)
        
        urlSession.dataTask(with: request){[weak self] (data ,_, error) in
            var elements : [TrashHint]?
            defer{
                DispatchQueue.main.async{
                    completion(elements)
                }
            }
            guard error == nil else {return}
            guard let data = data else {return}

            elements = try? JSONDecoder().decode([TrashHint].self, from: data)
            return
        }.resume()
    }
}
