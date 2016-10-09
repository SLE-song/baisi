//
//  SLEShowPictureController.swift
//  baisi
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD



class SLEShowPictureController: UIViewController {

    var topic = SLETopic()
    let imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back)))
        scrollView.addSubview(imageView)
        
        let pictureW = sle_screenWidth
        let pictureH = pictureW * topic.height / topic.width
        
        if pictureH > sle_screenHeight {
            
            imageView.frame = CGRectMake(0, 0, pictureW, pictureH)
            scrollView.contentSize = CGSizeMake(0, pictureH)
        }else{
        
            imageView.frame.size = CGSizeMake(pictureW, pictureH)
            imageView.center.y = sle_screenHeight * 0.5
        }
        
        imageView.sd_setImageWithURL(NSURL(string: topic.large_image)!)
    }

    
    
    
    /**
     处理按钮点击
     */
    
    @IBAction func save(sender: AnyObject) {// 保存图片
        
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func image(image:UIImage ,didFinishSavingWithError:NSError? ,contextInfo:AnyObject){
    
        if didFinishSavingWithError != nil{
        
            SVProgressHUD.showErrorWithStatus("保存失败")
        }
    
            SVProgressHUD.showSuccessWithStatus("保存成功")
    }
    
    
    
    @IBAction func back(sender: AnyObject) {// 返回
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
 
}
