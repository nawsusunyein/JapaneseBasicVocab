//
//  VocabListViewController.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 2/15/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit
import AVFoundation

class VocabListViewController: UIViewController, AVAudioPlayerDelegate{

    @IBOutlet weak var vocabTable: UITableView!
   
    public var category : String!
    
    public var choosenLanguage : String?
    public var choosenColor : String?
    public var localizedLanguage : String?
    
    private var vocabAudioPlayer : AVAudioPlayer?
    private var vocabDb : DataBaseCreation = DataBaseCreation()
    private var vocabList : [VocabularyModel]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getVocabList()
        self.setBackgroundColor()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        vocabTable.register(UINib(nibName: "VocabListTableViewCell", bundle: nil), forCellReuseIdentifier: "VocabListTableViewCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setTitleForScreen()
    }

    
    
    private func setTitleForScreen(){
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
        
        if(category != nil && category != "7"){
            queryStatementString = "Select * from Vocabularies where Category = '" + category + "';"
        }else if(category == "7"){
             queryStatementString = "Select * from Vocabularies where FavFlag = '1';"
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
        }else if(self.category == Category.CategoryKey.FamilyKey){
            self.insertFamilyList()
        }else if(self.category == Category.CategoryKey.DayKey){
            self.insertDayMonth()
        }else if(self.category == Category.CategoryKey.ColorKey){
            self.insertColor()
        }else if(self.category == Category.CategoryKey.FruitKey){
            self.insertFruits()
        }else{
            print("no category")
        }
    }
    
