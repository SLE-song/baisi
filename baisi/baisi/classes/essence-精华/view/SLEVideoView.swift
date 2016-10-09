//
//  SLEVideoView.swift
//  baisi
//
//  Created by apple on 16/8/28.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import MediaPlayer

class SLEVideoView: UIView {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var videoLengthLabel: UILabel!
    
    
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
    
    
    
    // 重写set方法
    var topic = SLETopic(){
    
        didSet{
        
            imageView.sd_setImageWithURL(NSURL(string: topic.large_image))
    
            self.playCountLabel.text = String(topic.playcount) + "播放"
            
            let second = topic.videotime % 60
            let minute = topic.videotime / 60
            let secondString = NSString.localizedStringWithFormat("%02zd:%02zd",second,minute)
            self.videoLengthLabel.text = (secondString as String)
        }
    
    
    }
    
    @IBAction func playButton(sender: AnyObject) {
        
        let playVc = MPMoviePlayerViewController(contentURL: NSURL(string: topic.videouri))
        UIApplication.sharedApplication().keyWindow?.rootViewController!.presentViewController(playVc, animated: true, completion: nil)
    }
    
}
