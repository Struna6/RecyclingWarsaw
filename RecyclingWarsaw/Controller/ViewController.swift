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
import MessageUI

class ViewController: UIViewController{
    
    var bannerView: GADBannerView!
    var trashHintsLoaderImpl: TrashHintsLoader?
    var searchBarTopView: SearchBarTopView?
    var viewWithAdd: ViewWithAdd?
    var tilesView: TilesView?
    var blurEffectView: BlurView?
    var viewWithTableView: ViewWithTableView?
    var cellHeight = 60.0
    var trashHints: [TrashHint]?
    var loadDataFromPlist : LoadFromPlistProvider?
    var trashHintDetailsProviderImpl: TrashHintDetailsProvider?
    var adsProviderImpl: AdsProvider?
    var trashDetailsFromPlist: [TrashDetails]?//dodać w plist boola czy na stronie
    var trashDetailsFromPlistMenu: [[TrashDetails]]?
    var loaderView: LoaderView?
    var canSendEmail = true
    let bannerViewMainAdID = "ca-app-pub-3940256099942544/6300978111" //Testowe ID
    //let bannerViewMainAdID = "ca-app-pub-3774653118074483/8906112332"//Dobre ID
    var didSetConstraintsVC = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        //LoadFromPlistProviderImpl
        loadDataFromPlist = LoadFromPlistProviderImpl()
        
        trashDetailsFromPlist = loadDataFromPlist!.loadInfoFromPlist()
        
        //funkcja ktora wyciagnie potrzebne i do zmiennej wlozy
        trashDetailsFromPlistMenu = loadDataFromPlist!.loadMenuInfoFromPlist()
        
        //SearchBarTopView
        searchBarTopView = SearchBarTopView(frame: .zero)
        searchBarTopView!.searchBar?.delegate = self
        view.addSubview(searchBarTopView!)
        
