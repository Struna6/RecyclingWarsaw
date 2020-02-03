//
//  ElementsLoader.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation

protocol ElementsLoader : class{
    func loadElements(text:String,completion: @escaping ([Element]?) -> Void)
}

class ElementsLoaderImpl : ElementsLoader{
func loadElements(text:String,completion: @escaping ([Element]?) -> Void) {
    let urlSession = URLSession(configuration : .ephemeral)
    let urlString = "https://segregujna5.um.warszawa.pl/wp-admin/admin-ajax.php?action=search_waste&phrase="+text+"&fbclid=IwAR3OVOg7ZJkZon0jHqsTgODjwI3GZuCPuRkvPLRwRF79nmxfFJnXhCOsW1U"
    let url = URL(string:urlString)!
    var request = URLRequest(url:url)
    
    urlSession.dataTask(with: request){[weak self] (data ,_, error) in
        var elements : [Element]?
        defer{
            DispatchQueue.main.async{
                completion(elements)
            }
        }
        guard error == nil else {return}
        guard let data = data else {return}

        elements = try? JSONDecoder().decode([Element].self, from: data)
        return
    }.resume()
}
}
