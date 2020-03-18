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
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        print("index path cell \(indexPath.row)")
        if(indexPath.row == 0){
            cell.menuIcon.image = UIImage(named: "number")
            cell.menuLabel.text = "Number"
        }else if(indexPath.row == 1){
            cell.menuIcon.image = UIImage(named: "day")
                       cell.menuLabel.text = "Day/Month"
        }else if(indexPath.row == 2){
           cell.menuIcon.image = UIImage(named: "family")
           cell.menuLabel.text = "Family"
        }else if(indexPath.row == 3){
            cell.menuIcon.image = UIImage(named: "animals")
            cell.menuLabel.text = "Animals"
        }else if(indexPath.row == 4){
            cell.menuIcon.image = UIImage(named: "color")
            cell.menuLabel.text = "Color"
        }else if(indexPath.row == 5){
            cell.menuIcon.image = UIImage(named: "fruit")
                       cell.menuLabel.text = "Fruits"
        }else if(indexPath.row == 6){
           cell.menuIcon.image = UIImage(named: "favorite")
           cell.menuLabel.text = "Favorite"
        }else if(indexPath.row == 7){
            cell.menuIcon.image = UIImage(named: "setting")
            cell.menuLabel.text = "Setting"
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

