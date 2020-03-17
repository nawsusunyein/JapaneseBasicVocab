//
//  VocabularyOperations.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 2/12/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import Foundation
import SQLite3

extension DataBaseCreation{
   
    
    func prepareReadStmt() -> Int32{
        guard readEntryStmt == nil else{
            return SQLITE_OK
        }
        
        let sql = "SELECT * FROM Vocabularies;"
        let prepareResult = sqlite3_prepare(db, sql, -1, &readEntryStmt, nil)
        if prepareResult != SQLITE_OK{
            print("Preparing read fails")
        }
        return prepareResult
    }
    
    func insertVocabList(vocab : VocabularyModel){
        
        let insertStatmentString = "INSERT INTO Vocabularies(ID,Category,JP,ROMA,EN,MM,CN,FavFlag,AUDIOName) VALUES(?,?,?,?,?,?,?,?,?)"
               if sqlite3_prepare_v2(db, insertStatmentString, -1, &insertEntryStmt, nil) == SQLITE_OK{
                   
                       if sqlite3_bind_int(self.insertEntryStmt, 1, Int32(vocab.id)) != SQLITE_OK{
                           print("Inserting Error : Id")
                       }
                       if sqlite3_bind_text(self.insertEntryStmt, 2, (vocab.category as NSString).utf8String, -1, nil) != SQLITE_OK{
                           print("Inserting Error : Category")
                       }
                       if sqlite3_bind_text(self.insertEntryStmt, 3, (vocab.jpVocab as NSString).utf8String, -1, nil) != SQLITE_OK{
                           print("Inserting Error : JP Vocab")
                       }
                       if sqlite3_bind_text(self.insertEntryStmt, 4, (vocab.romaPronounce as NSString).utf8String, -1, nil) != SQLITE_OK{
                           print("Inserting Error : Roma Vocab")
                       }
                       if sqlite3_bind_text(self.insertEntryStmt, 5, (vocab.enVocab as NSString).utf8String, -1, nil) != SQLITE_OK{
                           print("Inserting Error : En Vocab")
                       }
                       
                       if sqlite3_bind_text(self.insertEntryStmt, 6, (vocab.mmVocab as NSString).utf8String, -1, nil) != SQLITE_OK{
                           print("Inserting Error : Mm Vocab")
                       }
                       
                       if sqlite3_bind_text(self.insertEntryStmt, 7, (vocab.cnVocab as NSString).utf8String, -1, nil) != SQLITE_OK{
                           print("Inserting Error : Cn Vocab")
                       }
                       
                       if sqlite3_bind_text(self.insertEntryStmt, 8, (vocab.favFlag as NSString).utf8String, -1, nil) != SQLITE_OK{
                           print("Inserting Error : Fav Flag Vocab")
                       }
                       
                       if sqlite3_bind_text(self.insertEntryStmt, 9, (vocab.audioFileName as NSString).utf8String, -1, nil) != SQLITE_OK{
                           print("Inserting Error : Audio File Name")
                       }
                      
                       
                   
               }
               let insertResult = sqlite3_step(self.insertEntryStmt)
                if(insertResult != SQLITE_DONE){
                   print("Executing Insert Query Fails")
                    return
                }else{
                    print("Inserting success")
                }
            sqlite3_finalize(insertEntryStmt)
    }
    
    func readVocabList(queryStatementString : String) -> [VocabularyModel]{
        var vocabularyList : [VocabularyModel] = [VocabularyModel]()
        var id : Int32
        var category : String
        var jp : String
        var roma : String
        var en : String
        var mm : String
        var cn : String
        var favFlag : String
        var audioFileName : String
        
        let readQueryStatementString = queryStatementString
        
        guard self.prepareReadStmt() == SQLITE_OK else{
            return vocabularyList
            
        }

        if sqlite3_prepare_v2(db, readQueryStatementString, -1, &readEntryStmt, nil) == SQLITE_OK{
            while(sqlite3_step(self.readEntryStmt) == SQLITE_ROW){
                id = sqlite3_column_int(self.readEntryStmt, 0)
                print("id : \(id)")
                let col1 = sqlite3_column_text(self.readEntryStmt, 1)
                category = String(cString: col1!)
                print("category : \(category)")
                
                let col2 = sqlite3_column_text(self.readEntryStmt, 2)
                jp = String(cString: col2!)
                print("jp : \(jp)")
                
                let col3 = sqlite3_column_text(self.readEntryStmt, 3)
                roma = String(cString: col3!)
                print("roma : \(roma)")
                
                let col4 = sqlite3_column_text(self.readEntryStmt, 4)
                en = String(cString: col4!)
                print("en : \(en)")
                
                let col5 = sqlite3_column_text(self.readEntryStmt, 5)
                mm = String(cString: col5!)
                print("mm : \(mm)")
                
                let col6 = sqlite3_column_text(self.readEntryStmt, 6)
                cn = String(cString: col6!)
                print("cn : \(cn)")
                
                let col7 = sqlite3_column_text(self.readEntryStmt, 7)
                favFlag = String(cString: col7!)
                print("favorite Flag : \(favFlag)")
                
                let col8 = sqlite3_column_text(self.readEntryStmt, 8)
                audioFileName = String(cString: col8!)
                print("audio file name : \(audioFileName)")
                
                let vocabModel = VocabularyModel(id: Int(id), category: category, jpVocab: jp, romaPronounce: roma, enVocab: en, mmVocab: mm, cnVocab: cn, favFlag: favFlag, audioFileName: audioFileName)
                vocabularyList.append(vocabModel)
               
            }
        }else{
            print("Select statement could not be prepared")
        }
        
        //sqlite3_finalize(self.readEntryStmt);
        return vocabularyList
    }
}
