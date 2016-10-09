//
//  SLERecommendViewController.swift
//  baisi
//
//  Created by apple on 16/10/1.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD
import MJRefresh
import MJExtension

class SLERecommendViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var categoryTableView: UITableView!
    
    @IBOutlet weak var userTableView: UITableView!
    
    /* 左侧分类数组 */
    var catetories = NSArray()
    
    /* AFN请求管理者 */
    var manager : AFHTTPSessionManager = AFHTTPSessionManager()
    
    /* 请求参数 */
    var parameter = NSMutableDictionary()
    
    let categoryID = "category"
    let userID = "user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loaddata()
        self.userTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNew))
        self.userTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMore))
        
    }

    // 加载新数据
    func loadNew()
    {
    
        // 获取对应行的分类数据
        let category : SLERecommendCategory = catetories[categoryTableView.indexPathForSelectedRow!.row] as! SLERecommendCategory
        category.currentPage = 1;
        // 获取数据
        let parameter = NSMutableDictionary()
        parameter["a"] = "list";
        parameter["c"] = "subscribe";
        parameter["category_id"] = NSNumber(integer: (category.id))
        parameter["page"] = NSNumber(integer: (category.currentPage))//(category.currentPage)
        self.parameter = parameter
    
        manager.GET("https://api.budejie.com/api/api_open.php", parameters: parameter, progress: { ( progress : NSProgress) in
            
            }, success: { ( task : NSURLSessionDataTask, responseObject : AnyObject?) in
                
                let users = SLERecommendUser.mj_objectArrayWithKeyValuesArray(responseObject!["list"])
                category.user.removeAllObjects()
                category.user.addObjectsFromArray(users as [AnyObject])
                category.total = responseObject!["total"]!!.integerValue
                
                if (self.parameter != parameter)  {return}
                
                self.userTableView.reloadData()
                self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
                self.userTableView.mj_header.endRefreshing()
                self.checkFooterState()
                
            }) {(task : NSURLSessionDataTask?,  error : NSError?) in
                
                if (self.parameter != parameter)  {return}
                SVProgressHUD.showErrorWithStatus("加载用户数据失败")
                self.userTableView.mj_header.endRefreshing()
            }
    }
    
    func loadMore(){
    
        if self.catetories.count != 0 {
            let category : SLERecommendCategory = self.catetories[self.categoryTableView.indexPathForSelectedRow!.row] as! SLERecommendCategory
            
            var tmpPage = category.currentPage
            tmpPage += 1
            // 设置请求参数
            let parameter = NSMutableDictionary()
            parameter["a"] = "list"
            parameter["c"] = "subscribe"
            parameter["category_id"] = NSNumber(integer: (category.id))
            parameter["page"] = NSNumber(integer: tmpPage)// (++category.currentPage);
            self.parameter = parameter;
            
            manager.GET("https://api.budejie.com/api/api_open.php", parameters: parameter, progress: { ( progress : NSProgress) in
                
                }, success: { ( task : NSURLSessionDataTask, responseObject : AnyObject?) in
                    
                    let users = SLERecommendUser.mj_objectArrayWithKeyValuesArray(responseObject!["list"])
                    
                    category.user.addObjectsFromArray(users as [AnyObject])
                    if (self.parameter != parameter)  {return}
                    self.userTableView.reloadData()
                    self.checkFooterState()
            }) {(task : NSURLSessionDataTask?,  error : NSError?) in
               
            }

        }
    }
    
   
    
    // 初始化
    func setup()
    {
        
        view.backgroundColor = UIColor(red: 223/255.0, green: 223/255.0, blue: 223/255.0, alpha: 1)
        navigationItem.title = "推荐关注";
        
        // 注册cell
        categoryTableView.registerNib(UINib(nibName: "SLERecommendCell", bundle: nil), forCellReuseIdentifier:categoryID)
        userTableView.registerNib(UINib(nibName: "SLERecommendUserCell", bundle: nil), forCellReuseIdentifier: userID)
        
        automaticallyAdjustsScrollViewInsets = false;
        categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        userTableView.contentInset = categoryTableView.contentInset;
        userTableView.rowHeight = 70;
    }
    
    
    // 加载初始化数据
    func loaddata()
    {
    
        // 设置蒙板
        SVProgressHUD.setDefaultStyle(.Dark)
        SVProgressHUD.show()
            
        // 获取数据
        let parameter = NSMutableDictionary()
        parameter["a"] = "category"
        parameter["c"] = "subscribe"
        
        manager.GET("http://api.budejie.com/api/api_open.php", parameters: parameter, progress:
            { ( progress : NSProgress) in
            
            },success:
            { (let task : NSURLSessionDataTask, responseObject : AnyObject?) in
                
                SVProgressHUD.dismiss()
                self.catetories = SLERecommendCategory.mj_objectArrayWithKeyValuesArray(responseObject!["list"])
                self.categoryTableView.reloadData()
                self.categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Top)
                self.userTableView.mj_header.beginRefreshing()
                
            }) {(task : NSURLSessionDataTask?,  error : NSError?) in // 出错
                
                SVProgressHUD.showErrorWithStatus("加载失败")
        }
     
    }
    
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 判断显示分组数量
        if (tableView == self.categoryTableView)  {return self.catetories.count}
        
        checkFooterState()
        var category = SLERecommendCategory()
        if catetories.count != 0 {
            
            category = self.catetories[self.categoryTableView.indexPathForSelectedRow!.row] as! SLERecommendCategory
        }
        return category.user.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 判断显示那种cell
        if tableView == categoryTableView {
            
            let cell : SLERecommendCell = tableView.dequeueReusableCellWithIdentifier(categoryID) as! SLERecommendCell
            cell.category = self.catetories[indexPath.row] as! SLERecommendCategory
            return cell
        }else{
            
            let cell : SLERecommendUserCell = tableView.dequeueReusableCellWithIdentifier(userID) as! SLERecommendUserCell
            let category : SLERecommendCategory  = self.catetories[self.categoryTableView.indexPathForSelectedRow!.row] as! SLERecommendCategory
            cell.users = category.user[indexPath.row] as! SLERecommendUser;
            return cell
        }

    }

    
    // mark <UITableViewDelegate>--代理方法---
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
    
        // 为了避免显示其他分类的数据，选中其他表格结束所有的刷新
        self.userTableView.mj_header.endRefreshing()
        self.userTableView.mj_footer.endRefreshing()
        
        let category : SLERecommendCategory = self.catetories[indexPath.row] as! SLERecommendCategory
        category.currentPage = 1;
        if (category.user.count > 0) {
            
            self.userTableView.reloadData()
        }else{
        
            self.userTableView.reloadData()
            self.userTableView.mj_header.beginRefreshing()
        }
    }
    
    
    
    // 判断
    func checkFooterState()
    {
        
        if self.catetories.count != 0 {
            
            // 获取对应行的分类数据
            let category : SLERecommendCategory = catetories[categoryTableView.indexPathForSelectedRow!.row] as! SLERecommendCategory
            
            // 如果分类的用户数据为空，则不显示下拉刷新
            if category.user.count == 0 {
                
                self.userTableView.mj_footer.hidden = true
            }else{
            
                self.userTableView.mj_footer.hidden = false //(category.user.count == 0);
            }
            
            // 如果用户的数量与请求的总数相等，则提示没有更多数据，否则结束此次刷新
            if (category.user.count == category.total) {
                
                self.userTableView.mj_footer.endRefreshingWithNoMoreData()
            }else{
                
                self.userTableView.mj_footer.endRefreshing()
                
            }
        }
    
    
    }
    
    
    // 控制器被销毁，取消所有的请求
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.manager.operationQueue.cancelAllOperations()
        SVProgressHUD.dismiss()
    }
    
    
}
