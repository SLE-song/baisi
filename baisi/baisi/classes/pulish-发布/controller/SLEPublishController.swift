//
//  SLEPublishController.swift
//  baisi
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit



class SLEPublishController: UIViewController {
    
   
    override func viewDidLoad() {
        
        setup()
    }
    
    func setup(){
    
        // 数据
        let images = ["publish-video", "publish-picture", "publish-text", "publish-audio", "publish-review", "publish-offline"]
        let titles =  ["发视频", "发图片", "发段子", "发声音", "审帖", "离线下载"]
        
        let maxClo: NSInteger = 3
        
        let buttonW: CGFloat = 72
        let buttonH: CGFloat = buttonW + 30
        let startY = (sle_screenHeight - buttonH * CGFloat(maxClo - 1)) * 0.5
        let startX: CGFloat = 30.0
        let margin: CGFloat = (sle_screenWidth - buttonW * CGFloat(maxClo) - 2 * startX) / (CGFloat(maxClo) - 1)
        
        for i in 0..<images.count {
            let row = i / maxClo
            let col = i % maxClo
            let button = SLELoginRegisterButton()
            button.titleLabel?.textAlignment = .Center
            button.tag = i 
            button.setImage(UIImage(named: images[i]), forState:.Normal)
            button.setTitle(titles[i], forState: .Normal)
            button.titleLabel!.font = UIFont.systemFontOfSize(14.0)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.addTarget(self, action: #selector(buttonClick(_:)), forControlEvents: .TouchUpInside)
            let buttonX = CGFloat(startX) + CGFloat((margin + buttonW) * CGFloat(col))
            let buttonY = startY + buttonH * CGFloat(row)
             button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH)
            self.view.addSubview(button)
            
        }
        
        // 设置标语
        let imageView = UIImageView(image: UIImage(named: "app_slogan"))
        
        let centerX = sle_screenWidth * 0.5
        let centerY = sle_screenHeight * 0.15
        imageView.sle_centerY = centerY
        imageView.sle_centerX = centerX
        view.addSubview(imageView)

    
    }
    

    func buttonClick(button: SLELoginRegisterButton){
    
//        self.canclewith
  
        
        if (button.tag == 0) {
            
            print("发视频")
        }
        if (button.tag == 1) {
            print("发图片")
        }
        if (button.tag == 2) {
            
            let wordVc: SLEWordController   = SLEWordController()
            let rootVc = UIApplication.sharedApplication().keyWindow!.rootViewController
            let nav = SLENavigationController(rootViewController: wordVc)
          
            dismissViewControllerAnimated(true, completion: { 
                
                rootVc!.presentViewController(nav, animated: true, completion: nil)
            })
            
            
        }
        if (button.tag == 3) {
            print("发声音");
        }
        if (button.tag == 4) {
            print("审帖");
        }
        if (button.tag == 5) {
            print("发链接");
        }

    
    
    
    
    }
    
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func cancle(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    


    
}
