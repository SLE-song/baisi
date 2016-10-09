//
//  SLELoginRegisterButton.swift
//  baisi
//
//  Created by apple on 16/10/2.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLELoginRegisterButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel!.textAlignment = .Center;
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置图片的位置
        self.imageView!.sle_x = 0;
        self.imageView!.sle_y = 0;
        self.imageView!.sle_width = self.sle_width;
        self.imageView!.sle_height = self.imageView!.sle_width;
        
        // 设置label的位置
        self.titleLabel!.sle_x = 0;
        self.titleLabel!.sle_y = self.imageView!.sle_height;
        self.titleLabel!.sle_width = self.sle_width;
        self.titleLabel!.sle_height = self.sle_height - self.titleLabel!.sle_y;
    }
    
}
