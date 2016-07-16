//
//  ViewController.swift
//  HeartAnimation
//
//  Created by 卢良潇 on 16/7/16.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white()
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bgview")
        view.addSubview(imageView)
        
        Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(ViewController.showHeartView), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
     func showHeartView(){
    
        let heartView = HeartView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(heartView)
        let fountainSource = CGPoint(x: view.frame.size.width - 80, y: view.bounds.size.height - 30 / 2.0 - 10)
        heartView.center = fountainSource
        heartView.animateInView(view: view)
    }
    

}

