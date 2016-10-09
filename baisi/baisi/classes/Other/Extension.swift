//
//  Extension.swift
//  baisi
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
//    public class func sle_item(image:String ,hightLImage:String ,target:AnyObject ,action:Selector) -> UIBarButtonItem{
//         
//        let barButtonItem = UIBarButtonItem()
//        
//        let button = UIButton(type:UIButtonType.Custom)
//        button.setBackgroundImage(UIImage(named: image), forState: UIControlState.Normal)
//        button.setBackgroundImage(UIImage(named: hightLImage), forState: UIControlState.Highlighted)
//        if (button.currentBackgroundImage != nil) {
//            button.frame.size = button.currentBackgroundImage!.size
//        }
//        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
//        
//        barButtonItem.customView = button
//        return barButtonItem
//    }
    
    public class func sle_itemWithImage(image : String, hightLImage : String, target : AnyObject, action : Selector) -> UIBarButtonItem{
    
        let button = UIButton(type: .Custom)
        button.setBackgroundImage(UIImage(named: image), forState: .Normal)
        button.setBackgroundImage(UIImage(named: hightLImage), forState: .Highlighted)
        button.frame.size = button.currentBackgroundImage!.size
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    
        return UIBarButtonItem(customView: button);
    }
 
}


