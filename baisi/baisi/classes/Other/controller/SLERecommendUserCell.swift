//
//  SLERecommendUserCell.swift
//  baisi
//
//  Created by apple on 16/10/1.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import SDWebImage

class SLERecommendUserCell: UITableViewCell {
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var fansCountLabel: UILabel!

    var users : SLERecommendUser = SLERecommendUser(){
    
    
        didSet{
            
            
            
            userNameLabel.text = users.screen_name;
            
            //    self.fansCount.text = [NSString stringWithFormat:@"%zd人关注",users.fans_count];
            
            var fansNum = ""
            if users.fans_count < 10000 {
                
                fansNum = "\(users.fans_count)人关注"
            }else{
                
                fansNum = String(format: "%1f", "\((Double(users.fans_count)/10000.0))") + "万人关注"
            }
            fansCountLabel.text = fansNum
            headerImageView.sd_setImageWithURL(NSURL(string: users.header), placeholderImage: UIImage(named: "defaultUserIcon"))
            
//            NSString *fansNum = nil;
//            if (users.fans_count <10000) {
//                fansNum = [NSString stringWithFormat:@"%zd人关注",users.fans_count];
//            }else{
//                
//                fansNum = [NSString stringWithFormat:@"%.1f万人关注",users.fans_count/10000.0];
//                
//            }
//            
//            self.fansCount.text = fansNum;
//            
//            [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:users.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
        
        
        
        
        }
    
    
    
    
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
