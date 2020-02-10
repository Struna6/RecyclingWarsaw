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
    
    
    var tileColors = [UIColor(red:254/255, green:183/255, blue:43/255, alpha:1.00),UIColor(red:153/255, green:95/255, blue:53/255, alpha:1.00),UIColor(red:59/255, green:175/255, blue:40/255, alpha:1.00), UIColor(red:83/255, green:88/255, blue:90/255, alpha:1.00), UIColor(red:16/255, green:113/255, blue:206/255, alpha:1.00),UIColor(red:252/255, green:102/255, blue:32/255, alpha:1.00),UIColor(red:36/255, green:33/255, blue:33/255, alpha:1.00)]
    var tileImages = [UIImage(named: "Metale"),UIImage(named: "Bio"),UIImage(named: "Szkło"),UIImage(named: "Zielone"),UIImage(named: "Papier"),UIImage(named: "Wielkogabarytowe"),UIImage(named: "Zmieszane")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        //TrashHintsLoaderImpl
        trashHintsLoaderImpl = TrashHintsLoaderImpl()
        trashHintsLoaderImpl?.loadTrashHints(text: "Cera", completion: { (elements) in
            if elements != nil {
                for el in elements!{
                print(el.label)
            }
            }
            else{
                print("dupa nil")
            }
        })
    }
    
    @objc func tapOnBlur() {
        blurEffectView?.isHidden = true
        searchBarTopView?.searchBar!.resignFirstResponder()
        searchBarTopView?.searchBar!.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupSearchBarTopViewConstraints()
        setupViewWithAddConstraints()
        setupMainMenuViewConstraints()
        setupblurEffectViewConstraints()
        
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
}
