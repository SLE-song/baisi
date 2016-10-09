//
//  SLEMeTableViewController.swift
//  baisi
//
//  Created by apple on 16/10/3.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import SVProgressHUD

class SLEMeTableViewController: UITableViewController {

    let SLEMeCellID = "meCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "我的"
        let moonBarItem = UIBarButtonItem.sle_itemWithImage("mine-moon-icon", hightLImage: "mine-sun-icon", target: self, action: #selector(moonClick))
        let settBarItem = UIBarButtonItem.sle_itemWithImage("mine-setting-icon", hightLImage: "mine-setting-icon-click", target: self, action: #selector(setClick))
        navigationItem.rightBarButtonItems = [settBarItem,moonBarItem]
        
        view.backgroundColor = UIColor(red: 223/255.0, green: 223/255.0, blue: 223/255.0, alpha: 1)
        tableView.separatorStyle = .None
        
        
        tableView.registerClass(SLEMeTableViewCell.self, forCellReuseIdentifier: SLEMeCellID)
        
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 10
        tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0)
        tableView.tableFooterView = SLEMeFooterView()
        
    }
    
    func moonClick() {
        
        print("moonClick")
    }
    func setClick(){
        
        navigationController?.pushViewController(SLEMESettingTableViewController(), animated: true)
    
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        SVProgressHUD.dismiss()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : SLEMeTableViewCell = tableView.dequeueReusableCellWithIdentifier(SLEMeCellID) as! SLEMeTableViewCell
        
        if indexPath.section == 0 {
            
            cell.imageView?.image = UIImage(named: "setup-head-default")
            cell.textLabel?.text = "登陆/注册"
        }else{
        
            cell.textLabel?.text = "离线下载"
        }

        

        return cell
    }
 

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            
            presentViewController(SLELoginRegisterController(), animated: true, completion: nil)
        }
        
    }

}
