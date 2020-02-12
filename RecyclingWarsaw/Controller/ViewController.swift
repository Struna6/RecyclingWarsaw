//
//  ViewController.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import UIKit
import SnapKit

protocol TilesViewDelegate: class{
    func tileTapped(chosenTag: Int)
}
protocol TilesViewDataSource: class{
    func getImage(index: Int) -> UIImage
    func getBackgroundColor(index:Int) -> UIColor
}

class ViewController: UIViewController {
    var trashHintsLoaderImpl: TrashHintsLoader?
    var searchBarTopView: SearchBarTopView?
    var viewWithAdd: ViewWithAdd?
    var tilesView: TilesView?
    var blurEffectView: UIVisualEffectView?
    var viewWithTableView: ViewWithTableView?
    var cellHeight = 60.0
    var trashHints: [TrashHint]?
    var loadDataFromPlist = LoadFromPlistProvider()
    var trashDetailsFromPlist: [TrashDetails]?
    
    //variablesforgoingtoanothervc
    var mainInfo = ""
    var additionalInfo = ""
    var trashDetail : TrashDetails?
    var trashHintName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trashDetailsFromPlist = loadDataFromPlist.loadInfoFromPlist()
        
        //SearchBarTopView
        searchBarTopView = SearchBarTopView(frame: .zero)
        searchBarTopView!.searchBar?.delegate = self
        view.addSubview(searchBarTopView!)
        
        //ViewController
        view.backgroundColor = .white //HelpfulColor
        
        //TilesView
        tilesView = TilesView(frame: .zero)
        
        tilesView!.delegate = self
        tilesView!.dataSource = self
        view.addSubview(tilesView!)
        
        //ViewWithAdd
        viewWithAdd = ViewWithAdd(frame: .zero)
        view.addSubview(viewWithAdd!)
        
        //BlurEffectView
        setUpBlurEffectView()
        
        //ViewWithTableView
        setupViewWithTableView()
        
        //TrashHintsLoaderImpl
        trashHintsLoaderImpl = TrashHintsLoaderImpl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupSearchBarTopViewConstraints()
        setupViewWithAddConstraints()
        setupMainMenuViewConstraints()
        setupblurEffectViewConstraints()
        setupViewWithTableViewConstraints()
        
        tilesView?.setUpButtons()
    }
    
    func setUpBlurEffectView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemThinMaterial)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = view.bounds
        view.addSubview(blurEffectView!)
        blurEffectView?.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnBlur))
        tap.numberOfTapsRequired = 1
        blurEffectView!.addGestureRecognizer(tap)
    }
    
    func setupViewWithTableView(){
        viewWithTableView = ViewWithTableView()
        viewWithTableView?.tableView?.delegate = self
        viewWithTableView?.tableView?.dataSource = self
        viewWithTableView?.tableView?.register(TrashHintCell.self, forCellReuseIdentifier: "trashHintCell")
        viewWithTableView?.backgroundColor = .yellow
        view.addSubview(viewWithTableView!)
        viewWithTableView?.setConstraints()
        viewWithTableView?.isHidden = true
    }
    
    @objc func tapOnBlur() {
        blurEffectView?.isHidden = true
        searchBarTopView?.searchBar!.resignFirstResponder()
        searchBarTopView?.searchBar!.text = ""
        viewWithTableView?.isHidden = true
    }
    
    func setupSearchBarTopViewConstraints(){
        searchBarTopView!.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.equalTo(50)
        }
    }
    
    func setupViewWithAddConstraints(){
        viewWithAdd!.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(90)
        }
    }
    
    func setupMainMenuViewConstraints(){
        tilesView!.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(0)
            make.top.equalTo(searchBarTopView!.snp.bottom).offset(0)//.priority jakby cos sie stalo
            make.bottom.equalTo(viewWithAdd!.snp.top).offset(0)
            make.right.equalTo(view).offset(0)
        }
    }
    
    func setupblurEffectViewConstraints(){
        blurEffectView!.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(0)
            make.top.equalTo(searchBarTopView!.snp.bottom).offset(0)//.priority jakby cos sie stalo
            make.bottom.equalTo(viewWithAdd!.snp.top).offset(0)
            make.right.equalTo(view).offset(0)
        }
    }
    
    func setupViewWithTableViewConstraints(){
        let frameHeight = self.view.frame.height
        let calculatedHeight = floor(((Double(frameHeight))/2)/cellHeight)*cellHeight
        viewWithTableView!.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(0)
            make.top.equalTo(searchBarTopView!.snp.bottom).offset(0)//.priority jakby cos sie stalo
            make.right.equalTo(view).offset(0)
            make.height.equalTo(calculatedHeight)
        }
    }
}

