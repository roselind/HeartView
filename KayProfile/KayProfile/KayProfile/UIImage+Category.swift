//
//  UIImage+Category.swift
//  KayProfile
//
//  Created by 卢良潇 on 16/4/24.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

extension UIColor
{


    class func imageWithColor(color:UIColor) -> UIImage
   {

    //形状
    let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
    //开启获取上下文
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    //填充
    CGContextSetFillColorWithColor(context, color.CGColor)
    //渲染
    CGContextFillRect(context, rect)
    //获取图片
    let image = UIGraphicsGetImageFromCurrentImageContext()
    //关闭上下文
    UIGraphicsEndImageContext()
    
    return image
    
    }


}
