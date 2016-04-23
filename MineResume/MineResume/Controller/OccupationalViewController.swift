//
//  OccupationalViewController.swift
//  MineResume
//
//  Created by 卢良潇 on 16/3/24.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class OccupationalViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var jobLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var payLabel: UILabel!
    
    @IBOutlet weak var hand1: UILabel!
    
    @IBOutlet weak var hand2: UILabel!
    
    @IBOutlet weak var hand3: UILabel!
    
    @IBOutlet weak var hand4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.transform =  CGAffineTransformMakeTranslation(0, -100)
        titleLabel.alpha = 0
        
   
        
        addtransform(hand1)
        addtransform(hand2)
        addtransform(hand3)
        addtransform(hand4)
        addtransform(companyLabel)
        addtransform(jobLabel)
        addtransform(locationLabel)
        addtransform(payLabel)
       
      
        
     
    }
    
    
    
    func addtransform(label:UILabel)
    {
    label.transform = CGAffineTransformMakeTranslation(0, -1 * self.view.bounds.height)
      
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            
            self.titleLabel.transform = CGAffineTransformIdentity
            self.titleLabel.alpha = 1
        }) { (_) -> Void in
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.hand1.transform = CGAffineTransformIdentity
                self.companyLabel.transform = CGAffineTransformIdentity
            }){_ in
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.hand2.transform = CGAffineTransformIdentity
                    self.jobLabel.transform = CGAffineTransformIdentity
                }){_ in
                    
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                        self.hand3.transform = CGAffineTransformIdentity
                        self.locationLabel.transform = CGAffineTransformIdentity
                    }){_ in
                        
                        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                            self.hand4.transform = CGAffineTransformIdentity
                            self.payLabel.transform = CGAffineTransformIdentity
                            },completion: nil)
                    }
                }
                
            }
            
            
        }
        
    }
}
