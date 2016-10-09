//
//  SLECommentController.swift
//  baisi
//
//  Created by apple on 16/10/3.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import AFNetworking
import MJRefresh


class SLECommentController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    var topic : SLETopic = SLETopic()
    /** 最热评论 */
    var hotComments = NSArray()
    /** 保存最热评论 */
    var save_hotComments = NSArray()
    /** 最新评论 */
    var latestComments = NSMutableArray()
    /** 管理者 */
    let manager = AFHTTPSessionManager()
    /** 保存当前的页码 */
    var page = NSInteger()
    let SLECommentCellID = "comment"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "评论"
        navigationItem.rightBarButtonItem = UIBarButtonItem.sle_itemWithImage("comment_nav_item_share_icon", hightLImage: "comment_nav_item_share_icon_click", target: self, action: #selector(more))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        setupHeader()
        tableView.mj_header = MJRefreshHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewComments))
        tableView.mj_header.beginRefreshing()
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreComments))
        
    }
    
    func loadNewComments(){
    
        // 结束之前的所有请求
        // 结束之前的所有请求
        let array = self.manager.tasks as NSArray
        array.enumerateObjectsUsingBlock { (object : AnyObject, other : Int, pointer : UnsafeMutablePointer<ObjCBool>) in
            
            object.cancel()
        }

        
        
        // 请求参数
        let parameters = NSMutableDictionary()
        parameters["a"] = "dataList";
        parameters["c"] = "comment";
        parameters["data_id"] = self.topic.ID;
        parameters["hot"] = NSNumber(int: 1)
        
        // 发送请求
        self.manager.GET("http://api.budejie.com/api/api_open.php", parameters: parameters, success: { (task: NSURLSessionDataTask,responseObject: AnyObject?) in
            
            if (responseObject?.isKindOfClass(NSDictionary.self) == false){
                
                self.tableView.mj_header.endRefreshing()
                return
            }
            
            self.hotComments = SLEComment.mj_objectArrayWithKeyValuesArray(responseObject!["hot"])
            self.latestComments = SLEComment.mj_objectArrayWithKeyValuesArray(responseObject!["data"])
            self.page = 1
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            
        }) { (task: NSURLSessionDataTask?, error :NSError) in
            
            self.tableView.mj_header.endRefreshing()
        }

    
    }
    func loadMoreComments(){
    
        // 结束之前的所有请求
        let array = self.manager.tasks as NSArray
        array.enumerateObjectsUsingBlock { (object : AnyObject, other : Int, pointer : UnsafeMutablePointer<ObjCBool>) in
            
            object.cancel()
        }
        
        // 页码
        let page = self.page + 1;
        
        // 参数
        let params = NSMutableDictionary()
        params["a"] = "dataList";
        params["c"] = "comment";
        params["data_id"] = self.topic.ID;
        params["page"] = NSNumber(integer: page)
        let comment : SLEComment = self.latestComments.lastObject as! SLEComment
        params["lastcid"] = comment.ID;
        
        self.manager.GET("http://api.budejie.com/api/api_open.php", parameters: params, success: { (task: NSURLSessionDataTask,responseObject: AnyObject?) in
            
            if (responseObject?.isKindOfClass(NSDictionary.self) == false){
            
                self.tableView.mj_footer.hidden = true
                return
            }
            
            let newComments = SLEComment.mj_objectArrayWithKeyValuesArray(responseObject!["data"])
            self.latestComments.addObjectsFromArray(newComments as [AnyObject])
            self.page = page
            self.tableView.reloadData()
            let total = responseObject!["total"]!!.integerValue
            if self.latestComments.count >= total{
            
                self.tableView.mj_footer.hidden = true
            }else{
            
                self.tableView.mj_footer.endRefreshing()
            
            }
            
        }) { (task: NSURLSessionDataTask?, error :NSError) in
            
            self.tableView.mj_footer.endRefreshing()
        }
    
    }
    
    
    func setupHeader(){
    
        automaticallyAdjustsScrollViewInsets = false
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        tableView.backgroundColor = UIColor(red: 223/255.0, green: 223/255.0, blue: 223/255.0, alpha: 1)
        tableView.estimatedRowHeight = 44;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.registerNib(UINib(nibName: "SLECommentCell", bundle: nil), forCellReuseIdentifier: SLECommentCellID)
        
        // 创建header
        let header = UIView()
        header.backgroundColor = UIColor(red: 223/255.0, green: 223/255.0, blue: 223/255.0, alpha: 1)
        
        if (self.topic.top_cmt.count != 0) {
            
            save_hotComments = topic.top_cmt;
            topic.top_cmt = []
            topic.setValue(NSNumber(int: 0), forKey: "cellHeight")
            
        }
        // 添加cell
        let cell : SLETopicCell = SLETopicCell.sle_topicCell()
        cell.topic = topic;
        cell.frame.size = CGSizeMake(sle_screenWidth, self.topic.cellHeight);
        header.addSubview(cell)
        //    header.backgroundColor = [UIColor redColor];
        // header的高度
        header.sle_height = self.topic.cellHeight + 2 * 10;
        
        // 设置header
        self.tableView.tableHeaderView = header;
    }
    
    // 获得当前组对应的数据
    func commentsInSection(section : NSInteger) -> NSArray
    {
    
        if (section == 0) {
            
            return self.hotComments.count != 0 ? self.hotComments : self.latestComments
        }
        return self.latestComments;
    
    }
    
    // 获得当前组对应的模型数据
    func commentsInIndexPath(indexPath : NSIndexPath) -> SLEComment
    {
    
        return self.commentsInSection(indexPath.section)[indexPath.row] as! SLEComment
    
    
    }
    
    
    
    func more(){
    
        let sheet = UIActionSheet(title: nil, delegate: nil, cancelButtonTitle: "取消", destructiveButtonTitle: nil ,otherButtonTitles: "收藏","举报")
        sheet.showInView(UIApplication.sharedApplication().keyWindow!)
    }
    
    func keyboardWillChangeFrame(note : NSNotification){
    
        let frame = note.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        self.bottomSpace.constant = sle_screenHeight - frame.origin.y;
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        UIView.animateWithDuration(duration) { 
            
            self.view.layoutIfNeeded()
        }
    }

   
    


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        let hotCount = self.hotComments.count;
        let latestCount = self.latestComments.count;
        
        if (hotCount != 0)       {return 2}
        if (latestCount != 0)    {return 1}
        return 0;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let hotCount = self.hotComments.count;
        let latestCount = self.latestComments.count;
        
        if (section == 0) {return hotCount != 0 ? hotCount :latestCount}
        
        return latestCount;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : SLECommentCell = tableView.dequeueReusableCellWithIdentifier(SLECommentCellID) as! SLECommentCell
      
        cell.comment = commentsInIndexPath(indexPath)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        view.endEditing(true)
    }
    
    
    /*
     *  如果有多组数据，要考虑循环利用的情况
     */
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        // 创建头部
        let view = UIView()
        view.backgroundColor = UIColor(red: 223/255.0, green: 223/255.0, blue: 223/255.0, alpha: 1)
        
        // 创建label
        let label = UILabel()
        label.autoresizingMask = .FlexibleHeight;
        label.textColor = UIColor(red: 67/255.0, green: 67/255.0, blue: 67/255.0, alpha: 1)
        label.sle_width = 200
        label.sle_x = 10
        view.addSubview(label)
        
        let hotCount = self.hotComments.count;
        if (section == 0) {
        
            label.text = hotCount != 0 ? "最热评论" : "最新评论";
        }else {
        
            label.text = "最新评论";
        }
        
        return view;
    }
    
    
}
