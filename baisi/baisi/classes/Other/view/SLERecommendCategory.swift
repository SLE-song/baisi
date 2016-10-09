//
//  SLERecommendCategory.swift
//  baisi
//
//  Created by apple on 16/10/1.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import MJExtension

class SLERecommendCategory: NSObject {

    
    var id = NSInteger()
    var count = NSInteger()
    var name = String()
//    var users = NSMutableArray()
    var currentPage = NSInteger()
    var total = NSInteger()
    var user : NSMutableArray = NSMutableArray()
    
    func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        print("来电")
        return ["ID" : "id"]
    }
    
    
}
