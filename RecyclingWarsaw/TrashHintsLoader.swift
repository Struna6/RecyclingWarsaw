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
        let urlString = "https://segregujna5.um.warszawa.pl/wp-admin/admin-ajax.php?action=search_waste&phrase="+text // musimy usuwac ł i inne znaki
        let safeURL = urlString.urlPercentEncoded(withAllowedCharacters: .urlQueryAllowed, encoding: .utf8)
        let url = URL(string:safeURL)!
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

extension String {
    func urlPercentEncoded(withAllowedCharacters allowedCharacters:
        CharacterSet, encoding: String.Encoding) -> String {
        var returnStr = ""

        for char in self {
            let charStr = String(char)
            let charScalar = charStr.unicodeScalars[charStr.unicodeScalars.startIndex]
            if allowedCharacters.contains(charScalar) == false,
                let bytesOfChar = charStr.data(using: encoding) {
                for byte in bytesOfChar {
                    returnStr += "%" + String(format: "%02hhX", byte as CVarArg)
                }
            } else {
                returnStr += charStr
            }
        }

        return returnStr
    }

}
