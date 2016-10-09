//
//  SLETopicViewController.swift
//  baisi
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import MJRefresh
import AFNetworking
import MJExtension

enum SLETopicType :Int{
    case SLETopicTypeAll = 1
    case SLETopicTypePicture = 10
    case SLETopicTypeVideo = 41
    case SLETopicTypeVoice = 31
    case SLETopicTypeWord = 29
}





class SLETopicViewController: UITableViewController {
    
    let topicCellID = "topic"
    var _topics = NSMutableArray()
    var _params = NSMutableDictionary()
    var _maxtime = String()
    var _page = Int()
    var _lastSelectedIndex = Int()
    var topicType = 0
    var lastSelectedIndex = NSInteger()
    
    func a()->String{
    
        let myString = String(self.parentViewController!.classForCoder)
        let bool = (myString == "SLENewViewController")
        if (bool) {
            
            return "newlist"
        }
        return "list"
    }
    
    var type = SLETopicType(rawValue: 10)
    var typeValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            switch (type!){
            case .SLETopicTypeAll:
                typeValue = 1
            case .SLETopicTypePicture:
                typeValue = 10
            case .SLETopicTypeVideo:
                typeValue = 41
            case .SLETopicTypeVoice:
                typeValue = 31
            case .SLETopicTypeWord:
                typeValue = 29
            }
        
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.registerNib(UINib(nibName: "SLETopicCell",bundle: nil),forCellReuseIdentifier: topicCellID)
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewTopics))
        tableView.mj_header.automaticallyChangeAlpha = true
        tableView.mj_header.beginRefreshing()
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreTopics))
 
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(seletedTabBarController), name: "SLETabBarControllerDidSelectedKey", object: nil)
        
        loadNewTopics()
    }

    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func loadNewTopics(){
        
        tableView.mj_footer.endRefreshing()
        let params = NSMutableDictionary()
        params["a"] = a()

        params["c"] = "data"
        params["type"] = typeValue //String(typeValue)
        self._params = params

        let manager = AFHTTPSessionManager()
        manager.GET("http://api.budejie.com/api/api_open.php", parameters: params, progress: nil, success: { (let task :NSURLSessionDataTask!,let responseObject: AnyObject?) in
            
            if self._params != params{  return }
            
            let info = responseObject!["info"] as! NSDictionary
            self._maxtime = info["maxtime"] as! String
            self._topics = SLETopic.mj_objectArrayWithKeyValuesArray(responseObject!["list"])
            self.tableView.reloadData()
            self._page = 0
            self.tableView.mj_header.endRefreshing()
            
        }) { (let task:NSURLSessionDataTask?, let error :NSError) in
                
            if self._params != params{  return  }
            self.tableView.mj_header.endRefreshing()
        }
    
    }
    
    func loadMoreTopics(){
    
        tableView.mj_header.endRefreshing()
        _page += 1
        
        let params = NSMutableDictionary()
        params["a"] = "list"
        params["c"] = "data"
        let page = _page + 1
        params["type"] = typeValue   //String(topicType)
        params["page"] = String(_page)
        params["maxtime"] = _maxtime
        self._params = params
        
        let manager = AFHTTPSessionManager()
        manager.GET("http://api.budejie.com/api/api_open.php", parameters: params, progress: nil, success: { (let task :NSURLSessionDataTask!,let responseObject: AnyObject?) in
            
            if self._params != params{  return }
            
            let info = responseObject!["info"] as! NSDictionary
            self._maxtime = info["maxtime"] as! String
            
            let newTopics = SLETopic.mj_objectArrayWithKeyValuesArray(responseObject!["list"])
            self._topics.addObjectsFromArray(newTopics as [AnyObject])
            self.tableView.reloadData()
            self._page = page
            self.tableView.mj_footer.endRefreshing()
            
        }) { (let task:NSURLSessionDataTask?, let error :NSError) in
            
            if self._params != params{  return  }
            self.tableView.mj_header.endRefreshing()
        }
    }
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return _topics.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell :SLETopicCell = tableView.dequeueReusableCellWithIdentifier(topicCellID)! as! SLETopicCell
        cell.topic = _topics[indexPath.row] as! SLETopic
        
        return cell
    }
 

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let topic : SLETopic = self._topics[indexPath.row] as! SLETopic
        return topic.cellHeight
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let commentVc = SLECommentController()
        commentVc.topic = _topics[indexPath.row] as! SLETopic
        
        navigationController?.pushViewController(commentVc, animated: true)
    }
    
    
    func seletedTabBarController()
    {
        
        if ((self.lastSelectedIndex == NSInteger(self.tabBarController!.selectedIndex)) && (self.view.sle_isShowingOnKeyWindow() == true)) {
        
            self.tableView.mj_header.beginRefreshing()
        
        }
        
        
        self.lastSelectedIndex = self.tabBarController!.selectedIndex;
    }
    
    
}
