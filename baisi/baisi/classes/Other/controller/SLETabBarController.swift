//
//  SLETabBarController.swift
//  baisi
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

class SLETabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.redColor()
        addAllChildControllers()
        setValue(SLETabBar(), forKey: "tabBar")
        tabBar.backgroundImage = UIImage(named: "tabbar-light")
        tabBar.tintColor = UIColor.blackColor()
    }
    
    func addOneChildController(title :String, image :String ,selectImage :String ,vc :UIViewController)
    {
        
        let normalImage = UIImage(named: image)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let selectImage = UIImage(named: selectImage)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        vc.tabBarItem.image = normalImage
        vc.tabBarItem.selectedImage = selectImage
        vc.title = title
        let nav = SLENavigationController(rootViewController:vc)
        addChildViewController(nav)
    }
    
    func addAllChildControllers()
    {
        // 精华
        addOneChildController("精华", image: "tabBar_essence_icon", selectImage: "tabBar_essence_click_icon", vc: SLEEssenceController())
        
        // 最新
        addOneChildController("最新", image: "tabBar_new_icon", selectImage: "tabBar_new_click_icon", vc: SLENewViewController())
        
        // 关注
        addOneChildController("关注", image: "tabBar_friendTrends_icon", selectImage: "tabBar_friendTrends_click_icon", vc: SLEFriendTrendsViewController())
        
        // 我
        addOneChildController("我", image: "tabBar_me_icon", selectImage: "tabBar_me_click_icon", vc: SLEMeTableViewController(style: .Grouped))
    }
    
    
}
