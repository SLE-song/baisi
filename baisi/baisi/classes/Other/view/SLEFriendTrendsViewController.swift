//
//  SLEFriendTrendsViewController.swift
//  baisi
//
//  Created by apple on 16/9/29.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLEFriendTrendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的关注";
        navigationItem.leftBarButtonItem = UIBarButtonItem.sle_itemWithImage("friendsRecommentIcon", hightLImage: "friendsRecommentIcon-click", target: self, action: #selector(SLEFriendTrendsViewController.friendClick))
    }

    
    @IBAction func login(sender: AnyObject) {
        
        let vc = SLELoginRegisterController()
//        vc.view.backgroundColor = UIColor.redColor()
//        navigationController?.pushViewController(vc, animated: true)
        presentViewController(vc, animated: true) { 
            
        }
    }
    
    
    func friendClick()
    {
    
        let vc = SLERecommendViewController(nibName: "SLERecommendViewController", bundle: nil)
        vc.view.backgroundColor = UIColor.redColor()
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