        //ViewController
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        } //HelpfulColor
        
        //TilesView
        tilesView = TilesView()
        tilesView?.elementsHorizontalSpacing = 10
        tilesView?.rowsVerticalSpacing = 10
        
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
        
        //LoaderView
        setUpLoaderView()
        
        //ViewWithTableView
        setupViewWithTableView()
        
        //TrashHintsLoaderImpl
        trashHintsLoaderImpl = TrashHintsLoaderImpl()
        
        //TrashHintDetailsProviderImpl
        trashHintDetailsProviderImpl = TrashHintDetailsProviderImpl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if !didSetConstraintsVC{
            setupSearchBarTopViewConstraints()
            setupViewWithAddConstraints()
            setupMainMenuViewConstraints()
            setupblurEffectViewConstraints()
            setupViewWithTableViewConstraints()
            setupAddBannerViewConstraints()
            setUpLoaderViewConstraints()
            didSetConstraintsVC = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setUpLoaderView(){
        loaderView = LoaderView(animationName: "Loader2")
        view.addSubview(loaderView!)
        loaderView?.isHidden = true
    }
    
    func coverSearchbarWithABlur(){
        blurEffectView!.snp.removeConstraints()
        blurEffectView!.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(0)
            make.left.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
        }
    }
    
    func uncoverSearchbarWithABlur(){
        blurEffectView!.snp.removeConstraints()
        blurEffectView!.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(searchBarTopView!.snp.bottom).offset(0)
            make.left.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
        }
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
    
    func setUpLoaderViewConstraints(){
        loaderView!.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
        }
    }
    
    func setUpBlurEffectView(){
        var blurEffect: UIBlurEffect
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemThinMaterial)
        } else {
            blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        }
        blurEffectView = BlurView(effect: blurEffect)
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
        viewWithTableView?.tableView?.register(EmailCell.self, forCellReuseIdentifier: "emailCell")
        //viewWithTableView?.backgroundColor = .yellow
        view.addSubview(viewWithTableView!)
        viewWithTableView?.setConstraints()
        viewWithTableView?.isHidden = true
    }
    
    @objc func tapOnBlur() {
        searchBarTopView?.searchBar?.isUserInteractionEnabled = false
        tilesView?.isUserInteractionEnabled = false
        blurEffectView?.hide(duration:0.4){ [weak self] in
            self?.searchBarTopView?.searchBar?.isUserInteractionEnabled = true
            self?.tilesView?.isUserInteractionEnabled = true
        }
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
            make.bottom.equalTo(view).offset(0)
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

extension ViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        uncoverSearchbarWithABlur()
        blurEffectView?.show(duration:0.5)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 1{
            searchBarTopView!.activityIndicator.show()
            trashHintsLoaderImpl?.loadTrashHints(text: searchText, completion: { [weak self] (elements) in
                self?.searchBarTopView!.activityIndicator.hide(duration:0.5)
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
                    let howManyCellsAreInTable = (self?.canSendEmail ?? true) ? ((self?.trashHints!.count ?? 0) + 1) : (self?.trashHints!.count ?? 0)
                    if howManyCellsAreInTable > Int(howManyCellsCanBeVisible){
                        //maksymalna wysokosc i pozwol na scrollowanie
                        self?.viewWithTableView!.snp.updateConstraints  { (make) -> Void in
                            make.height.equalTo(calculatedHeight)
                        }
                        self?.viewWithTableView?.tableView?.isScrollEnabled = true
                    }else{
                        //obliczona dla malej liczby elementow wysokosc i nie pozwalaj na scrollowanie
                        self?.viewWithTableView!.snp.updateConstraints  { (make) -> Void in
                            make.height.equalTo((howManyCellsAreInTable) * Int(self?.cellHeight ?? 1.0))
                        }
                        self?.viewWithTableView?.tableView?.isScrollEnabled = false
                    }
                }else{
                    print("No internet connection")
                    if searchText.count == 3{
                        self?.searchBarTopView?.searchBar!.resignFirstResponder()//musi tu byc bo inaczej wróci klawiatura i mrugnie blur przez to
                        self?.showAlert(title:"Ups",message:"Brak połączenia z internetem",okAction:{
                            self?.tapOnBlur()
                        })
                    }
                }
            })
        }else{
            self.viewWithTableView?.isHidden = true
            searchBarTopView!.activityIndicator.hide(duration: 1.5)
        }
    }
    
    func showAlert(title:String, message:String, okAction: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default ) { action in
            okAction()
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard trashHints != nil else {return 0}
        if canSendEmail{
            return trashHints!.count + 1
        }else{
            return trashHints!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if canSendEmail && indexPath.row >= trashHints!.count {
            let emailCell = tableView.dequeueReusableCell(withIdentifier: "emailCell", for: indexPath) as! EmailCell
            emailCell.theTextLabel.text = "Nie możesz znaleźć \"\(searchBarTopView!.searchBar!.text!)\"? Wyślij maila z prośbą o dodanie tego produktu."
            return emailCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "trashHintCell", for: indexPath) as! TrashHintCell
        cell.trashNameLabel.text = trashHints?[indexPath.row].label
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) is TrashHintCell else {
            let message = "Proszę o dodanie do bazy danych produktu: \(searchBarTopView!.searchBar!.text!)"
            if canSendEmail{
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
//                    mail.setToRecipients(["segregujna5@um.warszawa.pl"])
                    mail.setToRecipients(["dodocode20@gmail.com"])
                    mail.setSubject("Uzupełnienie braków bazy danych odpadów")
                    mail.setMessageBody(message, isHTML: false)
                    self.present(mail, animated: true)
                } else {
                    self.searchBarTopView?.searchBar?.resignFirstResponder()
                    showAlert(title: "Ups", message: "Nie można wysłać maila, spróbuj ponownie później", okAction: {})
                }
                tapOnBlur()
            }
            return
        }
        coverSearchbarWithABlur()
        let urlString = trashHints![indexPath.row].url
        self.loaderView?.show()
        searchBarTopView?.searchBar?.resignFirstResponder()
        searchBarTopView?.searchBar?.text = ""
        searchBar((searchBarTopView?.searchBar!)!, textDidChange: "")
        trashHintDetailsProviderImpl?.getTrashHintDetails(urlString: urlString, trashDetailsFromPlist: trashDetailsFromPlist!, completion: { [weak self] (trashHintDetails, error) in
            guard trashHintDetails != nil else {
                self?.loaderView?.hide(duration: 1.5)
                print("No Internet connection")
                self?.showAlert(title:"Ups",message:"Brak połączenia z internetem",okAction:{ [weak self] in
                    self?.blurEffectView?.hide(duration: 1, completion: {})
                })
                return
            }
            trashHintDetails!.trashHintName = self?.trashHints![indexPath.row].label
            print("Nazwa śmiecia: \(self?.trashHints![indexPath.row].label)")
            self?.goToTrashDetailsVC(trashHintDetails:trashHintDetails!)
            self?.loaderView?.hide(duration: 1.5)
        })
    }
    
    func goToTrashDetailsVC(trashHintDetails:TrashHintDetails){
        let detailsVC = TrashHintDetailsViewController()
        detailsVC.trashFromVC = trashHintDetails.trashDetail
        detailsVC.mainInfo = trashHintDetails.mainInfo!
        detailsVC.additionalInfo = trashHintDetails.additionalInfo!
        detailsVC.trashHintName = trashHintDetails.trashHintName!
        detailsVC.trashTypeDetailsViewControllerDelegate = self
        if #available(iOS 13.0, *){
            present(detailsVC, animated: true, completion: nil)
        }else{
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

extension ViewController: TrashTypeDetailsViewControllerDelegate{
    func viewDidDisappear() {
        print("RELOAD")
        AdsProvider.reloadAdd(baner: bannerView)
        searchBarTopView?.searchBar?.isUserInteractionEnabled = false
        tilesView?.isUserInteractionEnabled = false
        blurEffectView?.hide(duration:0.1){ [weak self] in
            self?.searchBarTopView?.searchBar?.isUserInteractionEnabled = true
            self?.tilesView?.isUserInteractionEnabled = true
        }
    }
}

extension ViewController: TilesViewDataSource, TilesViewDelegate{
    func numberOfRows(in tilesView: TilesView) -> Int {
        return trashDetailsFromPlistMenu!.count
    }
    
    func numberOfElements(in tilesView: TilesView, at row: Int) -> Int {
        return trashDetailsFromPlistMenu![row].count
    }
    
    func buttonForRow(in tilesView: TilesView, at indexPath: IndexPath) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 20.0
        let element = trashDetailsFromPlistMenu![indexPath.row][indexPath.section]
        button.backgroundColor = UIColor(hexString:element.color!).withAlphaComponent(0.95)
        button.setImage(UIImage(named: element.tileImageName!), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setBackgroundColor(color: (button.backgroundColor?.darker())!, forState: UIControl.State.highlighted)
        
        return button
    }
    
    func didSelectElement(in tilesView: TilesView, at indexPath: IndexPath) {
        let detailsVC = TrashTypeDetailsViewController()
        print(indexPath.row)
        print(indexPath.section)
        detailsVC.trashFromVC = trashDetailsFromPlistMenu![indexPath.row][indexPath.section]
        detailsVC.trashTypeDetailsViewControllerDelegate = self
        if #available(iOS 13.0, *){
            present(detailsVC, animated: true, completion: nil)
        }else{
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
