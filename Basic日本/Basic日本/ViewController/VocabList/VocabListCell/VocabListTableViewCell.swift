//
//  VocabListTableViewCell.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 2/15/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit

class VocabListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblJpWord: UILabel!
    @IBOutlet weak var lblRomaWord: UILabel!
    @IBOutlet weak var lblMeaningWord: UILabel!
    @IBOutlet weak var vocabCard: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vocabCard.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