    private func showAddedOrRemoveFavoriteMsg(message : String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })
        
        self.present(alert, animated: true, completion: nil)
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
         let vocabNumberMod12 = VocabularyModel(id: 12, category: "1", jpVocab: "じゅうに", romaPronounce: "jyuuni", enVocab: "eleven", mmVocab: "တစ်ဆယ့်နှစ်", cnVocab: "十二", favFlag: "0", audioFileName: "NumJyuuNi")
         let vocabNumberMod13 = VocabularyModel(id: 13, category: "1", jpVocab: "じゅうさん", romaPronounce: "jyuusan", enVocab: "eleven", mmVocab: "တစ်ဆယ့်သုံး", cnVocab: "十三", favFlag: "0", audioFileName: "NumJyuuSan")
         let vocabNumberMod14 = VocabularyModel(id: 14, category: "1", jpVocab: "じゅうよん", romaPronounce: "jyuuyon", enVocab: "eleven", mmVocab: "တစ်ဆယ့်လေး", cnVocab: "十四", favFlag: "0", audioFileName: "NumJyuuYon")
         let vocabNumberMod15 = VocabularyModel(id: 15, category: "1", jpVocab: "じゅうご", romaPronounce: "jyuugo", enVocab: "eleven", mmVocab: "တစ်ဆယ့်ငါး", cnVocab: "十五", favFlag: "0", audioFileName: "NumJyuuGo")
         let vocabNumberMod16 = VocabularyModel(id: 16, category: "1", jpVocab: "じゅうろく", romaPronounce: "jyuuroku", enVocab: "eleven", mmVocab: "တစ်ဆယ့်ခြောက်", cnVocab: "十六", favFlag: "0", audioFileName: "NumJyuuRoku")
         let vocabNumberMod17 = VocabularyModel(id: 17, category: "1", jpVocab: "じゅうなな", romaPronounce: "jyuunana", enVocab: "eleven", mmVocab: "တစ်ဆယ့်ခုနှစ်", cnVocab: "十七", favFlag: "0", audioFileName: "NumJyuuNana")
         let vocabNumberMod18 = VocabularyModel(id: 18, category: "1", jpVocab: "じゅうはち", romaPronounce: "jyuuhachi", enVocab: "eleven", mmVocab: "တစ်ဆယ့်ရှစ်", cnVocab: "十八", favFlag: "0", audioFileName: "NumJyuuHachi")
         let vocabNumberMod19 = VocabularyModel(id: 19, category: "1", jpVocab: "じゅうきゅう", romaPronounce: "jyuukyuu", enVocab: "eleven", mmVocab: "တစ်ဆယ့်ကိုး", cnVocab: "十九", favFlag: "0", audioFileName: "NumJyuuKyuu")
         let vocabNumberMod20 = VocabularyModel(id: 20, category: "1", jpVocab: "にじゅう", romaPronounce: "nijuu", enVocab: "eleven", mmVocab: "နှစ်ဆယ်", cnVocab: "二十", favFlag: "0", audioFileName: "NumNiJyuu")
          let vocabNumberMod21 = VocabularyModel(id: 21, category: "1", jpVocab: "さんじゅう", romaPronounce: "sanjuu", enVocab: "eleven", mmVocab: "သုံးဆယ်", cnVocab: "三十", favFlag: "0", audioFileName: "NumSanJyuu")
          let vocabNumberMod22 = VocabularyModel(id: 22, category: "1", jpVocab: "よんじゅう", romaPronounce: "yonjuu", enVocab: "eleven", mmVocab: "လေးဆယ်", cnVocab: "四十", favFlag: "0", audioFileName: "NumYonJyuu")
          let vocabNumberMod23 = VocabularyModel(id: 23, category: "1", jpVocab: "ごじゅう", romaPronounce: "gojuu", enVocab: "eleven", mmVocab: "ငါးဆယ်", cnVocab: "五十", favFlag: "0", audioFileName: "NumGoJyuu")
           let vocabNumberMod24 = VocabularyModel(id: 24, category: "1", jpVocab: "ろくじゅう", romaPronounce: "rokujuu", enVocab: "eleven", mmVocab: "ခြောက်ဆယ်", cnVocab: "六十", favFlag: "0", audioFileName: "NumRokuJyuu")
          let vocabNumberMod25 = VocabularyModel(id: 25, category: "1", jpVocab: "ななじゅう", romaPronounce: "nanajuu", enVocab: "eleven", mmVocab: "ခုနှစ်ဆယ်", cnVocab: "七十", favFlag: "0", audioFileName: "NumNanaJyuu")
          let vocabNumberMod26 = VocabularyModel(id: 26, category: "1", jpVocab: "はちじゅう", romaPronounce: "hachijuu", enVocab: "eleven", mmVocab: "ရှစ်ဆယ်", cnVocab: "八十", favFlag: "0", audioFileName: "NumHachiJyuu")
        let vocabNumberMod27 = VocabularyModel(id: 27, category: "1", jpVocab: "きゅうじゅう", romaPronounce: "kyuujuu", enVocab: "eleven", mmVocab: "ကိုးဆယ်", cnVocab: "九十", favFlag: "0", audioFileName: "NumKyuuJyuu")
        let vocabNumberMod28 = VocabularyModel(id: 28, category: "1", jpVocab: "ひゃく", romaPronounce: "hyaku", enVocab: "eleven", mmVocab: "တစ်ရာ", cnVocab: "百", favFlag: "0", audioFileName: "NumHyaku")
    
        
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
        self.vocabList?.append(vocabNumberMod12)
        self.vocabList?.append(vocabNumberMod13)
        self.vocabList?.append(vocabNumberMod14)
        self.vocabList?.append(vocabNumberMod15)
        self.vocabList?.append(vocabNumberMod16)
        self.vocabList?.append(vocabNumberMod17)
        self.vocabList?.append(vocabNumberMod18)
        self.vocabList?.append(vocabNumberMod19)
        self.vocabList?.append(vocabNumberMod20)
        self.vocabList?.append(vocabNumberMod21)
        self.vocabList?.append(vocabNumberMod22)
        self.vocabList?.append(vocabNumberMod16)
        self.vocabList?.append(vocabNumberMod17)
        self.vocabList?.append(vocabNumberMod18)
        self.vocabList?.append(vocabNumberMod19)
        self.vocabList?.append(vocabNumberMod20)
        self.vocabList?.append(vocabNumberMod21)
        self.vocabList?.append(vocabNumberMod22)
        self.vocabList?.append(vocabNumberMod23)
        self.vocabList?.append(vocabNumberMod24)
        self.vocabList?.append(vocabNumberMod25)
        self.vocabList?.append(vocabNumberMod26)
        self.vocabList?.append(vocabNumberMod27)
        self.vocabList?.append(vocabNumberMod28)
        
        for vocabModel in self.vocabList!{
            vocabDb.insertVocabList(vocab: vocabModel)
        }
    }

    private func insertAnimalList(){
        let vocabNumberMod1 = VocabularyModel(id: 29, category: "4", jpVocab: "ねこ", romaPronounce: "neko", enVocab: "cat", mmVocab: "ကြောင်", cnVocab: "猫", favFlag: "0", audioFileName: "AniCat")
        let vocabNumberMod2 = VocabularyModel(id: 30, category: "4", jpVocab: "いぬ", romaPronounce: "inu", enVocab: "dog", mmVocab: "ခွေး", cnVocab: "狗", favFlag: "0", audioFileName: "AniDog")
               let vocabNumberMod3 = VocabularyModel(id: 31, category: "4", jpVocab: "とり", romaPronounce: "tori", enVocab: "bird", mmVocab: "ငှက်", cnVocab: "鸟", favFlag: "0", audioFileName: "AniBird")
               let vocabNumberMod4 = VocabularyModel(id: 32, category: "4", jpVocab: "さる", romaPronounce: "saru", enVocab: "monkey", mmVocab: "မျောက်", cnVocab: "猴子", favFlag: "0", audioFileName: "AniSaru")
               let vocabNumberMod5 = VocabularyModel(id: 33, category: "4", jpVocab: "しし", romaPronounce: "shishi", enVocab: "shishi", mmVocab: "ခြင်္သေ့", cnVocab: "狮子", favFlag: "0", audioFileName: "AniShi")
               let vocabNumberMod6 = VocabularyModel(id: 34, category: "4", jpVocab: "さかな", romaPronounce: "sakana", enVocab: "fish", mmVocab: "ငါး", cnVocab: "鱼", favFlag: "0", audioFileName: "AniSakana")
               let vocabNumberMod7 = VocabularyModel(id: 35, category: "4", jpVocab: "むし", romaPronounce: "mushi", enVocab: "insect", mmVocab: "ပိုးမွှား", cnVocab: "虫子", favFlag: "0", audioFileName: "AniMushi")
               let vocabNumberMod8 = VocabularyModel(id: 36, category: "4", jpVocab: "かわうそ", romaPronounce: "kawauso", enVocab: "otter", mmVocab: "ဖျံ", cnVocab: "獭", favFlag: "0", audioFileName: "AniKawauso")
               let vocabNumberMod9 = VocabularyModel(id: 37, category: "4", jpVocab: "うし", romaPronounce: "ushi", enVocab: "cow", mmVocab: "နွား", cnVocab: "牛", favFlag: "0", audioFileName: "AniUshi")
               let vocabNumberMod10 = VocabularyModel(id: 38, category: "4", jpVocab: "长颈鹿", romaPronounce: "kirin", enVocab: "giraffe", mmVocab: "သစ်ကုလားအုတ်", cnVocab: "十", favFlag: "0", audioFileName: "AniKiri")
               let vocabNumberMod11 = VocabularyModel(id: 39, category: "4", jpVocab: "とら", romaPronounce: "tora", enVocab: "tiger", mmVocab: "ကျား", cnVocab: "老虎", favFlag: "0", audioFileName: "AniTora")
        
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
    
    private func insertFamilyList(){
        let vocabNumberMod1 = VocabularyModel(id: 40, category: "3", jpVocab: "ちち", romaPronounce: "chichi", enVocab: "father", mmVocab: "အဖေ", cnVocab: "爸爸", favFlag: "0", audioFileName: "FamFather")
        let vocabNumberMod2 = VocabularyModel(id: 41, category: "3", jpVocab: "はは", romaPronounce: "haha", enVocab: "mother", mmVocab: "အမေ", cnVocab: "妈妈", favFlag: "0", audioFileName: "FamMother")
               let vocabNumberMod3 = VocabularyModel(id: 42, category: "3", jpVocab: "あに", romaPronounce: "ani", enVocab: "older brother", mmVocab: "အစ်ကို", cnVocab: "哥哥", favFlag: "0", audioFileName: "FamOldBro")
               let vocabNumberMod4 = VocabularyModel(id: 43, category: "3", jpVocab: "あね", romaPronounce: "ane", enVocab: "older sister", mmVocab: "အစ်မ", cnVocab: "姐姐", favFlag: "0", audioFileName: "FamOldSis")
               let vocabNumberMod5 = VocabularyModel(id: 44, category: "3", jpVocab: "おとうと", romaPronounce: "otouto", enVocab: "younger brother", mmVocab: "မောင်လေး/ညီလေး", cnVocab: "弟弟", favFlag: "0", audioFileName: "FamYgnBro")
               let vocabNumberMod6 = VocabularyModel(id: 45, category: "3", jpVocab: "いもうと", romaPronounce: "imouto", enVocab: "younger sister", mmVocab: "ညီမလေး", cnVocab: "妹妹", favFlag: "0", audioFileName: "FamYgnSis")
               let vocabNumberMod7 = VocabularyModel(id: 46, category: "3", jpVocab: "そふ", romaPronounce: "sofu", enVocab: "grandfather", mmVocab: "အဖိုး", cnVocab: "爷爷", favFlag: "0", audioFileName: "FamGrandfather")
               let vocabNumberMod8 = VocabularyModel(id: 47, category: "3", jpVocab: "そぼ", romaPronounce: "sobo", enVocab: "grandmother", mmVocab: "အဖွား", cnVocab: "奶奶", favFlag: "0", audioFileName: "FamGrandmother")
               let vocabNumberMod9 = VocabularyModel(id: 48, category: "3", jpVocab: "おじ", romaPronounce: "oji", enVocab: "uncle", mmVocab: "ဦးလေး", cnVocab: "叔叔", favFlag: "0", audioFileName: "FamUncle")
               let vocabNumberMod10 = VocabularyModel(id: 49, category: "3", jpVocab: "おば", romaPronounce: "oba", enVocab: "aunt", mmVocab: "အဒေါ်", cnVocab: "姨妈", favFlag: "0", audioFileName: "FamAunt")
               let vocabNumberMod11 = VocabularyModel(id: 50, category: "3", jpVocab: "おっと", romaPronounce: "otto", enVocab: "husband", mmVocab: "ခင်ပွန်း/ယောကျ်ား", cnVocab: "夫", favFlag: "0", audioFileName: "FamHusband")

         let vocabNumberMod12 = VocabularyModel(id: 51, category: "3", jpVocab: "つま", romaPronounce: "tsuma", enVocab: "wife", mmVocab: "ဇနီး/မယား", cnVocab: "妻子", favFlag: "0", audioFileName: "FamWife")

         let vocabNumberMod13 = VocabularyModel(id: 52, category: "3", jpVocab: "むすこ", romaPronounce: "musuko", enVocab: "son", mmVocab: "သား", cnVocab: "儿子", favFlag: "0", audioFileName: "FamSon")
         let vocabNumberMod14 = VocabularyModel(id: 53, category: "3", jpVocab: "むすめ", romaPronounce: "musume", enVocab: "daughter", mmVocab: "သမီး", cnVocab: "女儿", favFlag: "0", audioFileName: "FamDaughter")
         let vocabNumberMod15 = VocabularyModel(id: 54, category: "3", jpVocab: "かぞく", romaPronounce: "kazoku", enVocab: "family", mmVocab: "မိသားစု", cnVocab: "家人", favFlag: "0", audioFileName: "FamFamily")
         let vocabNumberMod16 = VocabularyModel(id: 55, category: "3", jpVocab: "りょうしん", romaPronounce: "ryoushin", enVocab: "parents", mmVocab: "မိဘ", cnVocab: "父母", favFlag: "0", audioFileName: "FamParents")
         let vocabNumberMod17 = VocabularyModel(id: 56, category: "3", jpVocab: "きょうだい", romaPronounce: "kyoudai", enVocab: "sibling", mmVocab: "မောင်နှမ", cnVocab: "兄弟/姐妹", favFlag: "0", audioFileName: "FamSibling")
         let vocabNumberMod18 = VocabularyModel(id: 57, category: "3", jpVocab: "こども", romaPronounce: "kodomo", enVocab: "child", mmVocab: "ကလေး", cnVocab: "孩子", favFlag: "0", audioFileName: "FamChild")
        let vocabNumberMod19 = VocabularyModel(id: 58, category: "3", jpVocab: "いとこ", romaPronounce: "itoko", enVocab: "cousin", mmVocab: "၀မ်းကွဲ", cnVocab: "表姐/表妹/表哥", favFlag: "0", audioFileName: "FamCousin")
        let vocabNumberMod20 = VocabularyModel(id: 59, category: "3", jpVocab: "しんせき", romaPronounce: "shinseki", enVocab: "relatives", mmVocab: "ဆွေမျိုး", cnVocab: "亲属", favFlag: "0", audioFileName: "FamRelatives")
        
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
        self.vocabList?.append(vocabNumberMod12)
        self.vocabList?.append(vocabNumberMod13)
        self.vocabList?.append(vocabNumberMod14)
        self.vocabList?.append(vocabNumberMod15)
        self.vocabList?.append(vocabNumberMod16)
        self.vocabList?.append(vocabNumberMod17)
        self.vocabList?.append(vocabNumberMod18)
        self.vocabList?.append(vocabNumberMod19)
        self.vocabList?.append(vocabNumberMod20)
        
        for vocabModel in self.vocabList!{
            vocabDb.insertVocabList(vocab: vocabModel)
        }
    }
    
    func insertDayMonth(){
        let vocabNumberMod1 = VocabularyModel(id: 60, category: "2", jpVocab: "げつようび", romaPronounce: "getsuyoubi", enVocab: "monday", mmVocab: "တနင်္လာနေ့", cnVocab: "星期一", favFlag: "0", audioFileName: "CalMonday")
        let vocabNumberMod2 = VocabularyModel(id: 61, category: "2", jpVocab: "かようび", romaPronounce: "kayoubi", enVocab: "tuesday", mmVocab: "အင်္ဂါနေ့", cnVocab: "星期二", favFlag: "0", audioFileName: "CalTuesday")
               let vocabNumberMod3 = VocabularyModel(id: 62, category: "2", jpVocab: "すいようび", romaPronounce: "suiyoubi", enVocab: "wednesday", mmVocab: "ဗုဒ္ဓဟူးနေ့", cnVocab: "星期三", favFlag: "0", audioFileName: "CalWednesday")
               let vocabNumberMod4 = VocabularyModel(id: 63, category: "2", jpVocab: "もくようび", romaPronounce: "mokuyoubi", enVocab: "thursday", mmVocab: "ကြာသပတေးနေ့", cnVocab: "星期四", favFlag: "0", audioFileName: "CalThursday")
               let vocabNumberMod5 = VocabularyModel(id: 64, category: "2", jpVocab: "きんようび", romaPronounce: "kinyoubi", enVocab: "friday", mmVocab: "သောကြာနေ့", cnVocab: "星期五", favFlag: "0", audioFileName: "CalFriday")
               let vocabNumberMod6 = VocabularyModel(id: 65, category: "2", jpVocab: "どようび", romaPronounce: "doyoubi", enVocab: "saturday", mmVocab: "စနေနေ့", cnVocab: "星期六", favFlag: "0", audioFileName: "CalSaturday")
               let vocabNumberMod7 = VocabularyModel(id: 66, category: "2", jpVocab: "にちようび", romaPronounce: "nichiyoubi", enVocab: "sunday", mmVocab: "တနင်္ဂနွေနေ့", cnVocab: "星期天", favFlag: "0", audioFileName: "CalSunday")
               let vocabNumberMod8 = VocabularyModel(id: 67, category: "2", jpVocab: "いちがつ", romaPronounce: "ichigatsu", enVocab: "January", mmVocab: "ဇန်နဝါရီ", cnVocab: "一月", favFlag: "0", audioFileName: "CalJan")
               let vocabNumberMod9 = VocabularyModel(id: 68, category: "2", jpVocab: "にがつ", romaPronounce: "nigatsu", enVocab: "february", mmVocab: "ဖေဖော်ဝါရီ", cnVocab: "二月", favFlag: "0", audioFileName: "CalFeb")
               let vocabNumberMod10 = VocabularyModel(id: 69, category: "2", jpVocab: "さんがつ", romaPronounce: "sangatsu", enVocab: "march", mmVocab: "မတ်", cnVocab: "三月", favFlag: "0", audioFileName: "CalMar")
         let vocabNumberMod11 = VocabularyModel(id: 70, category: "2", jpVocab: "しがつ", romaPronounce: "shigatsu", enVocab: "April", mmVocab: "ဧပြီ", cnVocab: "四月", favFlag: "0", audioFileName: "CalApr")

         let vocabNumberMod12 = VocabularyModel(id: 71, category: "2", jpVocab: "ごがつ", romaPronounce: "gogatsu", enVocab: "may", mmVocab: "မေ", cnVocab: "五月", favFlag: "0", audioFileName: "CalMay")

         let vocabNumberMod13 = VocabularyModel(id: 72, category: "2", jpVocab: "ろくがつ", romaPronounce: "rokugatsu", enVocab: "June", mmVocab: "ဇွန်", cnVocab: "六月", favFlag: "0", audioFileName: "CalJun")
         let vocabNumberMod14 = VocabularyModel(id: 73, category: "2", jpVocab: "しちがつ", romaPronounce: "shichigatsu", enVocab: "July", mmVocab: "ဇူလိုင်", cnVocab: "七月", favFlag: "0", audioFileName: "CalJul")
         let vocabNumberMod15 = VocabularyModel(id: 74, category: "2", jpVocab: "はちがつ", romaPronounce: "hachigatsu", enVocab: "august", mmVocab: "သြဂုတ်", cnVocab: "八月", favFlag: "0", audioFileName: "CalAug")
         let vocabNumberMod16 = VocabularyModel(id: 75, category: "2", jpVocab: "くがつ", romaPronounce: "kugatsu", enVocab: "September", mmVocab: "စက်တင်ဘာ", cnVocab: "九月", favFlag: "0", audioFileName: "CalSept")
         let vocabNumberMod17 = VocabularyModel(id: 76, category: "2", jpVocab: "じゅうがつ", romaPronounce: "juugatsu", enVocab: "October", mmVocab: "အောက်တိုဘာ", cnVocab: "十月", favFlag: "0", audioFileName: "CalOct")
         let vocabNumberMod18 = VocabularyModel(id: 77, category: "2", jpVocab: "じゅういちがつ", romaPronounce: "juuichigatsu", enVocab: "November", mmVocab: "နို၀င်ဘာ", cnVocab: "十一月", favFlag: "0", audioFileName: "CalNov")
        let vocabNumberMod19 = VocabularyModel(id: 78, category: "2", jpVocab: "じゅうにがつ", romaPronounce: "juunigatsu", enVocab: "December", mmVocab: "ဒီဇင်ဘာ", cnVocab: "十二月", favFlag: "0", audioFileName: "CalDec")
        let vocabNumberMod20 = VocabularyModel(id: 79, category: "2", jpVocab: "ついたち", romaPronounce: "tsuitachi", enVocab: "1st day of month", mmVocab: "တစ်ရက်နေ့", cnVocab: "一日", favFlag: "0", audioFileName: "Cal1")
        let vocabNumberMod21 = VocabularyModel(id: 80, category: "2", jpVocab: "ふつか", romaPronounce: "futsuka", enVocab: "2nd day of month", mmVocab: "နှစ်ရက်နေ့", cnVocab: "二日", favFlag: "0", audioFileName: "Cal2")
         let vocabNumberMod22 = VocabularyModel(id: 81, category: "2", jpVocab: "みっか", romaPronounce: "mikka", enVocab: "3rd day of month", mmVocab: "သုံးရက်နေ့", cnVocab: "三日", favFlag: "0", audioFileName: "Cal3")
         let vocabNumberMod23 = VocabularyModel(id: 82, category: "2", jpVocab: "よっか", romaPronounce: "yokka", enVocab: "4th day of month", mmVocab: "လေးရက်နေ့", cnVocab: "四日", favFlag: "0", audioFileName: "Cal4")
         let vocabNumberMod24 = VocabularyModel(id: 83, category: "2", jpVocab: "いつか", romaPronounce: "itsuka", enVocab: "5th day of month", mmVocab: "ငါးရက်နေ့", cnVocab: "五日", favFlag: "0", audioFileName: "Cal5")
         let vocabNumberMod25 = VocabularyModel(id: 84, category: "2", jpVocab: "むいか", romaPronounce: "muika", enVocab: "6th day of month", mmVocab: "ခြောက်ရက်နေ့", cnVocab: "六日", favFlag: "0", audioFileName: "Cal6")
         let vocabNumberMod26 = VocabularyModel(id: 85, category: "2", jpVocab: "なのか", romaPronounce: "nanoka", enVocab: "7th day of month", mmVocab: "ခုနှစ်ရက်နေ့", cnVocab: "七日", favFlag: "0", audioFileName: "Cal7")
         let vocabNumberMod27 = VocabularyModel(id: 86, category: "2", jpVocab: "ようか", romaPronounce: "youka", enVocab: "8th day of month", mmVocab: "ရှစ်ရက်နေ့", cnVocab: "八日", favFlag: "0", audioFileName: "Cal8")
         let vocabNumberMod28 = VocabularyModel(id: 87, category: "2", jpVocab: "ここのか", romaPronounce: "kokonoka", enVocab: "9th day of month", mmVocab: "ကိုးရက်နေ့", cnVocab: "九日", favFlag: "0", audioFileName: "Cal9")
         let vocabNumberMod29 = VocabularyModel(id: 88, category: "2", jpVocab: "とおか", romaPronounce: "tooka", enVocab: "10th day of month", mmVocab: "ဆယ်ရက်နေ့", cnVocab: "十日", favFlag: "0", audioFileName: "Cal10")
         let vocabNumberMod30 = VocabularyModel(id: 89, category: "2", jpVocab: "じゅういちにち", romaPronounce: "juuichinichi", enVocab: "11th day of month", mmVocab: "ဆယ့်တစ်ရက်နေ့", cnVocab: "十一日", favFlag: "0", audioFileName: "Cal11")
        let vocabNumberMod31 = VocabularyModel(id: 90, category: "2", jpVocab: "じゅうににち", romaPronounce: "juuninichi", enVocab: "12th day of month", mmVocab: "ဆယ့်နှစ်ရက်နေ့", cnVocab: "十二日", favFlag: "0", audioFileName: "Cal12")
        let vocabNumberMod32 = VocabularyModel(id: 91, category: "2", jpVocab: "じゅうさんにち", romaPronounce: "juusannichi", enVocab: "13rd day of month", mmVocab: "ဆယ့်သုံးရက်နေ့", cnVocab: "十三日", favFlag: "0", audioFileName: "Cal13")
        let vocabNumberMod33 = VocabularyModel(id: 92, category: "2", jpVocab: "じゅうよっか", romaPronounce: "juuyokka", enVocab: "14th day of month", mmVocab: "ဆယ့်လေးရက်နေ့", cnVocab: "十四日", favFlag: "0", audioFileName: "Cal14")
        let vocabNumberMod34 = VocabularyModel(id:93, category: "2", jpVocab: "じゅうごにち", romaPronounce: "juugonichi", enVocab: "15th day of month", mmVocab: "ဆယ့်ငါးရက်နေ့", cnVocab: "十五日", favFlag: "0", audioFileName: "Cal15")
        let vocabNumberMod35 = VocabularyModel(id: 94, category: "2", jpVocab: "じゅうろくにち", romaPronounce: "juurokunichi", enVocab: "16th day of month", mmVocab: "ဆယ့်ခြောက်ရက်နေ့", cnVocab: "十六日", favFlag: "0", audioFileName: "Cal16")
        let vocabNumberMod36 = VocabularyModel(id: 95, category: "2", jpVocab: "じゅうしちにち", romaPronounce: "juushichinichi", enVocab: "17th day of month", mmVocab: "ဆယ့်ခုနှစ်ရက်နေ့", cnVocab: "十七日", favFlag: "0", audioFileName: "Cal17")
        let vocabNumberMod37 = VocabularyModel(id: 96, category: "2", jpVocab: "じゅうはちにち", romaPronounce: "juuhachinichi", enVocab: "18th day of month", mmVocab: "ဆယ့်ရှစ်ရက်နေ့", cnVocab: "十八日", favFlag: "0", audioFileName: "Cal18")
        let vocabNumberMod38 = VocabularyModel(id: 97, category: "2", jpVocab: "じゅうくにち", romaPronounce: "juukunichi", enVocab: "19th day of month", mmVocab: "ဆယ့်ကိုးရက်နေ့", cnVocab: "十九日", favFlag: "0", audioFileName: "Cal19")
        let vocabNumberMod39 = VocabularyModel(id: 98, category: "2", jpVocab: "はつか", romaPronounce: "hatsuka", enVocab: "20th day of month", mmVocab: "နှစ်ဆယ်ရက်နေ့", cnVocab: "二十日", favFlag: "0", audioFileName: "Cal20")
        let vocabNumberMod40 = VocabularyModel(id: 99, category: "2", jpVocab: "にじゅういちにち", romaPronounce: "nijuuichinichi", enVocab: "21st day of month", mmVocab: "နှစ်ဆယ့်တစ်ရက်နေ့", cnVocab: "二十一日", favFlag: "0", audioFileName: "Cal21")
         let vocabNumberMod41 = VocabularyModel(id: 100, category: "2", jpVocab: "にじゅうににち", romaPronounce: "nijuninichi", enVocab: "22th day of month", mmVocab: "နှစ်ဆယ့်နှစ်ရက်နေ့", cnVocab: "二十二日", favFlag: "0", audioFileName: "Cal22")
         let vocabNumberMod42 = VocabularyModel(id: 101, category: "2", jpVocab: "にじゅうさんにち", romaPronounce: "nijuusannichi", enVocab: "23rd day of month", mmVocab: "နှစ်ဆယ့်သုံးရက်နေ့", cnVocab: "二十三日", favFlag: "0", audioFileName: "Cal23")
         let vocabNumberMod43 = VocabularyModel(id: 102, category: "2", jpVocab: "にじゅいよっか", romaPronounce: "nijuuyokka", enVocab: "24th day of month", mmVocab: "နှစ်ဆယ့်လေးရက်နေ့", cnVocab: "二十四日", favFlag: "0", audioFileName: "Cal24")
         let vocabNumberMod44 = VocabularyModel(id: 103, category: "2", jpVocab: "にじゅうごにち", romaPronounce: "nijuugonichi", enVocab: "25th day of month", mmVocab: "နှစ်ဆယ့်ငါးရက်နေ့", cnVocab: "二十五日", favFlag: "0", audioFileName: "Cal25")
         let vocabNumberMod45 = VocabularyModel(id: 104, category: "2", jpVocab: "にじゅうろくにち", romaPronounce: "nijuurokunichi", enVocab: "26th day of month", mmVocab: "နှစ်ဆယ့်ခြောက်ရက်နေ့", cnVocab: "二十六日", favFlag: "0", audioFileName: "Cal26")
         let vocabNumberMod46 = VocabularyModel(id: 105, category: "2", jpVocab: "にじゅうしちにち", romaPronounce: "nijuushichinichi", enVocab: "27th day of month", mmVocab: "နှစ်ဆယ့်ခုနှစ်ရက်နေ့", cnVocab: "二十七日", favFlag: "0", audioFileName: "Cal27")
         let vocabNumberMod47 = VocabularyModel(id: 106, category: "2", jpVocab: "にじゅうはちにち", romaPronounce: "nijuuhachinichi", enVocab: "28th day of month", mmVocab: "နှစ်ဆယ့်ရှစ်ရက်နေ့", cnVocab: "二十八日", favFlag: "0", audioFileName: "Cal28")
         let vocabNumberMod48 = VocabularyModel(id: 107, category: "2", jpVocab: "にじゅうくにち", romaPronounce: "nijuukunichi", enVocab: "29th day of month", mmVocab: "နှစ်ဆယ့်ကိုးရက်နေ့", cnVocab: "二十九日", favFlag: "0", audioFileName: "Cal29")
         let vocabNumberMod49 = VocabularyModel(id: 108, category: "2", jpVocab: "さんじゅうにち", romaPronounce: "sanjuunichi", enVocab: "30th day of month", mmVocab: "သုံးဆယ်ရက်နေ့", cnVocab: "三十日", favFlag: "0", audioFileName: "Cal30")
         let vocabNumberMod50 = VocabularyModel(id: 109, category: "2", jpVocab: "さんじゅういちにち", romaPronounce: "sanjuuichinichi", enVocab: "31st day of month", mmVocab: "သုံးဆယ့်တစ်ရက်နေ့", cnVocab: "三十一日", favFlag: "0", audioFileName: "Cal31")
        let vocabNumberMod51 = VocabularyModel(id: 110, category: "2", jpVocab: "きょう", romaPronounce: "kyou", enVocab: "31st day of month", mmVocab: "သုံးဆယ့်တစ်ရက်နေ့", cnVocab: "今天", favFlag: "0", audioFileName: "CalToday")
        let vocabNumberMod52 = VocabularyModel(id: 111, category: "2", jpVocab: "きのう", romaPronounce: "kinou", enVocab: "today", mmVocab: "ဒီနေ့", cnVocab: "昨天", favFlag: "0", audioFileName: "CalYesterday")
        let vocabNumberMod53 = VocabularyModel(id: 112, category: "2", jpVocab: "あした", romaPronounce: "ashita", enVocab: "tomorrow", mmVocab: "မနက်ဖြန်", cnVocab: "明天", favFlag: "0", audioFileName: "CalTomorrow")
        let vocabNumberMod54 = VocabularyModel(id: 113, category: "2", jpVocab: "まいにち", romaPronounce: "mainichi", enVocab: "every day", mmVocab: "နေ့တိုင်း", cnVocab: "每天", favFlag: "0", audioFileName: "CalEveryDay")
        let vocabNumberMod55 = VocabularyModel(id: 114, category: "2", jpVocab: "せんしゅう", romaPronounce: "senshuu", enVocab: "last week", mmVocab: "လွန်ခဲ့သောအပတ်", cnVocab: "上周", favFlag: "0", audioFileName: "CalLastWeek")
        let vocabNumberMod56 = VocabularyModel(id: 115, category: "2", jpVocab: "こんしゅう", romaPronounce: "konshuu", enVocab: "this week", mmVocab: "ယခုအပတ်", cnVocab: "今周", favFlag: "0", audioFileName: "CalThisWeek")
        let vocabNumberMod57 = VocabularyModel(id: 116, category: "2", jpVocab: "らいしゅう", romaPronounce: "raishuu", enVocab: "next week", mmVocab: "နောက်အပတ်", cnVocab: "下周", favFlag: "0", audioFileName: "CalNextWeek")
        
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
        self.vocabList?.append(vocabNumberMod12)
        self.vocabList?.append(vocabNumberMod13)
        self.vocabList?.append(vocabNumberMod14)
        self.vocabList?.append(vocabNumberMod15)
        self.vocabList?.append(vocabNumberMod16)
        self.vocabList?.append(vocabNumberMod17)
        self.vocabList?.append(vocabNumberMod18)
        self.vocabList?.append(vocabNumberMod19)
        self.vocabList?.append(vocabNumberMod20)
        self.vocabList?.append(vocabNumberMod21)
        self.vocabList?.append(vocabNumberMod22)
        self.vocabList?.append(vocabNumberMod23)
        self.vocabList?.append(vocabNumberMod24)
        self.vocabList?.append(vocabNumberMod25)
        self.vocabList?.append(vocabNumberMod26)
        self.vocabList?.append(vocabNumberMod27)
        self.vocabList?.append(vocabNumberMod28)
        self.vocabList?.append(vocabNumberMod29)
        self.vocabList?.append(vocabNumberMod30)
        self.vocabList?.append(vocabNumberMod31)
        self.vocabList?.append(vocabNumberMod32)
        self.vocabList?.append(vocabNumberMod33)
        self.vocabList?.append(vocabNumberMod34)
        self.vocabList?.append(vocabNumberMod35)
        self.vocabList?.append(vocabNumberMod36)
        self.vocabList?.append(vocabNumberMod37)
        self.vocabList?.append(vocabNumberMod38)
        self.vocabList?.append(vocabNumberMod39)
        self.vocabList?.append(vocabNumberMod40)
        self.vocabList?.append(vocabNumberMod41)
        self.vocabList?.append(vocabNumberMod42)
        self.vocabList?.append(vocabNumberMod43)
        self.vocabList?.append(vocabNumberMod44)
        self.vocabList?.append(vocabNumberMod45)
        self.vocabList?.append(vocabNumberMod46)
        self.vocabList?.append(vocabNumberMod47)
        self.vocabList?.append(vocabNumberMod48)
        self.vocabList?.append(vocabNumberMod49)
        self.vocabList?.append(vocabNumberMod50)
        self.vocabList?.append(vocabNumberMod51)
        self.vocabList?.append(vocabNumberMod52)
        self.vocabList?.append(vocabNumberMod53)
        self.vocabList?.append(vocabNumberMod54)
        self.vocabList?.append(vocabNumberMod55)
        self.vocabList?.append(vocabNumberMod56)
        self.vocabList?.append(vocabNumberMod57)
        
        for vocabModel in self.vocabList!{
            vocabDb.insertVocabList(vocab: vocabModel)
        }
    }
    
    func insertColor(){
        let vocabNumberMod1 = VocabularyModel(id: 117, category: "5", jpVocab: "オレンジ", romaPronounce: "orenji", enVocab: "orange", mmVocab: "လိမ္မော်ရောင်", cnVocab: "橙色/橘色", favFlag: "0", audioFileName: "ColOrange")
        let vocabNumberMod2 = VocabularyModel(id: 118, category: "5", jpVocab: "きいろ", romaPronounce: "kiiro", enVocab: "yellow", mmVocab: "အဝါရောင်", cnVocab: "黄色", favFlag: "0", audioFileName: "ColYellow")
        let vocabNumberMod3 = VocabularyModel(id: 119, category: "5", jpVocab: "あお", romaPronounce: "ao", enVocab: "blue", mmVocab: "အပြာရောင်", cnVocab: "蓝色", favFlag: "0", audioFileName: "ColBlue")
        let vocabNumberMod4 = VocabularyModel(id: 120, category: "5", jpVocab: "あか", romaPronounce: "aka", enVocab: "red", mmVocab: "အနီရောင်", cnVocab: "红色", favFlag: "0", audioFileName: "ColRed")
        let vocabNumberMod5 = VocabularyModel(id: 121, category: "5", jpVocab: "みどり", romaPronounce: "midori", enVocab: "green", mmVocab: "အစိမ်းရောင်", cnVocab: "绿色", favFlag: "0", audioFileName: "ColGreen")
        let vocabNumberMod6 = VocabularyModel(id: 122, category: "5", jpVocab: "くろ", romaPronounce: "kuro", enVocab: "black", mmVocab: "အမဲရောင်/အနက်ရောင်", cnVocab: "黑色", favFlag: "0", audioFileName: "ColBlack")
        let vocabNumberMod7 = VocabularyModel(id: 123, category: "5", jpVocab: "ちゃいろ", romaPronounce: "chairo", enVocab: "brown", mmVocab: "အညိုရောင်", cnVocab: "咖啡色", favFlag: "0", audioFileName: "ColBrown")
        let vocabNumberMod8 = VocabularyModel(id: 124, category: "5", jpVocab: "ピンク", romaPronounce: "pinku", enVocab: "pink", mmVocab: "ပန်းရောင်", cnVocab: "粉色", favFlag: "0", audioFileName: "ColPink")
        let vocabNumberMod9 = VocabularyModel(id: 125, category: "5", jpVocab: "むらさき", romaPronounce: "murasaki", enVocab: "purple", mmVocab: "ခရမ်းရောင်", cnVocab: "紫色", favFlag: "0", audioFileName: "ColPurple")
        let vocabNumberMod10 = VocabularyModel(id: 126, category: "5", jpVocab: "しろ", romaPronounce: "shiro", enVocab: "white", mmVocab: "အဖြူရောင်", cnVocab: "白色", favFlag: "0", audioFileName: "ColWhite")
         let vocabNumberMod11 = VocabularyModel(id: 127, category: "5", jpVocab: "はいいろ", romaPronounce: "haiiro", enVocab: "gray", mmVocab: "ခဲရောင်", cnVocab: "灰色", favFlag: "0", audioFileName: "ColGray")

         let vocabNumberMod12 = VocabularyModel(id: 128, category: "5", jpVocab: "きんいろ", romaPronounce: "kiniro", enVocab: "gold color", mmVocab: "ရွှေရောင်", cnVocab: "金色", favFlag: "0", audioFileName: "ColGold")

         let vocabNumberMod13 = VocabularyModel(id: 129, category: "5", jpVocab: "ぎんいろ", romaPronounce: "giniro", enVocab: "silver", mmVocab: "ငွေရောင်", cnVocab: "银色", favFlag: "0", audioFileName: "ColSilver")
         let vocabNumberMod14 = VocabularyModel(id: 130, category: "5", jpVocab: "ブロンズいろ", romaPronounce: "buronzuiro", enVocab: "bronze", mmVocab: "ကြေးရောင်", cnVocab: "青铜色", favFlag: "0", audioFileName: "ColBronze")
        
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
        self.vocabList?.append(vocabNumberMod12)
        self.vocabList?.append(vocabNumberMod13)
        self.vocabList?.append(vocabNumberMod14)
        
        for vocabModel in self.vocabList!{
            vocabDb.insertVocabList(vocab: vocabModel)
        }
    }
    
    func insertFruits(){
        let vocabNumberMod1 = VocabularyModel(id: 131, category: "6", jpVocab: "メロン", romaPronounce: "meron", enVocab: "melon", mmVocab: "သခွားမွှေးသီး", cnVocab: "瓜", favFlag: "0", audioFileName: "FruMeron")
        let vocabNumberMod2 = VocabularyModel(id: 132, category: "6", jpVocab: "みかん", romaPronounce: "mikan", enVocab: "orange", mmVocab: "လိမ္မော်သီး", cnVocab: "橙子", favFlag: "0", audioFileName: "FruOrange")
        let vocabNumberMod3 = VocabularyModel(id: 133, category: "6", jpVocab: "もも", romaPronounce: "momo", enVocab: "peach", mmVocab: "မက်မွန်သီး", cnVocab: "桃子", favFlag: "0", audioFileName: "FruPeach")
        let vocabNumberMod4 = VocabularyModel(id: 134, category: "6", jpVocab: "なし", romaPronounce: "nashi", enVocab: "pear", mmVocab: "သစ်တော်သီး", cnVocab: "梨", favFlag: "0", audioFileName: "FruPear")
        let vocabNumberMod5 = VocabularyModel(id: 135, category: "6", jpVocab: "うめ", romaPronounce: "ume", enVocab: "plum", mmVocab: "ဇီးသီး", cnVocab: "李子", favFlag: "0", audioFileName: "FruFlum")
        let vocabNumberMod6 = VocabularyModel(id: 136, category: "6", jpVocab: "ドリアン", romaPronounce: "dorian", enVocab: "durian", mmVocab: "ဒူးရင်းသီး", cnVocab: "榴莲", favFlag: "0", audioFileName: "FruDurian")
        let vocabNumberMod7 = VocabularyModel(id: 137, category: "6", jpVocab: "ぶどう", romaPronounce: "budou", enVocab: "grapes", mmVocab: "စပျစ်သီး", cnVocab: "葡萄", favFlag: "0", audioFileName: "FruGrapes")
        let vocabNumberMod8 = VocabularyModel(id: 138, category: "6", jpVocab: "いちご", romaPronounce: "ichigo", enVocab: "strawberry", mmVocab: "စတော်ဘယ်ရီ", cnVocab: "草莓", favFlag: "0", audioFileName: "FruStrawberry")
        let vocabNumberMod9 = VocabularyModel(id: 139, category: "6", jpVocab: "りんご", romaPronounce: "ringo", enVocab: "apple", mmVocab: "ပန်းသီး", cnVocab: "苹果", favFlag: "0", audioFileName: "FruApple")
        let vocabNumberMod10 = VocabularyModel(id: 140, category: "6", jpVocab: "さくらんぼ", romaPronounce: "sakuranbo", enVocab: "cherry", mmVocab: "ချယ်ရီသီး", cnVocab: "樱桃", favFlag: "0", audioFileName: "FruCherry")
        let vocabNumberMod11 = VocabularyModel(id: 141, category: "6", jpVocab: "グアバ", romaPronounce: "guaba", enVocab: "guava", mmVocab: "မာလကာသီး", cnVocab: "番石榴", favFlag: "0", audioFileName: "FruGuava")
        let vocabNumberMod12 = VocabularyModel(id: 142, category: "6", jpVocab: "ココナッツ", romaPronounce: "kokonattsu", enVocab: "coconut", mmVocab: "အုန်းသီး", cnVocab: "椰子", favFlag: "0", audioFileName: "FruConconut")
        let vocabNumberMod13 = VocabularyModel(id: 143, category: "6", jpVocab: "アボカド", romaPronounce: "abokado", enVocab: "avocado", mmVocab: "ထောပတ်သီး", cnVocab: "鳄梨", favFlag: "0", audioFileName: "FruAvocado")
        let vocabNumberMod14 = VocabularyModel(id: 144, category: "6", jpVocab: "すいか", romaPronounce: "suika", enVocab: "watermelon", mmVocab: "ဖရဲသီး", cnVocab: "西瓜", favFlag: "0", audioFileName: "FruWatermelon")
        let vocabNumberMod15 = VocabularyModel(id: 145, category: "6", jpVocab: "ざくろ", romaPronounce: "zakuro", enVocab: "pomegranate", mmVocab: "သလဲသီး", cnVocab: "石榴", favFlag: "0", audioFileName: "FruPomegranate")
        
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
        self.vocabList?.append(vocabNumberMod12)
        self.vocabList?.append(vocabNumberMod13)
        self.vocabList?.append(vocabNumberMod14)
        self.vocabList?.append(vocabNumberMod15)
               
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
            cell.imgFavorite.tintColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
            selectedColor = UIColor(red: 124/255, green: 179/255, blue: 66/255, alpha: 1.0)
        }else if(choosenColor == "2"){
            
            cell.imgFavorite.tintColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
            selectedColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
        }else if(choosenColor == "3"){
            cell.imgFavorite.tintColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
            selectedColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1.0)
        }
        
        cell.favButtonPressed = {
            var favFlag : String?
            if (vocabValue.favFlag == "1"){
                favFlag = "0"
            }else{
                favFlag = "1"
            }
            let favoriteStatementString = "UPDATE Vocabularies SET FavFlag = '" + favFlag! + "' WHERE ID = \(vocabValue.id);"
            let updateSts = self.vocabDb.setFavoriteVocab(favoriteStatementString: favoriteStatementString)
            if(updateSts == 1){
                if(self.category == "7"){
                    self.vocabList?.remove(at: indexPath.row)
                    self.vocabTable.reloadData()
                    self.showAddedOrRemoveFavoriteMsg(message : "\(vocabValue.jpVocab) is removed from favorite items")
                }else{
                    vocabValue.favFlag = favFlag!
                    let origFavImg = UIImage(named: favFlag == "1" ? "favorite" : "unfavorite")
                    let tintFavImg = origFavImg?.withRenderingMode(.alwaysTemplate)
                    cell.imgFavorite.setImage(tintFavImg, for: .normal)
                    cell.imgFavorite.tintColor = selectedColor
                    if(favFlag == "1"){
                        self.showAddedOrRemoveFavoriteMsg(message: "\(vocabValue.jpVocab) is added as favorite item")
                    }else{
                        self.showAddedOrRemoveFavoriteMsg(message: "\(vocabValue.jpVocab) is removed from favorite items")
                    }
                }
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
