//
//  ViewController.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 2/3/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit
import TrueTime

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    private var choosenLanguage : String?
    private var choosenColor : String?
    private var defaults : UserDefaults?
    private var localizedLanguage : String?
    private var setChosenColor : UIColor?
   
    var blogList : [Blog] = []
    var BLOG = "blog"
    var TITLE = "title"
    var CONTENTS = "contents"
    var PRICE = "price"
    
    private var notificationCenter : NotificationCenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaults = UserDefaults.standard
        
        notificationCenter = NotificationCenter.default
        notificationCenter?.addObserver(self, selector: #selector(setBackButtonByChosenLanguage(notification:)), name: Notification.Name("ChangeLanguage"), object: nil)
        notificationCenter?.addObserver(self, selector: #selector(setBackButtonColorByChosenColor(notification: )), name: NSNotification.Name("ChangeColor"), object: nil)
//        let queryString = "CREATE TABLE IF NOT EXISTS \(BLOG)" +
//        "(\(TITLE) TEXT," +
//        "\(CONTENTS) TEXT," +
//        "\(PRICE) INT)"
       // LocalStorageManager().createTable(queryString: queryString)
        //createMockBlog()
        getTodayDate()
        resetDateTime(resetTime: "00:00")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.setChosenLanguage(finish: {_ in
            self.setLanguageToLoadLocalizableFile()
        })
    
        self.setChosenColor(finish: {_ in
            self.setBackgroundColor()
        })
        
        self.setBackButtonColor()
        self.setCollectionViewDelegate()
        self.registerCollectionViewCell()
        self.homeCollectionView.reloadData()
        print("testing testing")
        print("new testing new testing new testing")
    }
    
    @IBAction func goToChat(sender : AnyObject) {
//        let chatStoryboard = UIStoryboard(name: "ChatStoryboard", bundle: nil)
//        let chatVC = chatStoryboard.instantiateViewController(withIdentifier: "ChatScene") as! ChatViewController
//        self.navigationController?.pushViewController(chatVC, animated: true)
        let chatMainStoryboard = UIStoryboard(name: "ChatMainStoryboard", bundle: nil)
        let chatMainVC = chatMainStoryboard.instantiateViewController(withIdentifier: "ChatMainScene") as! ChatMainViewController
        chatMainVC.initVC(username: "苏苏", place: "三宮商店街", chatStatus: "Valid")
        self.navigationController?.pushViewController(chatMainVC, animated: true)
    }
    
    @objc private func setBackButtonByChosenLanguage(notification:NSNotification){
        print("set back button by chosen language")
        if let language = notification.userInfo!["lang"] as? String{
            self.localizedLanguage = language
            self.setBackButtonColor()
        }
    }
    
    @objc private func setBackButtonColorByChosenColor(notification:NSNotification){
        if let color = notification.userInfo!["color"] as? String{
            if color == "1"{
                self.setChosenColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
            }else if color == "2"{
                self.setChosenColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
            }else if color == "3"{
                self.setChosenColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
            }
            DispatchQueue.main.async {
                self.setBackBarItemColor(colorNum: "1")
            }
            
        }
    }
    
    private func setChosenLanguage(finish : (_ success : Bool) -> Void){
        choosenLanguage = self.defaults!.string(forKey: "Lang")
        if(choosenLanguage == nil){
            self.defaults?.set("mm", forKey: "Lang")
            self.choosenLanguage = "mm"
        }
        finish(true)
    }
    
    private func setChosenColor(finish:(_ success : Bool) -> Void){
       choosenColor = self.defaults!.string(forKey: "Color")
       if(choosenColor == nil){
            self.defaults?.set("1",forKey: "Color")
        self.choosenColor = "1"
        }
        finish(true)
    }
    
    private func setLanguageToLoadLocalizableFile(){
        if(choosenLanguage == "mm"){
            self.localizedLanguage = "my-MM"
        }else if(choosenLanguage == "en"){
            self.localizedLanguage = "en"
        }else if(choosenLanguage == "cn"){
            self.localizedLanguage = "zh-Hans"
        }
    }
    
    private func setBackgroundColor(){
        choosenColor = self.defaults?.string(forKey: "Color")
        if(choosenColor == "1"){
             self.view.backgroundColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
            self.setChosenColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
        }else if(choosenColor == "2"){
            self.view.backgroundColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
            self.setChosenColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
        }else if(choosenColor == "3"){
             self.view.backgroundColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
            self.setChosenColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
        }
    }
    
    private func setBackButtonColor(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "lbl_back".localized(self.localizedLanguage!), style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = self.setChosenColor
    }
    
    private func setBackBarItemColor(colorNum : String){
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.red
    }
    
    func createMockBlog() {
        for i in 0..<200000 {
            let title = "title 3 \(i)"
            let contents = "When I first began learning Japanese in 2036, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2020, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade.When I first began learning Japanese in 2019, the idea of taking, let alone passing the Japanese-Language Proficiency Test (JLPT) N2 was a pipe dream, something I thought was reserved for people who have already been living in Japan for at least a decade. \(i)"
            let price = i
            let blogObj = Blog(title: title, contents: contents, price: Int32(price))
            blogList.append(blogObj)
        }
        //createUserList()
        let queryString = "INSERT INTO \(BLOG)" +
            "(\(TITLE)," +
            "\(CONTENTS)," +
            "\(PRICE)) VALUES(?,?,?)"
        
        LocalStorageManager().insert(blogList: blogList, queryString: queryString, completionError: {_ in }, readyInsertion: {_ in
            print("success insertion")
        })
    }
    
    func setCollectionViewDelegate(){
        self.homeCollectionView.delegate = self
        self.homeCollectionView.dataSource = self
    }
    
    func registerCollectionViewCell(){
        let nibName = UINib(nibName:"HomeCollectionViewCell", bundle: nil)
        self.homeCollectionView.register(nibName, forCellWithReuseIdentifier: "homeCollectionViewCell")
    }
    
    // Date setting
    
    func getTodayDate() {
        // At an opportune time (e.g. app start):
        let client = TrueTimeClient.sharedInstance
        client.start()

        // You can now use this instead of NSDate():
        let now = client.referenceTime?.now()

        // To block waiting for fetch, use the following:
        client.fetchIfNeeded(completion:  { result in
            switch result {
            case let .success(referenceTime):
                let now = referenceTime.now()
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let nowDateString = dateFormatter.string(from: now)
                let nowDateCurrentString = self.utcToLocal(dateStr: nowDateString)
                print("now : \(now)")
                print("now : \(nowDateCurrentString)")
            case let .failure(error):
                print("Error! \(error)")
            }
        })
        
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        let todayDateString = dateFormatter.string(from: todayDate)
        print("today date : \(todayDateString)")
    }
    
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            //dateFormatter.timeZone = TimeZone(secondsFromGMT: 9 * 60 * 60)
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale  = Locale(identifier: "ja-JP")
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func resetDateTime(resetTime : String) {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let resetDate = dateFormatter.date(from: resetTime)
        
        print("reset date : \(resetDate)")
        let date = Calendar.current.date(bySettingHour: 15, minute: 34, second: 0, of: now)!
        let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(resetData), userInfo: nil, repeats: false)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
    }
    
    @objc func resetData() {
        print("reset data")
    }
    
    // Collection View Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        print("index path cell \(indexPath.row)")
        print("collection view section :\(indexPath.section)")
        choosenColor = self.defaults?.string(forKey: "Color")
        
        if indexPath.section == 0{
            if(indexPath.row == 0){
                cell.menuIcon.image = UIImage(named: "Number")
                cell.menuLabel.text = "lbl_number".localized(self.localizedLanguage!)
            }else{
                cell.menuIcon.image = UIImage(named: "day")
                cell.menuLabel.text = "lbl_day_month".localized(self.localizedLanguage!)
            }
        }else if indexPath.section == 1{
            if(indexPath.row == 0){
                cell.menuIcon.image = UIImage(named: "family")
                cell.menuLabel.text = "lbl_family".localized(self.localizedLanguage!)
            }else{
                cell.menuIcon.image = UIImage(named: "animals")
                cell.menuLabel.text = "lbl_animal".localized(self.localizedLanguage!)
            }
        }else if indexPath.section == 2{
            if(indexPath.row == 0){
                cell.menuIcon.image = UIImage(named: "color")
                cell.menuLabel.text = "lbl_color".localized(self.localizedLanguage!)
            }else{
                cell.menuIcon.image = UIImage(named: "fruit")
                cell.menuLabel.text = "lbl_fruits".localized(self.localizedLanguage!)
            }
        }else if indexPath.section == 3{
            if(indexPath.row == 0){
                cell.menuIcon.image = UIImage(named: "favorite")
                cell.menuLabel.text = "lbl_favorite".localized(self.localizedLanguage!)
            }else{
                cell.menuIcon.image = UIImage(named: "setting")
                cell.menuLabel.text = "Setting"
            }
        }
        
        cell.menuIcon.image = cell.menuIcon.image?.withRenderingMode(.alwaysTemplate)
        if(self.choosenColor == "1"){
            cell.menuIcon.tintColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
            cell.menuLabel.textColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
        }else if(self.choosenColor == "2"){
            cell.menuIcon.tintColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
            cell.menuLabel.textColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
        }else if(self.choosenColor == "3"){
            cell.menuIcon.tintColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
            cell.menuLabel.textColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
        }
        
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index row : \(indexPath.row)")
        
        if(indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 || (indexPath.section == 3 && indexPath.row == 0)){
            let storyboard = UIStoryboard(name: "VocabListStoryBoard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "VocabListViewController") as! VocabListViewController
            if(indexPath.section == 0 && indexPath.row == 0){
                vc.category = Category.CategoryKey.NumberKey
            }else if(indexPath.section == 0 && indexPath.row == 1){
                vc.category = Category.CategoryKey.DayKey
            }else if(indexPath.section == 1 && indexPath.row == 0){
                vc.category = Category.CategoryKey.FamilyKey
            }else if(indexPath.section == 1 && indexPath.row == 1){
                vc.category = Category.CategoryKey.AnimalKey
            }else if(indexPath.section == 2 && indexPath.row == 0){
                vc.category = Category.CategoryKey.ColorKey
            }else if(indexPath.section == 2 && indexPath.row == 1){
                vc.category = Category.CategoryKey.FruitKey
            }else if(indexPath.section == 3 && indexPath.row == 0){
                vc.category = Category.CategoryKey.FavoriteKey
            }
            vc.choosenLanguage = self.choosenLanguage
            vc.choosenColor = self.choosenColor
            vc.localizedLanguage = self.localizedLanguage
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(indexPath.section == 3 && indexPath.row == 1){
            let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
     
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(UIDevice.modelName == "iPhone 4" || UIDevice.modelName == "iPhone 4s" || UIDevice.modelName == "iPhone 5" || UIDevice.modelName == "iPhone 5c" || UIDevice.modelName == "iPhone 5s" || UIDevice.modelName == "iPhone SE"){
           return CGSize(width: 110, height: 90)
        }else if(UIDevice.modelName == "iPhone 8 Plus" || UIDevice.modelName == "iPhone 6 Plus" || UIDevice.modelName == "iPhone 6s Plus" || UIDevice.modelName == "iPhone 7 Plus" || UIDevice.modelName == "iPhone 8 Plus" || UIDevice.modelName == "iPhone X" || UIDevice.modelName == "iPhone XS" || UIDevice.modelName == "iPhone XS Max" || UIDevice.modelName == "iPhone XR" || UIDevice.modelName == "iPhone 11" || UIDevice.modelName == "iPhone 11 Pro" || UIDevice.modelName == "iPhone 11 Pro Max"){
            return CGSize(width: 150, height: 130)
        }else{
            return CGSize(width: 120, height: 100)
        }
        //return CGSize(width: 120, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}

struct Blog {
    let title : String
    let contents : String
    let price : Int32
}
