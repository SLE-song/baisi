//
//  SLELoginRegisterTextField.swift
//  baisi
//
//  Created by apple on 16/10/2.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLELoginRegisterTextField: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        
        tintColor = self.textColor
        resignFirstResponder()
    }

    
    override func resignFirstResponder() -> Bool {
        
        setValue(UIColor.grayColor(), forKeyPath: "_placeholderLabel.textColor")
        return super.resignFirstResponder()
    }
    
    override func becomeFirstResponder() -> Bool {
        
        setValue(self.textColor, forKeyPath: "_placeholderLabel.textColor")
        return super.becomeFirstResponder()
    }
    
}
