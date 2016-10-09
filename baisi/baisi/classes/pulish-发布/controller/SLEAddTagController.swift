//
//  SLEAddTagController.swift
//  baisi
//
//  Created by apple on 16/10/4.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import SVProgressHUD

typealias sendValueWithTags=(tags : NSArray)->Void
class SLEAddTagController: UIViewController,UITextFieldDelegate {

    
    
    private var myTags:sendValueWithTags?
    //下面这个方法需要传入上个界面的postMessage函数指针
    func initWithTags(tags:sendValueWithTags?){
        //将函数指针赋值给myClosure闭包，该闭包中涵盖了postMessage函数中的局部变量等的引用
        myTags = tags
    }
    
    
    /** 中间部分 */
    var contentView = UIView()
    /** textField */
    var textField = UITextField()
    /** 提示按钮 */
    lazy var addButton : UIButton = {
    
        let addButton = UIButton(type: .Custom)
        addButton.backgroundColor = UIColor(red: 74/255.0, green: 139/255.0, blue: 209/255.0, alpha: 1)
        addButton.sle_width = self.contentView.sle_width  
        addButton.sle_height = 35  
        addButton.titleLabel!.font = UIFont.systemFontOfSize(14)
        addButton.contentHorizontalAlignment = .Left
        addButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        addButton.addTarget(self, action: #selector(addButtonDidClick), forControlEvents: .TouchUpInside)
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)
        self.contentView.addSubview(addButton)
        return addButton
    }()
    
    func addButtonDidClick(){
        
        if (self.tagButtons.count >= 5) {
            
            SVProgressHUD.showErrorWithStatus("最多添加5个标签")
            SVProgressHUD.setDefaultStyle(.Dark)
            return;
        }
        
        let tagButton = SLETagButton(type: .Custom)
        
        tagButton.setTitle(self.textField.text, forState: .Normal)
        
        tagButton.sle_height = self.textField.sle_height
        contentView.addSubview(tagButton)
        tagButtons.addObject(tagButton)
        updateAddButtonFrame()
        
        
        textField.text = nil
        addButton.hidden = true
        
        
        
    }
    
    
    /** 添加标签按钮 */
    var tagButtons = NSMutableArray()
    
    
    var tags = NSArray()
    
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupNav()
        setupContentView()
        setupTextField()
        setupTags()
        
        
    }

    func setupTags()
    {
        var tag = String()
        for tag in self.tags {
            
            self.textField.text = String(tag)
            addButtonDidClick()
        }
    }
    
    func setupContentView()
    {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.whiteColor()
        view.addSubview(contentView)
        contentView.sle_x = 10
        contentView.sle_y = 74
        contentView.sle_width = self.view.sle_width - 20
        contentView.sle_height = sle_screenHeight
        
        self.contentView = contentView
    
    }
    
    
    func setupTextField()
    {
        weak var weakSelf = self
        let textField = SLETagField()
        textField.placeholder = "多个标签用逗号或者换行隔开"
        
        textField.initWithBlock {
            
            if ((weakSelf?.textField.hasText()) == true) {
                return
            }
            
            (weakSelf?.tagButtonDidClick(weakSelf?.tagButtons.lastObject as! SLETagButton))!
        }
        
      
        textField.sle_width = sle_screenWidth
        textField.sle_height = 25  
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange), forControlEvents: .EditingChanged)
        contentView.addSubview(textField)
        textField.becomeFirstResponder()
        self.textField = textField
    }
    
    func setupNav()
    {
    
        
        view.backgroundColor = UIColor.whiteColor()
        title = "添加标签"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .Done, target: self, action: #selector(complete))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], forState: .Normal)
         navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.lightGrayColor()], forState: .Disabled)
        
        navigationController!.navigationBar.layoutIfNeeded()
    }
    
    func complete(){
    
        
        let mtags = self.tagButtons.valueForKeyPath("currentTitle") as! NSArray
     
        if myTags != nil {
            
            myTags!(tags: mtags)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    func tagButtonDidClick(tagButton : SLETagButton)
    {
        tagButton.removeFromSuperview()
        tagButtons.removeObject(tagButton)
        UIView.animateWithDuration(0.2) { 
            
            self.updateAddButtonFrame()
        }
        if self.tagButtons.count == 0 {
            self.textField.sle_x = 0
        }
    }
    
    func updateAddButtonFrame(){
        
        
        for i in 0..<tagButtons.count {
            
            
            let tagButton = tagButtons[i] as! SLETagButton
            tagButton.addTarget(self, action: #selector(tagButtonDidClick), forControlEvents: .TouchUpInside)
            if i == 0 {
                tagButton.sle_x = 0
                tagButton.sle_y = 0
            }else{
            
                let lastButton = self.tagButtons[i-1] as! SLETagButton
                let leftWidth = lastButton.sle_maxX + 5
                let rightWidth = contentView.sle_width - leftWidth
                if rightWidth >= tagButton.sle_width {
                    
                    tagButton.sle_y = lastButton.sle_y
                    tagButton.sle_x = leftWidth
                }else{
                
                    tagButton.sle_x = 0
                    tagButton.sle_y = lastButton.sle_bottomY + 5
                }
            
            }
            updateTextFieldFrame()
        }
    
    
    
    }
    
    func updateTextFieldFrame(){
    
        if self.tagButtons.count != 0 {
            
            let lastButton = self.tagButtons.lastObject as? SLETagButton
            let leftWidth = (lastButton?.sle_maxX)! + 5
            
            if ((self.contentView.sle_width - leftWidth) >= self.textFieldWidth() ) {
                
                textField.sle_y = lastButton!.sle_y
                textField.sle_x = leftWidth
            }else{
                
                textField.sle_x = 0
                textField.sle_y = CGRectGetMaxY(lastButton!.frame) + 5
            }
        }else{
        
            
        
        }
    
    
    }
    
    func textFieldWidth() -> CGFloat
    {
        let textW = (textField.text as! NSString).sizeWithAttributes([NSFontAttributeName : textField.font!]).width

        if textW > 100 {
            
            return textW
        }else{
        
            return 100
        }
    }
    
    
    
    func textDidChange(){
    
        if self.textField.hasText() == true {
            
            self.addButton.hidden = false
            self.addButton.setTitle("添加标签:\(self.textField.text)", forState: .Normal)
            self.addButton.sle_y = self.textField.sle_bottomY + 5
            
            var text = self.textField.text as! NSString
            let length = (self.textField.text! as NSString).length - 1
            let lastStri = text.substringFromIndex(length)
            
            
            if (lastStri as NSString).isEqualToString(",") || (lastStri as NSString).isEqualToString("，"){
                
                text = text.substringToIndex(length)
                self.textField.text = text as String
                self.addButtonDidClick()
                
            }
            
            self.updateTextFieldFrame()
        }else{
        
            self.addButton.hidden = true
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField.hasText() == true) {
            addButtonDidClick()
        }
        
        return true
    }
    

}
