//
//  EducationExperienceViewController.swift
//  MineResume
//
//  Created by 卢良潇 on 16/3/24.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class EducationExperienceViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var majorLabel: UILabel!
    
    @IBOutlet weak var honorLabel: UILabel!
    
     var viewWidth:CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        titleLabel.transform =  CGAffineTransformMakeTranslation(0, -100)
        titleLabel.alpha = 0
        viewWidth = self.view.bounds.width
        
 
        addtransform(schoolLabel)
          addtransform(timeLabel)
          addtransform(majorLabel)
          addtransform(honorLabel)
        
    }

    func  addtransform(label:UILabel)
  {
    label.transform =  CGAffineTransformMakeTranslation(-viewWidth, 0)
    label.transform =  CGAffineTransformMakeTranslation(-viewWidth, 0)
    label.transform =  CGAffineTransformMakeTranslation(-viewWidth, 0)
    label.transform =  CGAffineTransformMakeTranslation(-viewWidth, 0)
    }
    
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            
            self.titleLabel.transform = CGAffineTransformIdentity
            self.titleLabel.alpha = 1
        }) { (_) -> Void in
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.schoolLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.timeLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0.3, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.majorLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
            
            
            UIView.animateWithDuration(0.5, delay: 0.3, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.honorLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
            
        }
        
    }
    
}

