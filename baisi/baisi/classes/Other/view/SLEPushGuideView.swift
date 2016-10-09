
//
//  SLEPushGuideView.swift
//  baisi
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLEPushGuideView: UIView {


    
    class func sle_loadGuideView() -> UIView {
    
    return (NSBundle.mainBundle().loadNibNamed(String(SLEPushGuideView), owner: self, options: nil)[0] as! UIView)
    }
    

    
    class func sle_showGuideView() {
        
        let key = "CFBundleShortVersionString"
        /// 对比版本号
        let currentVersion = NSBundle.mainBundle().infoDictionary![key]
        let sanboxVersion = NSUserDefaults.standardUserDefaults().stringForKey(key)
        if  sanboxVersion == nil {
            
            sle_loadView(currentVersion!, key: key)
        }else if !(currentVersion!.isEqualToString(sanboxVersion!)) {
            
            sle_loadView(currentVersion!, key: key)
        }
    }
    
    class func sle_loadView(currentVersion:AnyObject ,key:String) {
        
        let window = UIApplication.sharedApplication().keyWindow
        let guideView = sle_loadGuideView()
        guideView.frame = window!.bounds
        window!.addSubview(guideView)
        NSUserDefaults.standardUserDefaults().setValue(currentVersion as! String, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // 关闭
    @IBAction func close(sender: AnyObject) {
        
        removeFromSuperview()
    }

}
