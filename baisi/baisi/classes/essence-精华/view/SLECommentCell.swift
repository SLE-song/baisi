//
//  SLECommentCell.swift
//  baisi
//
//  Created by apple on 16/10/3.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import AFNetworking

class SLECommentCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var sexImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var like_countLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var voiceButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.numberOfLines = 0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var comment : SLEComment = SLEComment(){
    
        didSet{
        
            like_countLabel.text = String(comment.like_count)
            profileImageView.sd_setImageWithURL(NSURL(string: comment.user.profile_image))
            // 用户昵称
            nameLabel.text = comment.user.username
            
            // 评论内容
            contentLabel.text = comment.content
            
            // 显示用户性别
            if (comment.user.sex as NSString).isEqualToString("f") {
                
                sexImageView.image = UIImage(named: "Profile_womanIcon")
            }
            if (comment.user.sex as NSString).isEqualToString("m") {
                
                sexImageView.image = UIImage(named: "Profile_manIcon")
            }

            if (comment.voiceuri as NSString).length != 0 {
                
                voiceButton.hidden = false
                voiceButton.setTitle(String(comment.voicetime), forState: .Normal)
            }else{
            
                voiceButton.hidden = true
            }
            
            
        }
    }
    
    
}
