//
//  ViewController.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import UIKit
import SnapKit

protocol TilesViewDelegate : class{
    func tileTapped(chosenTag: Int)
}
protocol TilesViewDataSource : class{
    func getImage(index: Int) -> UIImage
    func getBackgroundColor(index:Int) -> UIColor
}

class ViewController: UIViewController {
    var trashHintsLoaderImpl : TrashHintsLoader?
    var searchBarTopView : SearchBarTopView?
    var viewWithAdd : ViewWithAdd?
    var tilesView : TilesView?
    var blurEffectView : UIVisualEffectView?
    var viewWithTableView : ViewWithTableView?
    var cellHeight = 60.0
    var trashHints : [TrashHint]?
    
    var tileColors = [UIColor(red:254/255, green:183/255, blue:43/255, alpha:1.00),UIColor(red:153/255, green:95/255, blue:53/255, alpha:1.00),UIColor(red:59/255, green:175/255, blue:40/255, alpha:1.00), UIColor(red:83/255, green:88/255, blue:90/255, alpha:1.00), UIColor(red:16/255, green:113/255, blue:206/255, alpha:1.00),UIColor(red:252/255, green:102/255, blue:32/255, alpha:1.00),UIColor(red:36/255, green:33/255, blue:33/255, alpha:1.00)]
    var tileImages = [UIImage(named: "Metale"),UIImage(named: "Bio"),UIImage(named: "Szkło"),UIImage(named: "Zielone"),UIImage(named: "Papier"),UIImage(named: "Wielkogabarytowe"),UIImage(named: "Zmieszane")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello we work here")
        //SearchBarTopView
        searchBarTopView = SearchBarTopView(frame: .zero)
        searchBarTopView!.searchBar?.delegate = self
        view.addSubview(searchBarTopView!)
        
        //ViewController
        view.backgroundColor = .white //HelpfulColor
        
        //MainMenuView
        tilesView = TilesView(frame: .zero)
        
        tilesView!.delegate = self
        tilesView!.dataSource = self
        
        view.addSubview(tilesView!)
        

        //ViewWithAdd
        viewWithAdd = ViewWithAdd(frame: .zero)
        view.addSubview(viewWithAdd!)
        
        //BlurEffectView
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = view.bounds
        view.addSubview(blurEffectView!)
        blurEffectView?.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnBlur))
        tap.numberOfTapsRequired = 1
        blurEffectView!.addGestureRecognizer(tap)
        
        //ViewWithTableView
        viewWithTableView = ViewWithTableView()
        viewWithTableView?.tableView?.delegate = self
        viewWithTableView?.tableView?.dataSource = self
        viewWithTableView?.tableView?.register(TrashHintCell.self, forCellReuseIdentifier: "trashHintCell")
        viewWithTableView?.backgroundColor = .yellow
        view.addSubview(viewWithTableView!)
        viewWithTableView?.setConstraints()
        viewWithTableView?.isHidden = true
        
        //TrashHintsLoaderImpl
        trashHintsLoaderImpl = TrashHintsLoaderImpl()
    }
    
    @objc func tapOnBlur() {
        blurEffectView?.isHidden = true
        searchBarTopView?.searchBar!.resignFirstResponder()
        searchBarTopView?.searchBar!.text = ""
        viewWithTableView?.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupSearchBarTopViewConstraints()
        setupViewWithAddConstraints()
        setupMainMenuViewConstraints()
        setupblurEffectViewConstraints()
        setupViewWithTableViewConstraints()
        
        tilesView?.setUpButtons()
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

extension ViewController : TilesViewDelegate
{
    func tileTapped(chosenTag: Int){
         let detailsVC = TrashTypeDetailsViewController()
         detailsVC.chosenTag = chosenTag
         detailsVC.chosenBackgroundColor = tileColors[chosenTag-1]
         present(detailsVC, animated: true, completion: nil)
     }
}

extension ViewController : TilesViewDataSource{
    func getImage(index: Int) -> UIImage {
        return tileImages[index]!
    }
    
    func getBackgroundColor(index: Int) -> UIColor {
        return tileColors[index]
    }
}

extension ViewController : UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        blurEffectView?.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 1{
            trashHintsLoaderImpl?.loadTrashHints(text: searchText, completion: { (elements) in
                if elements != nil {
                    for el in elements!{
                        print(el.label)
                    }
                    self.trashHints = elements
                    self.viewWithTableView?.tableView?.reloadData()
                    self.viewWithTableView?.isHidden = false
                    
                    //Zmiana wysokości viewWithTableView
                    let frameHeight = self.view.frame.height
                    let howManyCellsCanBeVisible = floor(((Double(frameHeight))/2)/self.cellHeight)
                    let calculatedHeight = floor(((Double(frameHeight))/2)/self.cellHeight)*self.cellHeight
                    
                    if self.trashHints!.count > Int(howManyCellsCanBeVisible){
                        //maksymalna wysokosc i pozwol na scrollowanie
                        self.viewWithTableView!.snp.updateConstraints  { (make) -> Void in
                            make.height.equalTo(calculatedHeight)
                        }
                        self.viewWithTableView?.tableView?.isScrollEnabled = true
                    }else{
                        //obliczona dla malej liczby elementow wysokosc i nie pozwalaj na scrollowanie
                        self.viewWithTableView!.snp.updateConstraints  { (make) -> Void in
                            make.height.equalTo(self.trashHints!.count * Int(self.cellHeight))
                        }
                        self.viewWithTableView?.tableView?.isScrollEnabled = false
                    }
                }
                else{
                    print("dupa nil")
                }
            })
        }else{
            self.viewWithTableView?.isHidden = true
        }
    }
}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if trashHints != nil{
            print(trashHints!.count)
            return trashHints!.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trashHintCell", for: indexPath) as! TrashHintCell
        cell.trashNameLabel.text = trashHints![indexPath.row].label
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
}
