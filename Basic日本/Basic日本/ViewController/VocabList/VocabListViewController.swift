//
//  VocabListViewController.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 2/15/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit

class VocabListViewController: UIViewController {

    @IBOutlet weak var vocabTable: UITableView!
   
    public var category : String!
    
    public var choosenLanguage : String?
    public var choosenColor : String?
    public var localizedLanguage : String?
    
    private var vocabDb : DataBaseCreation = DataBaseCreation()
    private var vocabList : [VocabularyModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getVocabList()
        self.setBackgroundColor()
        
        vocabTable.register(UINib(nibName: "VocabListTableViewCell", bundle: nil), forCellReuseIdentifier: "VocabListTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        if(self.category == "1"){
            self.title = "lbl_number".localized(self.localizedLanguage!)
        }else if(self.category == "2"){
            self.title = "lbl_day_month".localized(self.localizedLanguage!)
        }else if(self.category == "3"){
            self.title = "lbl_family".localized(self.localizedLanguage!)
        }else if(self.category == "4"){
            self.title = "lbl_animal".localized(self.localizedLanguage!)
        }else if(self.category == "5"){
            self.title = "lbl_color".localized(self.localizedLanguage!)
        }else if(self.category == "6"){
            self.title = "lbl_fruits".localized(self.localizedLanguage!)
        }else if(self.category == "7"){
            self.title = "lbl_favorite".localized(self.localizedLanguage!)
        }
    }

    private func setBackgroundColor(){
        if(choosenColor == "1"){
            self.vocabTable.backgroundColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
        }else if(choosenColor == "2"){
            self.vocabTable.backgroundColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
        }else if(choosenColor == "3"){
            self.vocabTable.backgroundColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
        }
    }
    
    private func getVocabList(){
        var queryStatementString : String? = ""
        
        if(category != nil && category != ""){
            queryStatementString = "Select * from Vocabularies where Category = '" + category + "';"
        }else{
            return
        }
       
        self.vocabList = vocabDb.readVocabList(queryStatementString: queryStatementString!)
        if(self.vocabList?.count == 0){
            self.insertVocabList()
        }
        
    }
    
    private func insertVocabList(){
        if(self.category == Category.CategoryKey.NumberKey){
            self.insertNumberVocabList()
        }else if(self.category == Category.CategoryKey.AnimalKey){
            self.insertAnimalList()
        }else{
            print("no category")
        }
    }
    
