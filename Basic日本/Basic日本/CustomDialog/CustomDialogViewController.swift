//
//  CustomDialogViewController.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 03/01/2024.
//  Copyright © 2024 Naw Su Su Nyein. All rights reserved.
//

import UIKit

class CustomDialogViewController: UIViewController {

    @IBOutlet weak var viewDialog : UIView!
    @IBOutlet weak var titleDialog : UILabel!
    @IBOutlet weak var imgDialog : UIImageView!
    
    var imgName : String?
    var titleLabel : String?
    
    let fromView = UIView()
    let toView = UIView()
   // var viewDialog = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // viewDialog = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
       // viewDialog.backgroundColor = UIColor.blue
       // view.addSubview(viewDialog)

                // Call this method to show the custom view with a top-to-bottom transition
                showViewWithTopToBottomTransition()
    }
    
    func showViewWithTopToBottomTransition() {
            // Animate the transition
        viewDialog.frame.origin.y = -viewDialog.frame.size.height
        UIView.animate(withDuration: 0.5,delay : 1.0 ,animations: {
                // Move the view to its final position
           // self.viewDialog.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -100).isActive = true
            //self.viewDialog.transform = CGAffineTransform(translationX: 0, y: 40)
            self.viewDialog.alpha = 0
            
            }, completion: { _ in
                // Animation completion block (if needed)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.hideView()
                    
                })
                
            })
        }

    
    func hideView() {
        self.viewDialog.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 1,options : [.curveEaseIn], animations: {
            self.viewDialog.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                self.viewDialog.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 1,options : [.autoreverse], animations: {
//                    self.viewDialog.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
                    self.viewDialog.alpha = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        //self.viewDialog.alpha = 0
                        self.dismiss(animated: true)
                    })
                })
            })
        })
    }
    func setUpData() {
        titleDialog.text = titleLabel
        imgDialog.image = UIImage(named: imgName!)
    }
    
    func configureViews() {
            // Configure your views here
            // Add any necessary subviews, set up constraints, etc.
            
            // For example, you can set background colors to distinguish the views
            fromView.backgroundColor = .blue
            toView.backgroundColor = .green
            
            // Add views to the main view
            view.addSubview(fromView)
            view.addSubview(toView)
            
            // Set up constraints to position views as needed
            // (Assuming you're using Auto Layout)
            fromView.translatesAutoresizingMaskIntoConstraints = false
            toView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                fromView.topAnchor.constraint(equalTo: view.topAnchor),
                fromView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                fromView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                fromView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                toView.topAnchor.constraint(equalTo: view.topAnchor, constant: -view.frame.size.height),
                toView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                toView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                toView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }

        func performTransition() {
            // Animate the transition by updating constraints
            UIView.animate(withDuration: 0.5) {
                // Move the `toView` down to its final position
                self.toView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

                // Move the `fromView` off-screen
                self.fromView.topAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

                // Notify the layout system to update the constraints
                self.view.layoutIfNeeded()
            }
        }
}
