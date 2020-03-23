//
//  CharacterListCollectionViewCell.swift
//  Basic日本
//
//  Created by techfun on 2020/03/23.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit

class CharacterListCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var lblJpCharacter: UILabel!
    @IBOutlet weak var lblRomajiCharacter: UILabel!
    @IBOutlet weak var characterView: UIView!
    
    public var characterButtonPressed : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // characterView.layer.borderWidth = 1
        //characterView.layer.borderColor = UIColor(red: 198/255, green: 40/255, blue: 40/255, alpha: 1.0).cgColor
    }

    @IBAction func btnCharacterPress(_ sender: Any) {
        self.characterButtonPressed()
    }
}
