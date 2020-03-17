//
//  SqliteError.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 2/12/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import Foundation
import SQLite3

class SqliteError : Error{
    var message : String = ""
    var error = SQLITE_ERROR
    
    init(message:String = ""){
        self.message = message
    }
}
