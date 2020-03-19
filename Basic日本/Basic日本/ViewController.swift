//
//  ViewController.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 2/3/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    private var choosenLanguage : String?
    private var choosenColor : String?
    private var defaults : UserDefaults?
    private var vocabArray : Array<[String:String]>? = Array<[String:String]>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCollectionViewDelegate()
        self.registerCollectionViewCell()
        
        self.defaults = UserDefaults.standard
        choosenLanguage = self.defaults!.string(forKey: "Lang")
        choosenColor = self.defaults!.string(forKey: "Color")
        if(choosenLanguage == nil){
            self.defaults?.set("mm", forKey: "Lang")
        }
        if(choosenColor == nil){
            self.defaults?.set("1",forKey: "Color")
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.setBackgroundColor()
    }
    
   
    
    private func setBackgroundColor(){
        choosenColor = self.defaults?.string(forKey: "Color")
        if(choosenColor == "1"){
             self.view.backgroundColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
        }else if(choosenColor == "2"){
            self.view.backgroundColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
        }else if(choosenColor == "3"){
             self.view.backgroundColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
        }
    }
    
    func setCollectionViewDelegate(){
        self.homeCollectionView.delegate = self
        self.homeCollectionView.dataSource = self
    }
    
    func registerCollectionViewCell(){
        let nibName = UINib(nibName:"HomeCollectionViewCell", bundle: nil)
        self.homeCollectionView.register(nibName, forCellWithReuseIdentifier: "homeCollectionViewCell")
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
        
        if indexPath.section == 0{
            if(indexPath.row == 0){
                cell.menuIcon.image = UIImage(named: "number")
                cell.menuLabel.text = "Number"
            }else{
                cell.menuIcon.image = UIImage(named: "day")
                cell.menuLabel.text = "Day/Month"
            }
        }else if indexPath.section == 1{
            if(indexPath.row == 0){
                cell.menuIcon.image = UIImage(named: "family")
                cell.menuLabel.text = "Family"
            }else{
                cell.menuIcon.image = UIImage(named: "animals")
                cell.menuLabel.text = "Animals"
            }
        }else if indexPath.section == 2{
            if(indexPath.row == 0){
                cell.menuIcon.image = UIImage(named: "color")
                cell.menuLabel.text = "Color"
            }else{
                cell.menuIcon.image = UIImage(named: "fruit")
                cell.menuLabel.text = "Fruits"
            }
        }else if indexPath.section == 3{
            if(indexPath.row == 0){
                cell.menuIcon.image = UIImage(named: "favorite")
                cell.menuLabel.text = "Favorite"
            }else{
                cell.menuIcon.image = UIImage(named: "setting")
                cell.menuLabel.text = "Setting"
            }
        }
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index row : \(indexPath.row)")
        
        if(indexPath.row != 7){
            let storyboard = UIStoryboard(name: "VocabListStoryBoard", bundle: nil)
             let vc = storyboard.instantiateViewController(withIdentifier: "VocabListViewController") as! VocabListViewController
             
             if(indexPath.row == 0){
                 vc.category = Category.CategoryKey.NumberKey
             }else if(indexPath.row == 3){
                vc.category = Category.CategoryKey.AnimalKey
            }
            
             self.navigationController?.pushViewController(vc, animated: true)
        }else{
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
