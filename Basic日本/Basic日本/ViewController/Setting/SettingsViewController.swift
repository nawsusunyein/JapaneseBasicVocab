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
    @IBOutlet weak var switchGreen: UISwitch!
    
    @IBOutlet weak var switchMyanLanguage: UISwitch!
    @IBOutlet weak var switchEngLanguage: UISwitch!
    @IBOutlet weak var switchCnLanguage: UISwitch!
    
    @IBOutlet weak var switchGreenColor: UILabel!
    @IBOutlet weak var switchPinkColor: UISwitch!
    @IBOutlet weak var switchPurpleColor: UISwitch!
    
    private var choosenLanguage : String?
    private var defaults : UserDefaults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaults = UserDefaults.standard
        choosenLanguage = defaults!.string(forKey: "Lang")
        
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
}
