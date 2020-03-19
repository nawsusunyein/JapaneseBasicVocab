//
//  HomeCollectionViewCell.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 2/3/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
    @IBOutlet weak var cardViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var cardViewWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 10.0
    
    }

}
