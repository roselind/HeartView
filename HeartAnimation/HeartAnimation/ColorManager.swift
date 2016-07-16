//
//  ColorManager.swift
//  HeartAnimation
//
//  Created by 卢良潇 on 16/7/16.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class ColorManager: NSObject {

    
    
     func getColor(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor{
    
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
        
    }
    
}
