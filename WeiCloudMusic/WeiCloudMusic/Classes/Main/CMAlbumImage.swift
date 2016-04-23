//
//  CMAlbumImage.swift
//  WeiCloudMusic
//
//  Created by 卢良潇 on 16/3/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class CMAlbumImage: UIImageView {

    
    var albumImageView: UIImageView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        

        self.albumImageView = UIImageView(frame: CGRectMake((self.frame.size.width / 2 ) - (160 / 2), (self.frame.size.height / 2 ) - (160 / 2), 180 , 180))
        //设置圆角
        self.albumImageView?.clipsToBounds = true
        self.albumImageView?.layer.cornerRadius = (self.albumImageView?.frame.height)! / 2
        
        
     
        self.addSubview(albumImageView!)
       
    }
    /**
     旋转动画
     */
    func startRoatating()
    {
    let rotateAni = CABasicAnimation(keyPath: "transform.rotation")
        rotateAni.fromValue = 0.0
        rotateAni.toValue = M_PI * 2.0
        rotateAni.duration = 20.0
        rotateAni.repeatCount = MAXFLOAT
    
        self.layer.addAnimation(rotateAni, forKey: nil)
    }
    /**
     暂停
     */
    func pauseRoatating()
    {
        let pauseTime  = self.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        self.layer.speed = 0.0
        self.layer.timeOffset = pauseTime

    }
    /**
     恢复
     */
    func resumeRoatating()
    {
      let pauseTime = self.layer.timeOffset
        self.layer.speed = 1.0
        self.layer.timeOffset = 0.0
        self.layer.beginTime = 0.0
        let timeSincePaused = self.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pauseTime
        layer.beginTime = timeSincePaused
    
    }

}