    private func insertNumberVocabList(){
        let vocabNumberMod1 = VocabularyModel(id: 1, category: "1", jpVocab: "いち", romaPronounce: "ichi", enVocab: "one", mmVocab: "တစ်", cnVocab: "一", favFlag: "0", audioFileName: "NumIchi")
        let vocabNumberMod2 = VocabularyModel(id: 2, category: "1", jpVocab: "に", romaPronounce: "ni", enVocab: "two", mmVocab: "နှစ်", cnVocab: "二", favFlag: "0", audioFileName: "NumNi")
        let vocabNumberMod3 = VocabularyModel(id: 3, category: "1", jpVocab: "さん", romaPronounce: "san", enVocab: "three", mmVocab: "သုံး", cnVocab: "三", favFlag: "0", audioFileName: "NumSan")
        let vocabNumberMod4 = VocabularyModel(id: 4, category: "1", jpVocab: "よん", romaPronounce: "yon", enVocab: "four", mmVocab: "လေး", cnVocab: "四", favFlag: "0", audioFileName: "NumYon")
        let vocabNumberMod5 = VocabularyModel(id: 5, category: "1", jpVocab: "ご", romaPronounce: "go", enVocab: "five", mmVocab: "ငါး", cnVocab: "五", favFlag: "0", audioFileName: "NumGo")
        let vocabNumberMod6 = VocabularyModel(id: 6, category: "1", jpVocab: "ろく", romaPronounce: "roku", enVocab: "six", mmVocab: "ခြောက်", cnVocab: "六", favFlag: "0", audioFileName: "NumRoku")
        let vocabNumberMod7 = VocabularyModel(id: 7, category: "1", jpVocab: "なな", romaPronounce: "nana", enVocab: "seven", mmVocab: "ခုနှစ်", cnVocab: "七", favFlag: "0", audioFileName: "NumNana")
        let vocabNumberMod8 = VocabularyModel(id: 8, category: "1", jpVocab: "はち", romaPronounce: "hachi", enVocab: "eight", mmVocab: "ရှစ်", cnVocab: "八", favFlag: "0", audioFileName: "NumHachi")
        let vocabNumberMod9 = VocabularyModel(id: 9, category: "1", jpVocab: "きゅう", romaPronounce: "kyuu", enVocab: "nine", mmVocab: "ကိုး", cnVocab: "九", favFlag: "0", audioFileName: "NumKyuu")
        let vocabNumberMod10 = VocabularyModel(id: 10, category: "1", jpVocab: "じゅう", romaPronounce: "jyuu", enVocab: "ten", mmVocab: "တစ်ဆယ်", cnVocab: "十", favFlag: "0", audioFileName: "NumJyuu")
        let vocabNumberMod11 = VocabularyModel(id: 11, category: "1", jpVocab: "じゅういち", romaPronounce: "jyuuichi", enVocab: "eleven", mmVocab: "တစ်ဆယ့်တစ်", cnVocab: "十一", favFlag: "0", audioFileName: "NumJyuuIchi")
        
        self.vocabList?.append(vocabNumberMod1)
        self.vocabList?.append(vocabNumberMod2)
        self.vocabList?.append(vocabNumberMod3)
        self.vocabList?.append(vocabNumberMod4)
        self.vocabList?.append(vocabNumberMod5)
        self.vocabList?.append(vocabNumberMod6)
        self.vocabList?.append(vocabNumberMod7)
        self.vocabList?.append(vocabNumberMod8)
        self.vocabList?.append(vocabNumberMod9)
        self.vocabList?.append(vocabNumberMod10)
        self.vocabList?.append(vocabNumberMod11)
        
        for vocabModel in self.vocabList!{
            vocabDb.insertVocabList(vocab: vocabModel)
        }
    }

    private func insertAnimalList(){
        let vocabNumberMod1 = VocabularyModel(id: 12, category: "4", jpVocab: "ねこ", romaPronounce: "neko", enVocab: "cat", mmVocab: "ကြောင်", cnVocab: "猫", favFlag: "0", audioFileName: "AniCat")
        let vocabNumberMod2 = VocabularyModel(id: 13, category: "4", jpVocab: "いぬ", romaPronounce: "inu", enVocab: "dog", mmVocab: "ခွေး", cnVocab: "狗", favFlag: "0", audioFileName: "AniDog")
               let vocabNumberMod3 = VocabularyModel(id: 14, category: "4", jpVocab: "とり", romaPronounce: "tori", enVocab: "bird", mmVocab: "ငှက်", cnVocab: "鸟", favFlag: "0", audioFileName: "AniBird")
               let vocabNumberMod4 = VocabularyModel(id: 15, category: "4", jpVocab: "さる", romaPronounce: "saru", enVocab: "monkey", mmVocab: "မျောက်", cnVocab: "猴子", favFlag: "0", audioFileName: "AniSaru")
               let vocabNumberMod5 = VocabularyModel(id: 16, category: "4", jpVocab: "しし", romaPronounce: "shishi", enVocab: "shishi", mmVocab: "ခြင်္သေ့", cnVocab: "狮子", favFlag: "0", audioFileName: "AniShi")
               let vocabNumberMod6 = VocabularyModel(id: 17, category: "4", jpVocab: "さかな", romaPronounce: "sakana", enVocab: "fish", mmVocab: "ငါး", cnVocab: "鱼", favFlag: "0", audioFileName: "AniSakana")
               let vocabNumberMod7 = VocabularyModel(id: 18, category: "4", jpVocab: "むし", romaPronounce: "mushi", enVocab: "insect", mmVocab: "ပိုးမွှား", cnVocab: "虫子", favFlag: "0", audioFileName: "AniMushi")
               let vocabNumberMod8 = VocabularyModel(id: 19, category: "4", jpVocab: "かわうそ", romaPronounce: "kawauso", enVocab: "otter", mmVocab: "ဖျံ", cnVocab: "獭", favFlag: "0", audioFileName: "AniKawauso")
               let vocabNumberMod9 = VocabularyModel(id: 20, category: "4", jpVocab: "うし", romaPronounce: "ushi", enVocab: "cow", mmVocab: "နွား", cnVocab: "牛", favFlag: "0", audioFileName: "AniUshi")
               let vocabNumberMod10 = VocabularyModel(id: 21, category: "4", jpVocab: "长颈鹿", romaPronounce: "kirin", enVocab: "giraffe", mmVocab: "သစ်ကုလားအုတ်", cnVocab: "十", favFlag: "0", audioFileName: "AniKiri")
               let vocabNumberMod11 = VocabularyModel(id: 22, category: "4", jpVocab: "とら", romaPronounce: "tora", enVocab: "tiger", mmVocab: "ကျား", cnVocab: "老虎", favFlag: "0", audioFileName: "AniTora")
        
               self.vocabList?.append(vocabNumberMod1)
               self.vocabList?.append(vocabNumberMod2)
               self.vocabList?.append(vocabNumberMod3)
               self.vocabList?.append(vocabNumberMod4)
               self.vocabList?.append(vocabNumberMod5)
               self.vocabList?.append(vocabNumberMod6)
               self.vocabList?.append(vocabNumberMod7)
               self.vocabList?.append(vocabNumberMod8)
               self.vocabList?.append(vocabNumberMod9)
               self.vocabList?.append(vocabNumberMod10)
               self.vocabList?.append(vocabNumberMod11)
               
               for vocabModel in self.vocabList!{
                   vocabDb.insertVocabList(vocab: vocabModel)
               }
    }
}

