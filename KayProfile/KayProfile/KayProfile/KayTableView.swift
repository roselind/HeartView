//
//  KayTableView.swift
//  KayProfile
//
//  Created by 卢良潇 on 16/4/24.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class KayTableView: UITableView {

    
    var tabbar: UIView?
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        
//        
//        UITouch *touch = [touches anyObject];
//        CGPoint curP = [touch locationInView:self];
//        
//        
//        for (UIView *tabBarChildView in _tabBar.subviews) {
//            
//            CGPoint childP = [self convertPoint:curP toView:tabBarChildView];
//            
//            if ([tabBarChildView pointInside:childP withEvent:event]) {
//                // 点击了按钮
//                
//                // 通知个人控制器切换内容视图
//                [[NSNotificationCenter defaultCenter] postNotificationName:YZClickBtnNote object:nil userInfo:@{YZClickBtnObjcKey: tabBarChildView}];
//                
//                // 处理完事件，结束当前事件处理
//                return;
//                
//            }
//        }
//        
//        // 如果没有处理事件，就调用系统自带的处理方式
//        [super touchesBegan:touches withEvent:event];
//
        let touch = touches
        
        
        
    }
    
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
