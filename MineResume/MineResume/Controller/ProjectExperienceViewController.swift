//
//  ProjectExperienceViewController.swift
//  MineResume
//
//  Created by 卢良潇 on 16/3/24.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class ProjectExperienceViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var projectoneLabel: UILabel!
    
    @IBOutlet weak var projecttwoLabel: UILabel!
    
     var viewHeight:CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        titleLabel.transform =  CGAffineTransformMakeTranslation(0, -100)
        titleLabel.alpha = 0
        viewHeight = self.view.bounds.height
        

        
        addtransform(projectoneLabel)
        addtransform(projecttwoLabel)
    }
    
    
    func  addtransform(label:UILabel)
    {
        label.layer.borderColor = UIColor.whiteColor().CGColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 10
        label.transform =  CGAffineTransformMakeTranslation(-viewHeight, 0)
    
    }
    

  
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            
            self.titleLabel.transform = CGAffineTransformIdentity
            self.titleLabel.alpha = 1
        }) { (_) -> Void in
            
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.projectoneLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
            
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.projecttwoLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
            
        }
        
    }
    
}
