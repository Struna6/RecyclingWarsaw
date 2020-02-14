//
//  ViewController.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 03/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMobileAds

protocol TilesViewDelegate: class{
    func tileTapped(chosenTag: Int)
}
protocol TilesViewDataSource: class{
    func getImage(index: Int) -> UIImage
    func getBackgroundColor(index:Int) -> UIColor
}

class ViewController: UIViewController{
    
    var bannerView: GADBannerView!
    var trashHintsLoaderImpl: TrashHintsLoader?
    var searchBarTopView: SearchBarTopView?
    var viewWithAdd: ViewWithAdd?
    var tilesView: TilesView?
    var blurEffectView: UIVisualEffectView?
    var viewWithTableView: ViewWithTableView?
    var cellHeight = 60.0
    var trashHints: [TrashHint]?
    var loadDataFromPlist : LoadFromPlistProvider?
    var trashHintDetailsProviderImpl: TrashHintDetailsProvider?
    var adsProviderImpl: AdsProvider?
    var trashDetailsFromPlist: [TrashDetails]?
    let bannerViewMainAdID = "ca-app-pub-3940256099942544/6300978111"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        //LoadFromPlistProviderImpl
        loadDataFromPlist = LoadFromPlistProviderImpl()
        
        trashDetailsFromPlist = loadDataFromPlist!.loadInfoFromPlist()
        
        //SearchBarTopView
        searchBarTopView = SearchBarTopView(frame: .zero)
        searchBarTopView!.searchBar?.delegate = self
        view.addSubview(searchBarTopView!)
        
        //ViewController
        view.backgroundColor = .systemBackground //HelpfulColor
        
        //TilesView
        tilesView = TilesView(frame: .zero)
        
        tilesView!.delegate = self
        tilesView!.dataSource = self
        view.addSubview(tilesView!)
        
        //ViewWithAdd
        viewWithAdd = ViewWithAdd(frame: .zero)
        view.addSubview(viewWithAdd!)
        
        viewWithAdd!.addSubview(bannerView)
        AdsProvider.initiateBannerAds(baner:bannerView,VC: self,id:bannerViewMainAdID)
        
        //BlurEffectView
        setUpBlurEffectView()
        
        //ViewWithTableView
        setupViewWithTableView()
        
        //TrashHintsLoaderImpl
        trashHintsLoaderImpl = TrashHintsLoaderImpl()
        
        //TrashHintDetailsProviderImpl
        trashHintDetailsProviderImpl = TrashHintDetailsProviderImpl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchBarTopViewConstraints()
        setupViewWithAddConstraints()
        setupMainMenuViewConstraints()
        setupblurEffectViewConstraints()
        setupViewWithTableViewConstraints()
        setupAddBannerViewConstraints()
        
        tilesView?.setUpButtons()
    }
    
   func setupAddBannerViewConstraints(){
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
        }
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
            make.height.equalTo(55)
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
         detailsVC.trashTypeDetailsViewControllerDelegate = self
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
                    print("dupa nil")//PRZYPADEK - NieZwróconoZHTMLAszczegółów
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = trashHints![indexPath.row].url
        trashHintDetailsProviderImpl?.getTrashHintDetails(urlString: urlString, trashDetailsFromPlist: trashDetailsFromPlist!, completion: { (trashHintDetails, error) in
            guard trashHintDetails != nil else {return} //PRZYPADEK - NieZwróconoZHTMLAszczegółów
            trashHintDetails!.trashHintName = self.trashHints![indexPath.row].label
            print("Nazwa śmiecia: \(self.trashHints![indexPath.row].label)")
            self.goToTrashDetailsVC(trashHintDetails:trashHintDetails!)
        })
    }
    
    func goToTrashDetailsVC(trashHintDetails:TrashHintDetails){
        let detailsVC = TrashHintDetailsViewController()
        detailsVC.trashFromVC = trashHintDetails.trashDetail
        detailsVC.mainInfo = trashHintDetails.mainInfo!
        detailsVC.additionalInfo = trashHintDetails.additionalInfo!
        detailsVC.trashHintName = trashHintDetails.trashHintName!
        detailsVC.trashTypeDetailsViewControllerDelegate = self
        self.present(detailsVC, animated: true, completion: nil)
    }
}
extension ViewController : TrashTypeDetailsViewControllerDelegate{
    func reloadAdd() {
        print("RELOAD")
        AdsProvider.reloadAdd(baner: bannerView)
    }
}
