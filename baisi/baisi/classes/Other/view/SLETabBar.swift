//
//  SLETabBar.swift
//  baisi
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLETabBar: UITabBar {

    var publishButton = UIButton()
  
    
    override init(frame: CGRect){
    
        super.init(frame: frame)
        
        publishButton = UIButton(type:UIButtonType.Custom)
        publishButton.setImage(UIImage(named:"tabBar_publish_icon"), forState: UIControlState.Normal)
        publishButton.setImage(UIImage(named: "tabBar_publish_click_icon"), forState: UIControlState.Selected)
        publishButton.addTarget(self, action: #selector(SLETabBar.publishButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(publishButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (publishButton.currentImage != nil) {
            
            publishButton.frame = CGRectMake(0, 0, publishButton.currentImage!.size.width, publishButton.currentImage!.size.height)
        }
        
        let x = sle_width / 2
        let y = sle_height / 2
        publishButton.center = CGPointMake(x, y)
        
        var buttonX :CGFloat = 0.0
        let buttonY :CGFloat = 0.0
        let buttonW = frame.size.width / 5
        let buttonH = frame.size.height
        
        var index :CGFloat = 0.0
        for button :UIView in self.subviews {
            
            if !(button.isKindOfClass(NSClassFromString("UITabBarButton")!)) {
                continue;
            }
            
                if index == 2 {
                    index += 1
                }
                buttonX = buttonW * index
                button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH)
                index++
        }
    }
    
  
    
    func publishButtonClick(){
    
        let vc = SLEPublishController()
        UIApplication.sharedApplication().keyWindow!.rootViewController!.presentViewController(vc, animated: true, completion: nil)
    }
    
    
}
