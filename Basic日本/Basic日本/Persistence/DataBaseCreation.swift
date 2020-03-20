//
//  DataBaseCreation.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 2/12/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import SQLite3
import Foundation

class DataBaseCreation{
    
    let dbURL : URL
    var db : OpaquePointer?
    
    var insertEntryStmt : OpaquePointer?
    var readEntryStmt : OpaquePointer?
    var updateEntryStmt : OpaquePointer?
    
    init(){
        do{
            do{
                dbURL = try FileManager.default
                    .url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("Vocabulary.db")
            }catch{
                print("path error")
                dbURL = URL(fileURLWithPath: "")
                return
            }
            
            try openDB()
             createVocabTable()
        }catch{
            print("something wrong in opening DB")
            return
        }
    }
    
    func openDB() throws{
        if sqlite3_open(dbURL.path, &db) != SQLITE_OK{
            throw SqliteError(message: "error opening database : \(dbURL.absoluteString)")
        }
    }
    
    func createVocabTable(){
        
        
        let createTableString = "CREATE TABLE IF NOT EXISTS Vocabularies(ID INTEGER PRIMARY KEY,Category TEXT NOT NULL,JP TEXT NOT NULL,ROMA TEXT NOT NULL,EN TEXT NOT NULL,MM TEXT NOT NULL,CN TEXT NOT NULL,FavFlag TEXT NOT NULL,AUDIOName TEXT NOT NULL);"
        var createTableStmt : OpaquePointer? = nil
        if(sqlite3_prepare_v2(db, createTableString, -1, &createTableStmt, nil) == SQLITE_OK){
            if(sqlite3_step(createTableStmt) == SQLITE_DONE){
                print("vocabulary table created")
            }else{
                print("vocabulary table can't be created")
            }
        }else{
            print("CREATE TABLE statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStmt)
    }
    
    
}
