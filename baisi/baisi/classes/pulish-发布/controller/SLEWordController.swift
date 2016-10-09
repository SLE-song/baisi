//
//  SLEWordController.swift
//  baisi
//
//  Created by apple on 16/10/4.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLEWordController: UIViewController,UITextViewDelegate {

    /** 文本输入框 */
    var textView = SLEPlaceHolderTextView()
    /** 底部工具条 */
    var toolbar = SLEAddTagToolbar()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.textView.becomeFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 223/255.0, green: 223/255.0, blue: 223/255.0, alpha: 1)
        setupNav()
        setupTextView()
        setupAddToolbar()
    }

   
    func setupNav(){
    
        title = "发表文字"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.boldSystemFontOfSize(16.0)]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Done, target: self, action: #selector(cancle))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.darkGrayColor()], forState: .Normal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发表", style: .Done, target: self, action: #selector(post))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.darkGrayColor()], forState: .Normal)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.lightGrayColor()], forState: .Disabled)
        navigationItem.rightBarButtonItem?.enabled = false
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    
    func setupTextView()
    {
    
        let textView = SLEPlaceHolderTextView()
        textView.frame = view.bounds 
        view.addSubview(textView)
        textView.delegate = self 
        textView.becomeFirstResponder()
        textView.placeHolder = "这里添加文字，请勿发布色情、政治等违反国家法律的内容，违者封号处理" 
        self.textView = textView 
    }
    
    func setupAddToolbar()
    {
        let toolbar = SLEAddTagToolbar.sle_addTagToolbar()
        toolbar.sle_y = view.sle_height - toolbar.sle_height
        toolbar.sle_width = view.sle_width
        view.addSubview(toolbar)
        self.toolbar = toolbar
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardChangeFrame), name: UIKeyboardWillChangeFrameNotification, object: nil)
    
    }
    
    
    
    func cancle(){
    
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func post(){
    
    
    }
    
    func keyboardChangeFrame(note : NSNotification)
    {
        
        let frame = note.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
        UIView.animateWithDuration(duration!) { 
            
            self.toolbar.transform = CGAffineTransformMakeTranslation(0, frame!.origin.y - self.sle_screenHeight);
        }
    }
    
    
    deinit{
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
    }
    
    
    // mark -- delegate
    func textViewDidChange(textView: UITextView) {
        
        self.navigationItem.rightBarButtonItem!.enabled = true
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.view.endEditing(true)
    }
    

}
