//
//  SLERecommendCell.swift
//  baisi
//
//  Created by apple on 16/10/1.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLERecommendCell: UITableViewCell {

    var category : SLERecommendCategory = SLERecommendCategory(){
    
        didSet{
        
            textLabel?.text = category.name
        
        }
    
    
    
    }
    
    @IBOutlet weak var selectIndicater: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1) // SLEColor(244, 244, 244);
        selectIndicater.backgroundColor =  UIColor(red: 219/255.0, green: 21/255.0, blue: 26/255.0, alpha: 1) // SLEColor(219, 21, 26);
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            
            selectIndicater.hidden = false
            textLabel?.textColor = UIColor(red: 219/255.0, green: 21/255.0, blue: 26/255.0, alpha: 1)
        }else{
            
            selectIndicater.hidden = true
            textLabel?.textColor = UIColor(red: 78/255.0, green: 78/255.0, blue: 78/255.0, alpha: 1)
        }
        
        
        
        
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.textLabel!.sle_y = 2;
        self.textLabel!.sle_height = self.contentView.sle_height - 2.0 * self.textLabel!.sle_y;
    }
    
}
