//
//  SLENavigationController.swift
//  baisi
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLENavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
        navigationBar.setBackgroundImage(UIImage(named:"navigationbarBackgroundWhite" ), forBarMetrics: UIBarMetrics.Default)
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            let button = UIButton(type: UIButtonType.Custom)
            button.setTitle("返回", forState: UIControlState.Normal)
            button.setImage(UIImage(named:"navigationButtonReturn" ), forState: UIControlState.Normal)
            button.setImage(UIImage(named:"navigationButtonReturnClick" ), forState: UIControlState.Highlighted)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
            button.addTarget(self, action: #selector(back), forControlEvents: UIControlEvents.TouchUpInside)
            button.sizeToFit()
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView:button)
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func back(){
    
        popViewControllerAnimated(true)
    }
    
}