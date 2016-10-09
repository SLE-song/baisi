//
//  SLEEssenceController.swift
//  baisi
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit



class SLEEssenceController: UIViewController,UIScrollViewDelegate{
    
    var _indicationView = UIView()
    var _selectButton = UIButton()
    var _contentView = UIScrollView()
    var _titleView = UIView()
    
    override func viewDidLoad() {
        
        navigationItem.titleView = UIImageView(image:UIImage(named:"MainTitle"))
        navigationItem.leftBarButtonItem = UIBarButtonItem.sle_itemWithImage("MainTagSubIcon", hightLImage: "MainTagSubIconClick", target: self, action: #selector(tagClick))
        view.backgroundColor = UIColor(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1.0)
        
        setupChildController()
        setupTitles()
        setupContentView()
    }
    
    
    func tagClick(){
    
        let tabVc = UITableViewController()
        navigationController?.pushViewController(tabVc, animated: true)
    }
    
    
    func setupTitles(){
    
        let titleView = UIView()
        
        titleView.sle_height = 45
        titleView.sle_width = view.sle_width
        titleView.sle_y = 64
        titleView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        view.addSubview(titleView)
        _titleView = titleView
        
        let indicationView = UIView()
        indicationView.sle_height = 2
        indicationView.sle_y = _titleView.sle_height - indicationView.sle_height
        indicationView.backgroundColor = UIColor.redColor()
        _indicationView = indicationView
        
        let titles = ["全部", "视频", "声音" ,"图片", "段子"]
        
        let width = _titleView.sle_width / CGFloat(titles.count)
        
        for i in 0 ..< titles.count {
        
            let button = UIButton(type: UIButtonType.Custom)
            button.setTitle(titles[i], forState: UIControlState.Normal)
            button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.redColor(), forState: UIControlState.Disabled)
            button.frame.size.width = width
            button.frame.origin.x = CGFloat(i)*width
            button.frame.size.height = _titleView.frame.size.height
            button.addTarget(self, action: #selector(titleViewClick), forControlEvents: .TouchUpInside)
            button.tag = i
            titleView .addSubview(button)
            
            if i==0 {
                
                button.enabled = false
                _selectButton = button
                button.titleLabel!.sizeToFit()
                indicationView.sle_width = button.titleLabel!.sle_width
                indicationView.sle_centerX = button.sle_centerX
            }
        }
        titleView.addSubview(indicationView)
    }
    
    
    
    func titleViewClick(button:UIButton){
        self._selectButton.enabled = true
        button.enabled = false
        self._selectButton = button
        
        UIView.animateWithDuration(0.2) {
            
            self._indicationView.sle_width = button.titleLabel!.sle_width
            self._indicationView.sle_centerX = button.sle_centerX
        }
        
        var offset = self._contentView.contentOffset
        offset.x = CGFloat(button.tag)*self._contentView.sle_width
        self._contentView.setContentOffset(offset, animated: true)
    }
    
    
    func setupChildController()
    {
        // 全部 控制器
        let allController = SLETopicViewController()
        allController.type = .SLETopicTypeAll
        addChildViewController(allController)
        
        // 视频 控制器
        let videoController = SLETopicViewController()
        videoController.type = .SLETopicTypeVideo
        addChildViewController(videoController)
        
        // 声音 控制器
        let voiceController = SLETopicViewController()
        voiceController.type = .SLETopicTypeVoice
        addChildViewController(voiceController)
        
        // 图片 控制器
        let pictureController = SLETopicViewController()
        pictureController.type = .SLETopicTypePicture
        addChildViewController(pictureController)
        
        // 段子 控制器
        let wordController = SLETopicViewController()
        wordController.type = .SLETopicTypeWord
        addChildViewController(wordController)
    }
    
    
    func setupContentView(){
    
        automaticallyAdjustsScrollViewInsets = false
        
        let contentView = UIScrollView()
        contentView.frame = view.bounds
        contentView.backgroundColor = UIColor.purpleColor()
        contentView.delegate = self
        contentView.pagingEnabled = true
        contentView.contentSize = CGSizeMake(contentView.sle_width * CGFloat(self.childViewControllers.count), 0)
        
        self._contentView = contentView
        view.insertSubview(contentView, atIndex: 0)
        scrollViewDidEndScrollingAnimation(contentView)
    }
    
    
    
    
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        
        let index = Int(scrollView.contentOffset.x / scrollView.sle_width)
        let tabVc = childViewControllers[index] as! UITableViewController
        tabVc.view.sle_x = scrollView.contentOffset.x
        tabVc.view.sle_y = 0
        tabVc.view.sle_height = scrollView.sle_height
        
        let bottom = tabBarController!.tabBar.sle_height
        let top = _titleView.sle_bottomY //  CGRectGetMaxY(_titleView.frame)
        tabVc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0)
        tabVc.tableView.scrollIndicatorInsets = tabVc.tableView.contentInset
        
        scrollView.addSubview(tabVc.view)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
        
        let index = Int(scrollView.contentOffset.x / scrollView.sle_width)
        let button = self._titleView.subviews[index] as! UIButton
        
        titleViewClick(button)
    }
    
    
    
}
