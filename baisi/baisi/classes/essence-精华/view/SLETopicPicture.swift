//
//  SLETopicPicture.swift
//  baisi
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import SDWebImage


class SLETopicPicture: UIView {
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var seeBigButton: UIButton!
    
    class func sle_pictureView() -> SLETopicPicture{
        
        return (NSBundle.mainBundle().loadNibNamed("SLETopicPicture", owner: self, options: nil) as NSArray).lastObject as! SLETopicPicture
    }
    
    
    
    override func awakeFromNib() {
        
        autoresizingMask = UIViewAutoresizing.None
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPicture)))
    }
    
    
    // 展示大图
    @IBAction func showPicture(){
    
        let showPicture = SLEShowPictureController()
        showPicture.topic = self.topic
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(showPicture, animated: true, completion: nil)
    }
    
    
    var topic = SLETopic(){
    
        didSet{
        
            
            self.imageView.sd_setImageWithURL(NSURL(string: topic.large_image)!, placeholderImage: nil, options: SDWebImageOptions.RetryFailed, progress: { (receivedSize :Int, expectedSize :Int) in
            }) { (image :UIImage!, error :NSError!, cacheType:SDImageCacheType!, imageURL :NSURL!) in
                
                if (self.topic.bigPicture == false) { return }
                
                // 开启图片上下文
                UIGraphicsBeginImageContextWithOptions(self.topic.pictureFrame.size, true, 0.0);

                let width = self.topic.pictureFrame.size.width
                let height = self.topic.pictureFrame.size.width * image.size.height / image.size.width
                image.drawInRect(CGRectMake(0, 0, width, height))
                self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
                
                // 关闭图片上下文
                UIGraphicsEndImageContext();
                }
            
            
                let gifExtension = (topic.large_image as NSString).pathExtension as String
                if ((gifExtension.lowercaseString as NSString).isEqualToString("gif") == false)
                {
                    self.gifImageView.hidden = true
                }else{
            
                    self.gifImageView.hidden = false
                }
            
                if (self.topic.bigPicture) {
                    
                    self.seeBigButton.hidden = false
                    self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
                }else{
                    
                    self.seeBigButton.hidden = true
                    self.imageView.contentMode = UIViewContentMode.ScaleToFill
                }
            
            }
    
    
    
    
    
    }
    
    
    
    
    

}
