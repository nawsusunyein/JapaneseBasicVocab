//
//  LocalStorageManager.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 30/10/2023.
//  Copyright © 2023 Naw Su Su Nyein. All rights reserved.
//

import Foundation
import SQLite3

let FILE_NAME = "localdb.sqlite"

class LocalStorageManager {
    var db  : OpaquePointer?
    var stmt : OpaquePointer?
    init() {
        //create fileurl
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(FILE_NAME)
        print("file url : \(fileURL)")
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        }
    }
    
    func createTable(queryString : String) {
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Table Created")
            } else {
                let errorMsg = String(cString: sqlite3_errmsg(db))
                print("Table can't be created : \(errorMsg)")
            }
        } else {
            let errorMsg = String(cString: sqlite3_errmsg(db))
            print("Statment can't be prepared : \(errorMsg)")
        }
        sqlite3_finalize(stmt)
    }
    
    func insert(blogList : [Blog],queryString : String, completionError : (String) -> Void, readyInsertion : (Bool) -> Void) {
        for blog in blogList {
            if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
                let errorMsg = String(cString: sqlite3_errmsg(db))
                sqlite3_finalize(stmt)
                completionError(errorMsg)
            } else {
                //readyInsertion(true)
                if(sqlite3_bind_text(stmt, 1, blog.title, -1, nil) != SQLITE_OK) {
                    let errorMsg = String(cString: sqlite3_errmsg(db))
                    sqlite3_finalize(stmt)
                    completionError(errorMsg)
                }
                
                if(sqlite3_bind_text(stmt, 2, blog.contents, -1, nil) != SQLITE_OK) {
                    let errorMsg = String(cString: sqlite3_errmsg(db))
                    sqlite3_finalize(stmt)
                    completionError(errorMsg)
                }
                
                if(sqlite3_bind_int(stmt, 3, blog.price) != SQLITE_OK) {
                    let errorMsg = String(cString: sqlite3_errmsg(db))
                    sqlite3_finalize(stmt)
                    completionError(errorMsg)
                }
                
                if(sqlite3_step(stmt) == SQLITE_DONE) {
                    readyInsertion(true)
                } else {
                    let errorMsg = String(cString: sqlite3_errmsg(db))
                    completionError(errorMsg)
                }
            }
        }
       
    }
    
}
