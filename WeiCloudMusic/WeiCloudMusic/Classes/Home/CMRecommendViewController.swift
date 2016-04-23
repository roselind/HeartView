//
//  CMRecommendViewController.swift
//  WeiCloudMusic
//
//  Created by 卢良潇 on 16/3/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import SDCycleScrollView

class CMRecommendViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableview()
      
    }

    func setupTableview()
    {
     tableView.tableFooterView = UIView()
    
    }
      // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 8
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if section == 0
       {
         return 0
        }
        else
       {
        return section == 8 ? 1 : 3
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0
        {
         let imageGroup = ["1","2","3","4","5"]
         let scrollview = SDCycleScrollView(frame: CGRectMake(0, 0, (UIScreen.mainScreen().bounds.width), 200), imageNamesGroup: imageGroup)
        return scrollview
        }
        else{
            return nil
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 200 : 22
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "总有一些歌，让你相信爱情"
        case 2:
            return "热门歌单"
        case 3:
            return "我是歌手"
        case 4:
            return "新歌新碟"
        case 5:
            return "最热MV"
        case 6:
            return "独家专区"
        case 7:
            return "亚洲新歌榜"
        default:
            return nil
        }
        
    }
}
