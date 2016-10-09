//
//  SLEPlaceHolderTextView.swift
//  baisi
//
//  Created by apple on 16/10/4.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLEPlaceHolderTextView: UITextView {

    var placeHolder = String(){
    
        didSet{
        
            self.placeholderLabel.text = placeHolder
            self.setNeedsLayout()
        }
    }
  
    lazy var placeholderLabel : UILabel = {
    
        let placeholderLabel = UILabel()
        placeholderLabel.sle_x = 4
        placeholderLabel.sle_y = 8
        placeholderLabel.numberOfLines = 0
        self.addSubview(placeholderLabel)
        return placeholderLabel
    }()
    

    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        
        super.init(frame: frame, textContainer: textContainer)
       
        font = UIFont.systemFontOfSize(15.0)
        alwaysBounceVertical = true
        self.placeholderLabel.textColor = UIColor.grayColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textDidChange), name: UITextViewTextDidChangeNotification, object: nil)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textDidChange(){
    
        if self.hasText() == true {
            
            self.placeholderLabel.hidden = true
        }else{
        
            self.placeholderLabel.hidden = false
        }
    
    }
    
    override var font: UIFont?{
    
        
        didSet{
        
            self.placeholderLabel.font = font
            self.setNeedsLayout()
        }
    
    }
    
    override var text: String!{
    
        didSet{
        
            self.textDidChange()
        }
    
    }
    
    override var attributedText: NSAttributedString!{
    
        didSet{
        
            self.textDidChange()
        }
    
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.placeholderLabel.sle_width = self.sle_width - 2 * self.placeholderLabel.sle_x
        self.placeholderLabel.sizeToFit()
        
    }
    
    
    
    
    
    
    
    
    deinit{
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
    }
    
}
