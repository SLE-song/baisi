//
//  SLEMESettingTableViewController.swift
//  baisi
//
//  Created by apple on 16/10/3.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import SDWebImage

class SLEMESettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "设置"
        view.backgroundColor = UIColor(red: 223/255.0, green: 223/255.0, blue: 223/255.0, alpha: 1)
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("settingCell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "settingCell")
        }

        let size = CGFloat(SDImageCache().getSize())
        cell!.textLabel?.text = NSString(format: "清除缓存:%.2fMb", (size / 1000.0 )/1000.0) as String
        cell!.accessoryType = .DisclosureIndicator
        
        return cell!
    }
 

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        SDImageCache().clearDisk()
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.textLabel?.text = "清除缓存:0.00Mb"
    }
    
    
}
