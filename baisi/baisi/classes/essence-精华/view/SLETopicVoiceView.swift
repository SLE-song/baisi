//
//  SLETopicVoiceView.swift
//  baisi
//
//  Created by apple on 16/8/28.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLETopicVoiceView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playAndPauseBtn: UIButton!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var voiceLengthLabel: UILabel!
    
    @IBAction func playOrPause(sender: AnyObject) {
        
        SLELog("点击了播放/暂停按钮")
    }
    
    // 初始化
    override func awakeFromNib() {
        
        autoresizingMask = UIViewAutoresizing.None
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPicture)))
    }
    
    // 展示大图
    func showPicture(){
        
        let showPicture = SLEShowPictureController()
        showPicture.topic = self.topic
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(showPicture, animated: true, completion: nil)
    }
    
    
    /** 重写topic  set方法 */
    var topic = SLETopic(){
    
        didSet{
        
            self.imageView.sd_setImageWithURL(NSURL(string: topic.large_image))
            self.playCountLabel.text = String(topic.playcount) + "播放"
            
            let second = topic.voicetime % 60
            let minute = topic.voicetime / 60
            let secondString = NSString.localizedStringWithFormat("%02zd:%02zd",second,minute)
            self.voiceLengthLabel.text = (secondString as String)
        }
    }
    
    
    
}
