//
//  SLETopicCell.swift
//  baisi
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import SDWebImage
import MJExtension


class SLETopicCell: UITableViewCell {
    
    @IBOutlet weak var sinaV:            UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel:       UILabel!
    @IBOutlet weak var contentLabel:    UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var hotCommentLabel: UILabel!
    
    @IBOutlet weak var hotCommentView: UIView!
    
    @IBOutlet weak var caiButton:     UIButton!
    @IBOutlet weak var dingButton:    UIButton!
    @IBOutlet weak var shareButton:   UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
//    let pictureView = SLETopicPicture.sle_pictureView
    let pic = (NSBundle.mainBundle().loadNibNamed("SLETopicPicture", owner: NSClassFromString("SLETopicPicture"), options: nil) as NSArray).lastObject as! SLETopicPicture
    
    let voiceView = (NSBundle.mainBundle().loadNibNamed("SLETopicVoiceView", owner: NSClassFromString("SLETopicVoiceView"), options: nil) as NSArray).lastObject as! SLETopicVoiceView
    
    let videoView = (NSBundle.mainBundle().loadNibNamed("SLEVideoView", owner: NSClassFromString("SLEVideoView"), options: nil) as NSArray).lastObject as! SLEVideoView
    
    // 基本设置
    override func awakeFromNib() {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainCellBackground")
        backgroundView = imageView
        contentView.addSubview(pic)
        contentView.addSubview(voiceView)
        contentView.addSubview(videoView)
        selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    @IBAction func more(sender: AnyObject) {
        
        let sheet = UIActionSheet(title: nil, delegate: nil, cancelButtonTitle: "取消", destructiveButtonTitle: nil ,otherButtonTitles: "收藏","举报")
        sheet.showInView(UIApplication.sharedApplication().keyWindow!)
    }
    
    
    
    
    var topic = SLETopic(){
        
        didSet{
            
            // 新浪标示
            if topic.sina_v == true {
                
                self.sinaV.hidden = false
            }else if (topic.sina_v == false){
                
                self.sinaV.hidden = true
            }
            
            // 头像，昵称，创建时间。内容
            self.nameLabel.text = topic.name
            self.contentLabel.text = topic.text
            self.createTimeLabel.text = topic.create_time
            self.profileImageView.sd_setImageWithURL(NSURL(string:topic.profile_image))
            
            // 底部按钮
            setupButton(self.caiButton, count: topic.cai, placeholder: "踩")
            setupButton(self.dingButton, count: topic.ding, placeholder: "顶")
            setupButton(self.shareButton, count: topic.repost, placeholder: "分享")
            setupButton(self.commentButton, count: topic.comment, placeholder: "评论")
        
            if (topic.type == 10) {
                // 如果是图片，取消隐藏
                pic.hidden = false
                pic.frame = topic.pictureFrame
                pic.topic = topic
                
            }else{
                
                pic.hidden = true
            }
            
            if (topic.type == 31) {
                
                voiceView.hidden = false
                voiceView.frame = topic.voiceFrame
                voiceView.topic = topic
            }else{
                
                voiceView.hidden = true
            }
            
            if (topic.type == 41){// 视频
                
                videoView.hidden = false
                videoView.frame = topic.videoFrame
                videoView.topic = topic
            }else{
                
                videoView.hidden = true
            }
            
            
            /// 最热评论
            if ((topic.top_cmt.firstObject) != nil){
                
                self.hotCommentView.hidden = false
                let comment = SLEComment.mj_objectArrayWithKeyValuesArray(topic.top_cmt).firstObject as! SLEComment
                self.hotCommentLabel.text = NSString.localizedStringWithFormat("\(comment.user.username) : \(comment.content)") as String
            }else{
            
                self.hotCommentView.hidden = true
            }
        }
    }
    
    
    func setupButton(button :UIButton, count :Int, var placeholder :String){
    
        if count > 10000 {
            
            placeholder = NSString.localizedStringWithFormat("%.1f", count/10000) as String
        }else if (count > 0) {
            
            placeholder = NSString.localizedStringWithFormat("%d", count) as String
        }
    
        button.setTitle(placeholder, forState: UIControlState.Normal)
    }
    
    
    class func sle_topicCell() -> SLETopicCell{
    
    
        return NSBundle.mainBundle().loadNibNamed("SLETopicCell", owner: nil, options: nil).last as! SLETopicCell
    
    }
  

}
