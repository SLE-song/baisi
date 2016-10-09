//
//  SLEMeFooterView.swift
//  baisi
//
//  Created by apple on 16/10/3.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit
import AFNetworking
import MJExtension
import SVProgressHUD

class SLEMeFooterView: UIView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        SVProgressHUD.showWithStatus("正在请求数据")
        let params = NSMutableDictionary()
        params["a"] = "square";
        params["c"] = "topic";
        
        AFHTTPSessionManager().GET("http://api.budejie.com/api/api_open.php", parameters: params, progress:
            { ( progress : NSProgress) in
                
            },success:
            { (let task : NSURLSessionDataTask, responseObject : AnyObject?) in
                SVProgressHUD.dismiss()
                let squares = SLESquare.mj_objectArrayWithKeyValuesArray(responseObject!["square_list"])
                
                self.creatSquares(squares)
                
        }) {(task : NSURLSessionDataTask?,  error : NSError?) in // 出错
            
            
        }
    }
    
    func creatSquares(squares : NSArray)
    {
    
        // 第一最大行数
        let maxCol = 4;
        let buttonW = sle_screenWidth / CGFloat(maxCol)
        let buttonH = buttonW;
        
        for i in 0...(squares.count - 1) {
    
            let button : SLESquareButton = SLESquareButton(type: .Custom)
    
            let square : SLESquare = squares[i] as! SLESquare
            button.setTitle(square.name, forState: .Normal)
            button.sd_setImageWithURL(NSURL(string: square.icon), forState: .Normal)
            button.addTarget(self, action: #selector(butotnClick(_:)), forControlEvents: .TouchUpInside)
            
            let row = i / maxCol
            let col = i % maxCol
            let buttonX = CGFloat(col) * buttonW
            let buttonY = CGFloat(row) * buttonH
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH)
            
            self.addSubview(button)
        
        }
    
        // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
        
        let rows = (squares.count + maxCol - 1) / maxCol
        
        // 计算footer的高度
        self.sle_height = CGFloat(rows) * buttonH
        
        // 重绘
        self.setNeedsDisplay()
    
    }
    
     func butotnClick(button : SLESquareButton){
    
        
    
    }
    
    
    

   
}
