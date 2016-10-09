//
//  SLESquareButton.swift
//  baisi
//
//  Created by apple on 16/10/3.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLESquareButton: UIButton {
    
    var square : SLESquare = SLESquare()
    
   
    func setup()
    {
        
        titleLabel!.textAlignment = .Center;
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        titleLabel!.font = UIFont.systemFontOfSize(15.0)
        setBackgroundImage(UIImage(named: "mainCellBackground"), forState: .Normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
    
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        imageView!.sle_width = sle_width * 0.5
        imageView!.sle_y = sle_height * 0.15
        imageView!.sle_height = imageView!.sle_width
        imageView!.sle_centerX = sle_width * 0.5
        
        titleLabel!.sle_x = 0
        titleLabel!.sle_y = imageView!.sle_bottomY
        titleLabel!.sle_width = sle_width
        titleLabel!.sle_height = sle_height - titleLabel!.sle_y
    }

    
    

}
