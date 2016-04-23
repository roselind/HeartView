//
//  SkillsViewController.swift
//  MineResume
//
//  Created by 卢良潇 on 16/3/24.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class SkillsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
     var viewHeight:CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.transform =  CGAffineTransformMakeTranslation(0, -100)
        titleLabel.alpha = 0
        viewHeight = self.view.bounds.height
        
        bgView.transform =  CGAffineTransformMakeTranslation(-viewHeight, 0)
        bgView.transform =  CGAffineTransformMakeScale(0, 0)
        bgView.alpha = 0

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            
            self.titleLabel.transform = CGAffineTransformIdentity
            self.titleLabel.alpha = 1
        }) { (_) -> Void in
            
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.bgView.transform = CGAffineTransformIdentity
                self.bgView.alpha = 1
                }, completion: nil)
            
        }
        
    }
    
}
