//
//  SLELoginRegisterController.swift
//  baisi
//
//  Created by apple on 16/10/2.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLELoginRegisterController: UIViewController {

    @IBOutlet weak var haveAccount: UIButton!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func haveAccount(sender: AnyObject) {
        
        if haveAccount.selected == true {
            
            haveAccount.selected = false
            leftConstraint.constant = 0
        }else if haveAccount.selected == false{
        
            haveAccount.selected = true
            leftConstraint.constant = -view.sle_width
        }
        UIView.animateWithDuration(0.3) {
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    @IBAction func close(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
   

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return .LightContent
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        view.endEditing(true)
    }
    
}
