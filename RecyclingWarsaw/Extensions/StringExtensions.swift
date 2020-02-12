//
//  StringExtensions.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 12/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation


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
