//
//  ChatMainViewController.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 01/01/2024.
//  Copyright © 2024 Naw Su Su Nyein. All rights reserved.
//

import UIKit

class ChatMainViewController: UIViewController {

    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var labelName : UILabel!
    @IBOutlet weak var labelShopping : UILabel!
    
    let bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        view.alpha = 0.7
        return view
      }()

      let conversationViewController = ChatViewController()
    
    var conversationVC : ChatViewController = ChatViewController()
    var name : String = ""
    var place : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //conversationVC.initVC(username: "liang", id: "l123")
        conversationViewController.willMove(toParent: self)
        addChild(conversationViewController)
        view.addSubview(conversationViewController.view)
        conversationViewController.didMove(toParent: self)
        view.addSubview(topView)
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       navigationController?.navigationBar.isTranslucent = true
       navigationController?.navigationBar.barTintColor = .clear
     }

     override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       navigationController?.navigationBar.isTranslucent = false
       navigationController?.navigationBar.barTintColor = .white
     }

     override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       let headerHeight: CGFloat = 130
      // mapView.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: headerHeight))
       //topView.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: headerHeight))
       conversationViewController.view.frame = CGRect(
         x: 0,
         y: headerHeight,
         width: view.bounds.width,
         height: view.bounds.height - headerHeight)
     }

    @IBAction func back(sender : AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initVC(username : String, place: String,chatStatus : String) {
        self.name = username
        self.place = place
        conversationVC.initVC(username: username, id: place, chatStatus: chatStatus)
    }
    
    func bindData() {
        labelName.text = self.name
        labelShopping.text = self.place
    }
    
    func showDialog() {
//        let customDialogStoaryboard = UIStoryboard(name: "CustomDialogStorybaord", bundle: <#T##Bundle?#>)
    }
}
