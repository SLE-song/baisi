//
//  SLEMeTableViewCell.swift
//  baisi
//
//  Created by apple on 16/10/3.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLEMeTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainCellBackground")
        backgroundView = imageView
        
        textLabel?.textColor = UIColor.darkGrayColor()
        textLabel?.font = UIFont.systemFontOfSize(15.0)
        selectionStyle = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if imageView?.image == nil {return}
        
        imageView!.sle_width = 35
        imageView!.sle_height = imageView!.sle_width
        imageView!.sle_centerY = contentView.sle_height * 0.5
        
        textLabel?.sle_x = imageView!.sle_maxX + 10
    }
    
    
    
}
