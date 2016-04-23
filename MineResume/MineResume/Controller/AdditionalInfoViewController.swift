//
//  AdditionalInfoViewController.swift
//  MineResume
//
//  Created by 卢良潇 on 16/3/24.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class AdditionalInfoViewController: UIViewController {

    var viewHeight:CGFloat!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myBlogBtn: UIButton!
    @IBOutlet weak var myGithubBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.transform =  CGAffineTransformMakeTranslation(0, -100)
        titleLabel.alpha = 0
        viewHeight = self.view.bounds.height
        
      
        addtransform(myBlogBtn)
        addtransform(myGithubBtn)
    }
    
    func addtransform(btn:UIButton)
   {
    btn.layer.borderColor = UIColor.whiteColor().CGColor
    btn.layer.borderWidth = 4
    btn.layer.cornerRadius = 10
    btn.transform =  CGAffineTransformMakeTranslation(-viewHeight, 0)

    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            
            self.titleLabel.transform = CGAffineTransformIdentity
            self.titleLabel.alpha = 1
        }) { (_) -> Void in
            
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.myBlogBtn.transform = CGAffineTransformIdentity
                }, completion: nil)
            
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.myGithubBtn.transform = CGAffineTransformIdentity
                }, completion: nil)
            
        }
        
    }
    
    
    @IBAction func myBlogClick(sender: AnyObject) {
        

        let url = "http://www.jianshu.com/users/89aa04642c48/latest_articles"
        let vc = UIWebView()
        vc.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        vc.frame = UIScreen.mainScreen().bounds
        self.view.addSubview(vc)

    }
    
    @IBAction func myGithubClick(sender: AnyObject) {
        
        
        let url = "https://github.com/w11p3333"
        let vc = UIWebView()
        vc.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        vc.frame = UIScreen.mainScreen().bounds
        self.view.addSubview(vc)
    }
    
}

