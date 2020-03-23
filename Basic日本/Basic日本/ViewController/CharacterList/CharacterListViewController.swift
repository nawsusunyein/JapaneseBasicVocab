//
//  CharacterListViewController.swift
//  Basic日本
//
//  Created by techfun on 2020/03/23.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var charCollectionView: UICollectionView!
    
    public var choosenColor : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionViewDelegate()
        self.registerCollectionViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    func setCollectionViewDelegate(){
        self.charCollectionView.delegate = self
        self.charCollectionView.dataSource = self
    }
    
    func registerCollectionViewCell(){
        let nibName = UINib(nibName:"CharacterListCollectionViewCell", bundle: nil)
        self.charCollectionView.register(nibName, forCellWithReuseIdentifier: "characterListCollectionViewCell")
    }
    
    //Collection View Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterListCollectionViewCell", for: indexPath) as! CharacterListCollectionViewCell
        
        if(choosenColor == "1"){
            cell.characterView?.layer.borderWidth = 1
            cell.characterView?.layer.borderColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0).cgColor
        }else if(choosenColor == "2"){
            cell.characterView?.layer.borderWidth = 1
            cell.characterView?.layer.borderColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0).cgColor
        }else if(choosenColor == "3"){
            cell.characterView?.layer.borderWidth = 1
            cell.characterView?.layer.borderColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0).cgColor
        }
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
            
            return CGSize(width: 60, height: 60)
    }
    

}
