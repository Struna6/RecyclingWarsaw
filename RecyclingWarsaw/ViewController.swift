//
//  ViewController.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var trashHintsLoaderImpl : TrashHintsLoader?
    var searchBarTopView : SearchBarTopView?
    var viewWithAdd : ViewWithAdd?
    var mainMenuView : MainMenuView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SearchBarTopView
        searchBarTopView = SearchBarTopView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 20, height: 0))
        view.addSubview(searchBarTopView!)
        
        //ViewController
        view.backgroundColor = .red
        
        //MainMenuView
        mainMenuView = MainMenuView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
        view.addSubview(mainMenuView!)
        
        //ViewWithAdd
        viewWithAdd = ViewWithAdd(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
        view.addSubview(viewWithAdd!)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        setupSearchBarTopViewConstraints()
        setupViewWithAddConstraints()
        setupMainMenuViewConstraints()
    }
    
    func setupSearchBarTopViewConstraints(){
        searchBarTopView!.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.left.equalTo(view).offset(10)
            make.size.equalTo(CGSize(width: view.frame.width - 20, height: 50))
        }
    }
    func setupViewWithAddConstraints(){
        viewWithAdd!.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.left.equalTo(view).offset(0)
            make.size.equalTo(CGSize(width: view.frame.width, height: 90))
        }
    }
    
    func setupMainMenuViewConstraints(){
        mainMenuView!.snp.makeConstraints { (make) -> Void in
            //make.bottom.e
            make.left.equalTo(view).offset(0)
            make.top.equalTo(searchBarTopView!.snp.bottom).offset(0)
            make.bottom.equalTo(viewWithAdd!).offset(0)
            make.right.equalTo(view).offset(0)
        }
    }
    
}

