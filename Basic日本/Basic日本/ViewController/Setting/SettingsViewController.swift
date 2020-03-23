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
    
    @IBOutlet weak var lblCurrentAppVer: UILabel!
    
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
        
        self.setAppCurrentVersion()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Setting"
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
    
    private func setAppCurrentVersion(){
        let dictionary = Bundle.main.infoDictionary
        let version = dictionary!["CFBundleShortVersionString"] as! String
        self.lblCurrentAppVer.text = version
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
    @IBAction func checkUpdateAvailable(_ sender: Any) {
        let infoDictionary = Bundle.main.infoDictionary
        let appID = infoDictionary!["CFBundleIdentifier"]
        let appStoreUrl = URL(string: "http://itunes.apple.com/lookup?bundleId=\(String(describing: appID))")
        guard let data = try? Data(contentsOf: appStoreUrl!) else{
            print("there is an error")
            return
        }
        
        let lookup = (try? JSONSerialization.jsonObject(with: data , options: [])) as? [String: Any]
        if let resultCount = lookup!["resultCount"] as? Int, resultCount == 1 {
            if let results = lookup!["results"] as? [[String:Any]] {
                if let appStoreVersion = results[0]["version"] as? String{
                    let currentVersion = infoDictionary!["CFBundleShortVersionString"] as? String
                    if !(appStoreVersion == currentVersion) {
                        self.showUpdateAlert()
                    }
                }
            }
        }
    }
    
    private func showUpdateAlert(){
        let updateAlertController = UIAlertController(title: "", message: "There is new version available.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Update", style: .default, handler: {_ in
            self.goToURL(urlString: "https://www.google.com")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in })
        updateAlertController.addAction(okAction)
        updateAlertController.addAction(cancelAction)
        self.present(updateAlertController, animated: true, completion: nil)
    }
    
    private func goToURL(urlString : String){
        if let goURL = URL(string: urlString), UIApplication.shared.canOpenURL(goURL){
            UIApplication.shared.open(goURL, options: [:], completionHandler: {_ in})
        }
    }
    
    private func openNetworkAlert(){
        let networkAlertController = UIAlertController(title: "", message: "No Network\nPlease open your network data or Wi-Fi", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
            
        })
        networkAlertController.addAction(okAction)
        self.present(networkAlertController, animated: true, completion: nil)
    }
    
    private func checkNetwork(){
        if !Reachability.isConnectedToNetwork(){
            self.openNetworkAlert()
        }
    }
}
