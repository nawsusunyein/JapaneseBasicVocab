//
//  CustomDialogView.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 21/01/2024.
//  Copyright © 2024 Naw Su Su Nyein. All rights reserved.
//

import Foundation
import SwiftToast

struct CustomSwiftToast: SwiftToastProtocol {
    // Protocoled
    var duration: Double?
    var minimumHeight: CGFloat?
    var aboveStatusBar: Bool
    var statusBarStyle: UIStatusBarStyle
    var isUserInteractionEnabled: Bool
    var target: SwiftToastDelegate?
    var style: SwiftToastStyle

    // Customized
    var title: String
    var imageName : String
    var isWarning : Bool
}

class CustomSwiftToastView: UIView, SwiftToastViewProtocol {

    // Customized
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgIcon : UIImageView!
    @IBOutlet weak var viewDialog : UIView!
    
    // Protocoled
    func nib() -> SwiftToastViewProtocol? {
        return Bundle.main.loadNibNamed("CustomDialogView", owner: self, options: nil)?.first as? CustomSwiftToastView
    }

    func configure(with toast: SwiftToastProtocol) {
        if let customToast = toast as? CustomSwiftToast {

            // Put your configure code here. e.g.:
            titleLabel.text = customToast.title
            imgIcon.image = UIImage(named: customToast.imageName)
            if(customToast.isWarning == true) {
                viewDialog.backgroundColor = UIColor.green
            } else {
                viewDialog.backgroundColor = UIColor.blue
            }
            // subtitleLabel.text = customToast.subtitle
            // backgroundColor = customToast.backgroundColor

            // Setup minimum height if needed

            // if let minimumHeight = toast.minimumHeight {
            //    viewMinimumHeightConstraint.constant = minimumHeight
            // }
        }
    }
}


extension CustomSwiftToastView : SwiftToastDelegate {
    
}
