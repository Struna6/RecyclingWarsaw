//
//  TrashHintDetailsProvider.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 13/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation

protocol TrashHintDetailsProvider: class{
    func getTrashHintDetails(urlString:String,trashDetailsFromPlist:[TrashDetails]) -> TrashHintDetails?
}

class TrashHintDetailsProviderImpl: TrashHintDetailsProvider{
    func processHTML(html:String,trashDetailsFromPlist:[TrashDetails]) -> TrashHintDetails?{
        let trashHintDetail = TrashHintDetails()
        //print(html)
        print("------------------------")
        let start = html.range(of: "waste-answer\">")?.lowerBound
        let stop = html.range(of: "<div class=\"inner-search")?.upperBound
        guard start != nil, stop != nil else {return nil}
        let neededHTML = html[start!..<stop!]
        //print(neededHTML)
        
        //Get main info
        
        let startMain = neededHTML.range(of: "<h1>")?.lowerBound
        let stopMain = neededHTML.range(of: "</h1>")?.upperBound
        guard startMain != nil, stopMain != nil else {return nil}
        let mainText = neededHTML[startMain!..<stopMain!]
        let nextText = mainText[mainText.index(mainText.startIndex,offsetBy: 4) ..< mainText.index(mainText.endIndex,offsetBy: -5)]
        
        if nextText.contains("</span>"){
             let startNextText = nextText.range(of: "</span> -")?.lowerBound
             let noSpanText = nextText[startNextText! ..< nextText.endIndex]
             let noSpanTextMore = noSpanText[noSpanText.index(noSpanText.startIndex,offsetBy: 10) ..< noSpanText.endIndex]
             //print("No Span Text:\(noSpanTextMore)")
            trashHintDetail.mainInfo = String(noSpanTextMore)
        }else{
            let startDeep = nextText.range(of: "-")?.lowerBound
            let nextTextBetter = nextText[startDeep!..<nextText.endIndex]
            //print("Next Text (noSpanBefore): \(nextTextBetter)")
            let noSpanTextMuchMore = nextTextBetter[nextTextBetter.index(nextTextBetter.startIndex,offsetBy: 1) ..< nextTextBetter.endIndex]
            trashHintDetail.mainInfo = String(noSpanTextMuchMore)
        }
        
        //Get additional info - opitonal
        
        let startAdd = neededHTML.range(of: "<p class=\"additional-info\">")?.lowerBound
        let stopAdd = neededHTML.range(of: "</p>")?.upperBound
        if startAdd != nil, stopAdd != nil {
            let addText = neededHTML[startAdd!..<stopAdd!]
            //print("Add Text: \(addText)")
            let addTextMore = addText[addText.index(addText.startIndex,offsetBy: 27) ..< addText.index(addText.endIndex,offsetBy: -4)]
            print("Next Add Text: \(addTextMore)")
            trashHintDetail.additionalInfo = String(addTextMore)
        }else{
            trashHintDetail.additionalInfo = ""
        }
        
        //Kosz
        
        let startBin = neededHTML.range(of: "<div class=\"bin")?.lowerBound
        let stopBin = neededHTML.range(of: "<div class=\"inner-search")?.upperBound
        guard startBin != nil, stopBin != nil else {return nil}
        let binText = neededHTML[startBin!..<stopBin!]
        //print("Bin Text: \(binText)")
        
        if binText.lowercased().contains("bioodpady"){
            print("KOSZ: bio")
            trashHintDetail.trashDetail = trashDetailsFromPlist[1]
        }else if binText.lowercased().contains("zmieszane"){
            print("KOSZ: zmieszane")
            trashHintDetail.trashDetail = trashDetailsFromPlist[6]
        }else if binText.lowercased().contains("papier"){
            print("KOSZ: papier")
            trashHintDetail.trashDetail = trashDetailsFromPlist[4]
        }else if binText.lowercased().contains("szkło"){
            print("KOSZ: szkło")
            trashHintDetail.trashDetail = trashDetailsFromPlist[2]
        }else if binText.lowercased().contains("gabaryty"){
            print("KOSZ: gabaryty")
            trashHintDetail.trashDetail = trashDetailsFromPlist[5]
        }else if binText.lowercased().contains("zielone"){
            print("KOSZ: zielone")
            trashHintDetail.trashDetail = trashDetailsFromPlist[3]
        }else if binText.lowercased().contains("metale"){
            print("KOSZ: metale")
            trashHintDetail.trashDetail = trashDetailsFromPlist[0]
        }else if binText.lowercased().contains("baterie"){
            print("KOSZ: baterie")
            trashHintDetail.trashDetail = trashDetailsFromPlist[7]
        }else if binText.lowercased().contains("elektrośmieci"){
            print("KOSZ: elektrośmieci")
            trashHintDetail.trashDetail = trashDetailsFromPlist[8]
        }else if binText.lowercased().contains("leki"){
            print("KOSZ: leki")
            trashHintDetail.trashDetail = trashDetailsFromPlist[9]
        }else{
            print("KOSZ: pozostałe")
            trashHintDetail.trashDetail = trashDetailsFromPlist[10]
        }
        
        print("Informacje główne: \(String(describing: trashHintDetail.mainInfo))")
        print("Informacje dodatkowe: \(String(describing: trashHintDetail.trashDetail))")
        print("Kosz: \(String(describing: trashHintDetail.trashDetail?.name))")
        
        return trashHintDetail
    }
    
    func getTrashHintDetails(urlString:String,trashDetailsFromPlist:[TrashDetails]) -> TrashHintDetails?{
       let url = URL(string: urlString)!
       do{
           let content = try String(contentsOf: url, encoding: .utf8)
           let trashHintDetails = processHTML(html: content, trashDetailsFromPlist: trashDetailsFromPlist)
           return trashHintDetails
       }catch{
           print("ERROR")
           return nil
       }
    }
}
