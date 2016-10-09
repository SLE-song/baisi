//
//  SLETagButton.swift
//  baisi
//
//  Created by apple on 16/10/4.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLETagButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel!.sle_x = 5;
        self.imageView!.sle_x = self.titleLabel!.sle_maxX  + 5;
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setImage(UIImage(named: "chose_tag_close_icon"), forState: .Normal)
        backgroundColor = UIColor(red: 74/255.0, green: 139/255.0, blue: 209/255.0, alpha: 1)
        titleLabel?.font = UIFont.systemFontOfSize(14.0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle(title, forState: state)
        
        self.sizeToFit()
        self.sle_width += 3 * 5
    }
    
    
}