extension VocabListViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.vocabList != nil && self.vocabList!.count > 0{
            return self.vocabList!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var selectedColor : UIColor?
        let cell = tableView.dequeueReusableCell(withIdentifier: "VocabListTableViewCell", for: indexPath) as! VocabListTableViewCell
        let vocabValue = self.vocabList![indexPath.row]
        
        let origVoiceImg = UIImage(named: "voice")
        let tintVoiceImg = origVoiceImg?.withRenderingMode(.alwaysTemplate)
        cell.imgVoice.setImage(tintVoiceImg, for: .normal)
        
        let origUnFavImg = UIImage(named: vocabValue.favFlag == "0" ? "unfavorite" : "favorite")
        let tintUnFavImg = origUnFavImg?.withRenderingMode(.alwaysTemplate)
        cell.imgFavorite.setImage(tintUnFavImg, for: .normal)
        
        cell.lblJpWord.text =  vocabValue.jpVocab
        cell.lblRomaWord.text = vocabValue.romaPronounce
        if choosenLanguage == "mm"{
            cell.lblMeaningWord.text = vocabValue.mmVocab
        }else if choosenLanguage == "en"{
            cell.lblMeaningWord.text = vocabValue.enVocab
        }else{
            cell.lblMeaningWord.text = vocabValue.cnVocab
        }
        
        if(choosenColor == "1"){
            cell.imgVoice.tintColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
            cell.imgFavorite.tintColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
            selectedColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
        }else if(choosenColor == "2"){
            cell.imgVoice.tintColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
            cell.imgFavorite.tintColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
            selectedColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
        }else if(choosenColor == "3"){
            cell.imgVoice.tintColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
            cell.imgFavorite.tintColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
            selectedColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
        }
        
        cell.favButtonPressed = {
            print("here entered")
            var favFlag : String?
            if (vocabValue.favFlag == "1"){
                favFlag = "0"
            }else{
                favFlag = "1"
            }
            let favoriteStatementString = "UPDATE Vocabularies SET FavFlag = '" + favFlag! + "' WHERE ID = \(vocabValue.id);"
            let updateSts = self.vocabDb.setFavoriteVocab(favoriteStatementString: favoriteStatementString)
            if(updateSts == 1){
                vocabValue.favFlag = favFlag!
                let origFavImg = UIImage(named: favFlag == "1" ? "favorite" : "unfavorite")
                let tintFavImg = origFavImg?.withRenderingMode(.alwaysTemplate)
                cell.imgFavorite.setImage(tintFavImg, for: .normal)
                cell.imgFavorite.tintColor = selectedColor
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
