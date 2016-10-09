//
//  SLEUIViewExtention.swift
//  baisi
//
//  Created by apple on 16/10/1.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit

extension UIView {
    
  
    /// view的 x 值
    public var sle_x: CGFloat{
        get{
            
            return self.frame.origin.x
        }
        set{
            
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    /// view的 y 值
    public var sle_y: CGFloat{
        get{
            
            return self.frame.origin.y
        }
        set{
            
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    /// view最大 x 值
    public var sle_maxX: CGFloat{
        get{
            
            return CGRectGetMaxX(frame)
        }
        set{
            
            self.sle_x = newValue - self.sle_width
        }
    }
    
    /// view最大 y 值
    public var sle_bottomY: CGFloat{
        get{
            
            return CGRectGetMaxY(frame)
        }
        set{
            
            var r = self.frame
            r.origin.y = newValue - frame.size.height
            self.frame = r
        }
    }
    
    /// view中心点 x 值
    public var sle_centerX : CGFloat{
        get{
            
            return self.center.x
        }
        set{
            
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    /// view中心点 y 值
    public var sle_centerY : CGFloat{
        get{
            
            return self.center.y
        }
        set{
            
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    /// view的宽度
    public var sle_width: CGFloat{
        get{
            
            return self.frame.size.width
        }
        set{
            
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    
    /// view的高度
    public var sle_height: CGFloat{
        get{
            
            return self.frame.size.height
        }
        set{
            
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }

    public func sle_isShowingOnKeyWindow() -> Bool{
        
        let keyWindow = UIApplication.sharedApplication().keyWindow
        let newFrame = keyWindow!.convertRect(self.frame, fromView: self.superview)
        let keyWidowBounds = keyWindow!.bounds
        
        let interects: Bool = CGRectIntersectsRect(newFrame, keyWidowBounds);
        
        
        
        return (self.hidden == false) && (self.alpha > 0.01) && (self.window == keyWindow) && interects;
        
    }
    
}

extension NSObject{

    public var sle_screenWidth : CGFloat{
        
        get{
            
            return UIScreen.mainScreen().bounds.size.width
        }
        
    }
    public var sle_screenHeight : CGFloat{
        
        get{
            
            return UIScreen.mainScreen().bounds.size.height
        }
        
    }

    
    
    
    
}



