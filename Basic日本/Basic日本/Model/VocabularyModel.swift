//
//  VocabularyModel.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 2/12/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import Foundation
class VocabularyModel{
    var id : Int
    var category : String
    var jpVocab : String
    var romaPronounce : String
    var enVocab : String
    var mmVocab : String
    var cnVocab : String
    var favFlag : String
    var audioFileName : String
    
    init(id : Int, category : String,jpVocab : String,romaPronounce : String, enVocab : String,mmVocab : String, cnVocab : String, favFlag : String,audioFileName : String){
        self.id = id
        self.category = category
        self.jpVocab = jpVocab
        self.romaPronounce = romaPronounce
        self.enVocab = enVocab
        self.mmVocab = mmVocab
        self.cnVocab = cnVocab
        self.favFlag = favFlag
        self.audioFileName = audioFileName
    }
}
