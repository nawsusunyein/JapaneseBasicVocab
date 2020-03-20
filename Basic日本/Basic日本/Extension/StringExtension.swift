//
//  StringExtension.swift
//  Basic日本
//
//  Created by techfun on 2020/03/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import Foundation

extension String {
func localized(_ lang:String) ->String {

    let path = Bundle.main.path(forResource: lang, ofType: "lproj")
    let bundle = Bundle(path: path!)

    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
}}
