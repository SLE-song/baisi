//
//  SLEAddTagToolbar.swift
//  baisi
//
//  Created by apple on 16/10/4.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit


class SLEAddTagToolbar: UIView {
  
    
    
    
    
    /** 工具条的顶部 */
    @IBOutlet weak var topView: UIView!
    /** 添加按var */
    var addButton = UIButton()
    /** 所有的标签 */
    lazy var tagLabels : NSMutableArray = {
    
        return NSMutableArray()
    
    }()
    
    
    override func awakeFromNib() {
        
        let button = UIButton(type: .Custom)
        button.setImage(UIImage(named: "tag_add_icon"), forState: .Normal)
        button.frame.size = button.currentImage!.size
        button.sle_x = 10
        button.addTarget(self, action: #selector(addButtonClick), forControlEvents: .TouchUpInside)
        self.topView.addSubview(button)
        self.addButton = button
        self.creatTagLabels(["吐槽","糗事"])

        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for i in 0..<self.tagLabels.count {
            
            let tagLabel = self.tagLabels[i] as! UILabel
            if i == 0 {
                
                tagLabel.sle_x = 0
                tagLabel.sle_y = 0
            }else{
            
                let lastTagLabel = self.tagLabels[i-1] as! UILabel
                let leftWidth = lastTagLabel.sle_maxX + 5
                let rightWidth = self.topView.sle_width - leftWidth
                if rightWidth >= tagLabel.sle_width {
                    
                    tagLabel.sle_y = lastTagLabel.sle_y
                    tagLabel.sle_x = leftWidth
                }else{
                
                    tagLabel.sle_x = 0
                    tagLabel.sle_y = lastTagLabel.sle_bottomY + 5
                }
            }
        }
        
        // 最后一个标签
        if self.tagLabels.count != 0 {
            
            let lastTagLabel = self.tagLabels.lastObject as! UILabel
            let leftWidth = lastTagLabel.sle_maxX + 5
            
            // 更新textField的frame
            if (topView.sle_width - leftWidth >= addButton.sle_width) {
                addButton.sle_y = lastTagLabel.sle_y
                addButton.sle_x = leftWidth
            } else {
                addButton.sle_x = 0
                addButton.sle_y = CGRectGetMaxY(lastTagLabel.frame) + 5
            }
            
            let oldH = self.sle_height;
            self.sle_height = addButton.sle_bottomY + 45
            self.sle_y -= self.sle_height - oldH
        }else{
            
            addButton.sle_x = 0
        
        
        }
        
    }

    
    func addButtonClick(){
    
        
        weak var weakSelf = self
        let addtagVc = SLEAddTagController()

        addtagVc.initWithTags { (tags) in
            
            weakSelf!.creatTagLabels(tags)
        }
        
        
        addtagVc.tags = self.tagLabels.valueForKeyPath("text") as! NSArray
        let vc = UIApplication.sharedApplication().keyWindow?.rootViewController
        let nav = vc?.presentedViewController as! UINavigationController
        nav.pushViewController(addtagVc, animated: true)
    
    }
    
    func creatTagLabels(tags : NSArray){
    
        
        
        self.tagLabels.enumerateObjectsUsingBlock { (object : AnyObject, other : Int, pointer : UnsafeMutablePointer<ObjCBool>) in
            
            object.removeFromSuperview()
            
        }
        
        self.tagLabels.removeAllObjects()
        
        for i in 0..<tags.count {
            
            let tagLabel = UILabel()
            self.tagLabels.addObject(tagLabel)
            tagLabel.backgroundColor = UIColor(red: 74/255.0, green: 139/255.0, blue: 209/255.0, alpha: 1)
            tagLabel.textAlignment = .Center
            tagLabel.text = String(tags[i])
            tagLabel.font = UIFont.systemFontOfSize(14.0)
            tagLabel.sizeToFit()
            tagLabel.sle_width += 10
            tagLabel.sle_height = 25
            tagLabel.textColor = UIColor.whiteColor()
            self.topView.addSubview(tagLabel)
            
        }
        
        self.setNeedsLayout()
        
    
    }
    
    
    class func sle_addTagToolbar() -> SLEAddTagToolbar{
    
        return NSBundle.mainBundle().loadNibNamed("SLEAddTagToolbar", owner: nil, options: nil).last as! SLEAddTagToolbar
    }
    
}
