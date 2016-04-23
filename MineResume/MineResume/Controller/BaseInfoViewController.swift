//
//  BaseInfoViewController.swift
//  MineResume
//
//  Created by 卢良潇 on 16/3/24.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class BaseInfoViewController: BaseViewController {

    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var sexLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var studentLabel: UILabel!
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    //视图宽度
    var viewWidth: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWidth = self.view.bounds.width
        
        titleLabel.transform =  CGAffineTransformMakeTranslation(0, -100)
        titleLabel.alpha = 0
        
        nameLabel.transform =  CGAffineTransformMakeTranslation(-viewWidth, 0)
        sexLabel.transform =  CGAffineTransformMakeTranslation(-viewWidth, 0)
        ageLabel.transform =  CGAffineTransformMakeTranslation(-viewWidth, 0)
        studentLabel.transform =  CGAffineTransformMakeTranslation(-viewWidth, 0)
        schoolLabel.transform =  CGAffineTransformMakeTranslation(-viewWidth, 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            
            self.titleLabel.transform = CGAffineTransformIdentity
            self.titleLabel.alpha = 1
        }) { (_) -> Void in
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.nameLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.sexLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0.3, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.ageLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.studentLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
            
            UIView.animateWithDuration(0.3, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.schoolLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
            
            
        }
        
    }


 

}
