//
//  CMHomeViewController.swift
//  WeiCloudMusic
//
//  Created by 卢良潇 on 16/3/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class CMHomeViewController: YZDisplayViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        addChildControllers()
    }

    func addChildControllers()
    {
        let recommend = CMRecommendViewController()
        recommend.title = "个性推荐"
        addChildViewController(recommend)
        let musicList = CMMusicListViewController()
        musicList.title = "歌单"
        addChildViewController(musicList)
        let fm = CMFMViewController()
        fm.title = "主播电台"
        addChildViewController(fm)
        let rankList = CMRankListViewController()
        rankList.title = "排行榜"
        addChildViewController(rankList)

    }
   
    @IBAction func playClick(sender: AnyObject) {
        
//        storyboardWithName:@"MainStoryboard" bundle:nil];
//        ViewController *Controller = [mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];

        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("playVc")
        self.navigationController?.pushViewController(vc, animated: true)

    }
    func setTitle()
    {
        
        
        
        isShowUnderLine = true
        underLineColor = bgcolor
        isShowTitleGradient = true
        isShowTitleCover = false
        
        titleHeight = 38
        endR = 32 / 255.0
        endG = 142 / 255.0
        endB = 115 / 255.0
        
        // 是否显示遮盖
        titleScrollViewColor = UIColor.whiteColor()
        
        coverColor = UIColor(white: 0.7, alpha: 0.4)
        coverCornerRadius = 13
        norColor = UIColor.blackColor()
        selColor = UIColor.whiteColor()
        
        
    }


}
