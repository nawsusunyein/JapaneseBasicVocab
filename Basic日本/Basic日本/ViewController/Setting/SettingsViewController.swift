//
//  SettingsViewController.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 2/15/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var switchMyanmar: UISwitch!
    @IBOutlet weak var switchEnglish: UISwitch!
    @IBOutlet weak var switchChinese: UISwitch!
    
    
    @IBOutlet weak var switchMyanLanguage: UISwitch!
    @IBOutlet weak var switchEngLanguage: UISwitch!
    @IBOutlet weak var switchCnLanguage: UISwitch!
    
    @IBOutlet weak var switchGreenColor: UISwitch!
    @IBOutlet weak var switchPinkColor: UISwitch!
    @IBOutlet weak var switchPurpleColor: UISwitch!
    
    private var choosenLanguage : String?
    private var choosenColor : String?
    private var defaults : UserDefaults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaults = UserDefaults.standard
        choosenLanguage = defaults!.string(forKey: "Lang")
        choosenColor = defaults!.string(forKey: "Color")
        
        if(choosenLanguage == "mm"){
            self.switchMyanmar.setOn(true, animated: false)
            self.switchEnglish.setOn(false, animated: false)
            self.switchChinese.setOn(false, animated: false)
        }else if(choosenLanguage == "en"){
            self.switchEnglish.setOn(true, animated: false)
            self.switchChinese.setOn(false, animated: false)
            self.switchMyanmar.setOn(false, animated: false)
        }else{
            self.switchChinese.setOn(true, animated: false)
            self.switchEnglish.setOn(false, animated: false)
            self.switchMyanmar.setOn(false, animated: false)
        }
        
        if(choosenColor == "1"){
            self.switchGreenColor.setOn(true, animated: false)
            self.switchPinkColor.setOn(false, animated: false)
            self.switchPurpleColor.setOn(false, animated: false)
        }else if(choosenColor == "2"){
            self.switchPinkColor.setOn(true, animated: false)
            self.switchGreenColor.setOn(false, animated: false)
            self.switchPurpleColor.setOn(false, animated: false)
        }else{
            self.switchPurpleColor.setOn(true, animated: false)
            self.switchPinkColor.setOn(false, animated: false)
            self.switchGreenColor.setOn(false, animated: false)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func switchMyanmarLanguage(_ sender: Any) {
        if(self.switchMyanmar.isOn){
            self.switchEnglish.setOn(false, animated: false)
            self.switchChinese.setOn(false, animated: false)
            self.defaults?.set("mm", forKey: "Lang")
        }else if(!self.switchEnglish.isOn && !self.switchChinese.isOn){
            self.showNoticeAlert()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                self.switchMyanmar.setOn(true, animated: false)
            })
            
        }
    }
    
    
    @IBAction func switchEnglishLanguage(_ sender: Any) {
        if(self.switchEnglish.isOn){
            self.switchMyanmar.setOn(false, animated: false)
            self.switchChinese.setOn(false, animated: false)
            self.defaults?.set("en", forKey: "Lang")
        }else if(!self.switchMyanmar.isOn && !self.switchChinese.isOn){
            self.showNoticeAlert()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                self.switchEnglish.setOn(true, animated: false)
            })
        }
    }
    
    @IBAction func switchChineseLanguage(_ sender: Any) {
        if(self.switchChinese.isOn){
            self.switchEnglish.setOn(false, animated: false)
            self.switchMyanmar.setOn(false, animated: false)
            self.defaults?.set("cn", forKey: "Lang")
        }else if(!self.switchEnglish.isOn && !self.switchMyanmar.isOn){
            self.showNoticeAlert()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                self.switchChinese.setOn(true, animated: false)
            })
        }
    }
    
    private func showNoticeAlert(){
        let alertController = UIAlertController(title: "", message: "You need to choose at lease one language", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: {_ in})
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func switchGreenColor(_ sender: Any) {
        if(self.switchGreenColor.isOn){
            self.switchPinkColor.setOn(false, animated: false)
            self.switchPurpleColor.setOn(false, animated: false)
            self.defaults?.set("1", forKey: "Color")
        }else if(!self.switchPurpleColor.isOn && !self.switchPinkColor.isOn){
            self.showNoticeAlert()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                self.switchGreenColor.setOn(true, animated: false)
            })
        }
    }
    
    @IBAction func switchPinkColor(_ sender: Any) {
        if(self.switchPinkColor.isOn){
            self.switchGreenColor.setOn(false, animated: false)
            self.switchPurpleColor.setOn(false, animated: false)
            self.defaults?.set("2", forKey: "Color")
        }else if(!self.switchPurpleColor.isOn && !self.switchGreenColor.isOn){
            self.showNoticeAlert()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                self.switchPinkColor.setOn(true, animated: false)
            })
        }
    }
    
    @IBAction func switchPurpleColor(_ sender: Any) {
        if(self.switchPurpleColor.isOn){
            self.switchPinkColor.setOn(false, animated: false)
            self.switchGreenColor.setOn(false, animated: false)
            self.defaults?.set("3", forKey: "Color")
        }else if(!self.switchGreenColor.isOn && !self.switchPinkColor.isOn){
            self.showNoticeAlert()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                self.switchPurpleColor.setOn(true, animated: false)
            })
        }
    }
    
}
