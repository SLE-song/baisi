//
//  SLETopic.swift
//  baisi
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import MJExtension


class SLETopic: NSObject {
    
    override static func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
       
        return [
            "small_image" : "image0",
            "large_image" : "image1",
            "middle_image" : "image2",
            "ID" : "id"
        ]
    }
    
   override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return [
        
            "top_cmt" : "SLEComment"
        ]
        
    }
    
    
    
    
    /** id */
    var ID = String()
    /** 名称 */
    var name = String()
    /** 头像 */
    var profile_image = String()
    /** 发帖时间 */
    var create_time = String()
    /** 文字内容 */
    var text = String()
    /** 顶的数量 */
    var ding = Int()
    /** 踩的数量 */
    var cai = Int()
    /** 转发的数量 */
    var repost = Int()
    /** 评论的数量 */
    var comment = Int()
    /** 新浪加V用户 */
    var sina_v = Bool()
    /** 图片的高度 */
//    private var _height = CGFloat()
//    var height :CGFloat{
//        get {
//            return _height
//            
//            }
//    }
    var height = CGFloat()
    
    /** 图片的宽度 */
    
//    private var _width = CGFloat()
//    var width : CGFloat{
//        get{
//        
//            return _width
//        }
//    
//    }
    
    var width = CGFloat()
    
    /** 小图片的URL */
    var small_image = String()
    /** 中图片的URL */
    var middle_image = String()
    /** 大图片的URL */
    var large_image = String()
    /** 播放次数 */
    var playcount = Int()
    /** 音乐时长 */
    var voicetime = Int()
    /** 视频时长 */
    var videotime = Int()
    /** 音频播放地址 */
    var voiceuri = String()
    /** 视频播放地址 */
    var videouri = String()
    
    /** 帖子的类型 */
    var type = Int()
    /** gif图标是否隐藏 */
    var bigPicture = Bool()
    
    
    /** 最热评论 */
    var top_cmt = NSArray()
    
    
//    var type = SLETopicType(rawValue: 0)
    
    
    /*********************  额外的辅助属性 ***************************/
    /** cell的高度 */
    var _cellHeight :CGFloat?
    var cellHeight :CGFloat{
    
        set{
        
        _cellHeight = newValue
            
        }
        
        get{
            
            if _cellHeight==nil {
            
                // 计算文字高度
                let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 10.0, CGFloat(MAXFLOAT))
                let textH = (self.text as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14)], context: nil).size.height
            
                _cellHeight = textH + 44 + 55 + 10
                
                
                if (self.type == 10){// 图片
                    if(self.width != 0 && self.height != 0){
                    
                        let pictureW = maxSize.width - 10
                        var pictureH = pictureW * self.height / self.width
                        if (pictureH >= 1000.0)
                        { // 图片高度过长
                            pictureH = CGFloat(250.0)
                            self.bigPicture = true // 大图
                        }else{
                            self.bigPicture = false // 大图
                        }
                    
                        let pictureX :CGFloat = 10.0
                        let pictureY :CGFloat = 55.0 + 10.0 + textH
                        
                        _pictureFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH)
                      
                        _cellHeight! += pictureH + 10
                        
                    }
                }
                if (self.type == 31){// 声音
                    
                    let voiceW = maxSize.width - 10.0
                    let voiceH = voiceW * self.height / self.width
                    let voiceX = CGFloat(10.0)
                    let voiceY = 65.0 + textH
                    _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH)
                    _cellHeight! += voiceH + 10
                    
                    
                }
                
                if (self.type == 41){
                
//                    CGFloat videoW = maxSize.width;
//                    CGFloat videoH = videoW * self.height / self.width;
//                    CGFloat videoX = SLETopicCellMargin;
//                    CGFloat videoY = SLETopicCellTextY + SLETopicCellMargin + textH;
//                    _videoFrame = CGRectMake(videoX, videoY, videoW, videoH);
//                    _cellHeight += videoH + SLETopicCellMargin;
                
                    let videoW = maxSize.width - 10
                    let videoH = videoW * self.height / self.width
                    let videoX = CGFloat(10)
                    let videoY = 65.0 + textH
                    _videoFrame = CGRectMake(videoX, videoY, videoW, videoH)
                    _cellHeight! += videoH + 10.0
                
                }
                
                
                
                if ((self.top_cmt.firstObject) != nil){
                    
                    let comment = SLEComment.mj_objectArrayWithKeyValuesArray(self.top_cmt).firstObject as! SLEComment
                    var content = String()
                    content = NSString.localizedStringWithFormat("\(comment.user.username) : \(comment.content)") as String
                    let contentH = (content as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(13)], context: nil).size.height
                    _cellHeight! += contentH + 25 + 10
                    
                    
                }
            }
            
            return _cellHeight!
        }
    
    }
    
    
    
    
    
    /** 图片的frame */
    
//    var _pictureFrame = CGRect()
    private var _pictureFrame = CGRect()
    var pictureFrame :CGRect{
        
        get{
            return _pictureFrame
        }
        
    }
    
    
    /** 声音的frame */
    private var _voiceFrame = CGRect()
    var voiceFrame :CGRect{
        
        get{
            return _voiceFrame
        }
        
    }
    
    
    /** 视频的frame */
    private var _videoFrame = CGRect()
    var videoFrame :CGRect{
        
        get{
            return _videoFrame
        }
        
    }
    /** 图片的下载进度 */
    private var _pictureProgress = CGFloat()
    var pictureProgress :CGFloat{
        
        get{
            return _pictureProgress
        }
        
    }
    
    
    
    
    
    
    
    

}