extension ViewController: TilesViewDelegate
{
    func tileTapped(chosenTag: Int){
         let detailsVC = TrashTypeDetailsViewController()
         detailsVC.trashFromVC = trashDetailsFromPlist![chosenTag - 1]
         present(detailsVC, animated: true, completion: nil)
     }
}

extension ViewController: TilesViewDataSource{
    func getImage(index: Int) -> UIImage {
        return UIImage(named:(trashDetailsFromPlist![index].tileImageName!))!
    }
    
    func getBackgroundColor(index: Int) -> UIColor {
        return  UIColor(hexString:(trashDetailsFromPlist![index].color!))
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        blurEffectView?.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 1{
            trashHintsLoaderImpl?.loadTrashHints(text: searchText, completion: { [weak self] (elements) in
                guard searchBar.text!.count >= 1 else {
                    self?.viewWithTableView?.isHidden = true
                    return
                }
                if elements != nil {
                    for el in elements!{
                        print(el.label)
                    }
                    self?.trashHints = elements
                    self?.viewWithTableView?.tableView?.reloadData()
                    self?.viewWithTableView?.isHidden = false
                    
                    //Zmiana wysokości viewWithTableView
                    let frameHeight = self?.view.frame.height
                    let howManyCellsCanBeVisible = floor(((Double(frameHeight!))/2)/(self?.cellHeight ?? 1.0))
                    let calculatedHeight = floor(((Double(frameHeight ?? 1.0))/2)/(self?.cellHeight ?? 1.0))*(self?.cellHeight ?? 1.0)
                    
                    if self?.trashHints!.count ?? 0 > Int(howManyCellsCanBeVisible){
                        //maksymalna wysokosc i pozwol na scrollowanie
                        self?.viewWithTableView!.snp.updateConstraints  { (make) -> Void in
                            make.height.equalTo(calculatedHeight)
                        }
                        self?.viewWithTableView?.tableView?.isScrollEnabled = true
                    }else{
                        //obliczona dla malej liczby elementow wysokosc i nie pozwalaj na scrollowanie
                        self?.viewWithTableView!.snp.updateConstraints  { (make) -> Void in
                            make.height.equalTo((self?.trashHints!.count ?? 1) * Int(self?.cellHeight ?? 1.0))
                        }
                        self?.viewWithTableView?.tableView?.isScrollEnabled = false
                    }
                }else{
                    print("dupa nil")
                }
            })
        }else{
            self.viewWithTableView?.isHidden = true
        }
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard trashHints != nil else {return 0}
        return trashHints!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trashHintCell", for: indexPath) as! TrashHintCell
        cell.trashNameLabel.text = trashHints![indexPath.row].label
        print(trashHints![indexPath.row].url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var urlString = trashHints![indexPath.row].url
        let url = URL(string: urlString)!//Safe
        do{
            let content = try String(contentsOf: url, encoding: .utf8)
            processTrashHTML(html:content)
            print("Nazwa śmiecia: \(trashHints![indexPath.row].label)")
            trashHintName = trashHints![indexPath.row].label
            goToTrashDetailsVC()
            
        }catch{
            print("ERROR")
        }
    }
    
    func goToTrashDetailsVC(){
        let detailsVC = TrashHintDetailsViewController()
        detailsVC.trashFromVC = trashDetail
        detailsVC.mainInfo = mainInfo
        detailsVC.additionalInfo = additionalInfo
        detailsVC.trashHintName = trashHintName
        present(detailsVC, animated: true, completion: nil)
    }
    
    func processTrashHTML(html:String){
        //print(html)
        print("------------------------")
        let start = html.range(of: "waste-answer\">")?.lowerBound
        let stop = html.range(of: "<div class=\"inner-search")?.upperBound
        guard start != nil, stop != nil else {return}
        let neededHTML = html[start!..<stop!]
        //print(neededHTML)
        
        //Get main info
        
        let startMain = neededHTML.range(of: "<h1>")?.lowerBound
        let stopMain = neededHTML.range(of: "</h1>")?.upperBound
        guard startMain != nil, stopMain != nil else {return}
        let mainText = neededHTML[startMain!..<stopMain!]
        let nextText = mainText[mainText.index(mainText.startIndex,offsetBy: 4) ..< mainText.index(mainText.endIndex,offsetBy: -5)]
        
        if nextText.contains("</span>"){
             let startNextText = nextText.range(of: "</span> -")?.lowerBound
             let noSpanText = nextText[startNextText! ..< nextText.endIndex]
             let noSpanTextMore = noSpanText[noSpanText.index(noSpanText.startIndex,offsetBy: 10) ..< noSpanText.endIndex]
             //print("No Span Text:\(noSpanTextMore)")
             mainInfo = String(noSpanTextMore)
        }else{
            let startDeep = nextText.range(of: "-")?.lowerBound
            let nextTextBetter = nextText[startDeep!..<nextText.endIndex]
            //print("Next Text (noSpanBefore): \(nextTextBetter)")
            let noSpanTextMuchMore = nextTextBetter[nextTextBetter.index(nextTextBetter.startIndex,offsetBy: 1) ..< nextTextBetter.endIndex]
            mainInfo = String(noSpanTextMuchMore)
        }
        
        //Get additional info - opitonal
        
        let startAdd = neededHTML.range(of: "<p class=\"additional-info\">")?.lowerBound
        let stopAdd = neededHTML.range(of: "</p>")?.upperBound
        if startAdd != nil, stopAdd != nil {
            let addText = neededHTML[startAdd!..<stopAdd!]
            //print("Add Text: \(addText)")
            let addTextMore = addText[addText.index(addText.startIndex,offsetBy: 27) ..< addText.index(addText.endIndex,offsetBy: -4)]
            print("Next Add Text: \(addTextMore)") // <p class="additional-info">Brudne opakowanie po jajkach wyrzuć do zmieszanych.</p>
            additionalInfo = String(addTextMore)
        }
        
        //Kosz
        
        let startBin = neededHTML.range(of: "<div class=\"bin")?.lowerBound
        let stopBin = neededHTML.range(of: "<div class=\"inner-search")?.upperBound
        guard startBin != nil, stopBin != nil else {return}
        let binText = neededHTML[startBin!..<stopBin!]
        //print("Bin Text: \(binText)")
        
        if binText.lowercased().contains("bioodpady"){
            print("KOSZ: bio")
            trashDetail = trashDetailsFromPlist![1]
        }else if binText.lowercased().contains("zmieszane"){
            print("KOSZ: zmieszane")
            trashDetail = trashDetailsFromPlist![6]
        }else if binText.lowercased().contains("papier"){
            print("KOSZ: papier")
            trashDetail = trashDetailsFromPlist![4]
        }else if binText.lowercased().contains("szkło"){
            print("KOSZ: szkło")
            trashDetail = trashDetailsFromPlist![2]
        }else if binText.lowercased().contains("gabaryty"){
            print("KOSZ: gabaryty")
            trashDetail = trashDetailsFromPlist![5]
        }else if binText.lowercased().contains("zielone"){
            print("KOSZ: zielone")
            trashDetail = trashDetailsFromPlist![3]
        }else if binText.lowercased().contains("metale"){
            print("KOSZ: metale")
            trashDetail = trashDetailsFromPlist![0]
        }else{
            print("KOSZ: Coś innego") //inny
            trashDetail = trashDetailsFromPlist![7]
        }
        
        print("Informacje główne: \(mainInfo)")
        print("Informacje dodatkowe: \(trashDetail)")
        print("Kosz: \(trashDetail?.name)")
    }
}
