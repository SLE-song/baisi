//
//  SLETagField.swift
//  baisi
//
//  Created by apple on 16/10/4.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

typealias sle_deleteTagsBlock = ()->Void

class SLETagField: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    private var myBlock:sle_deleteTagsBlock?
    
    func initWithBlock(block:sle_deleteTagsBlock?){
    
        myBlock = block
    }
    
    
//    public func deleteBlock(block:()->Void){}
    
    
    override func deleteBackward() {
        
        if myBlock != nil {
            
            myBlock!()
        }
        super.deleteBackward()
        
    }
    
}
