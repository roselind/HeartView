//
//  CMMyMusicTableViewController.swift
//  WeiCloudMusic
//
//  Created by 卢良潇 on 16/3/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class CMMyMusicTableViewController: UITableViewController {

    
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
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 4
        }
        else if section == 1
        {
            return 1
        }
        else
        {
            return 3
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        if indexPath.section == 0 {
            let data = ["下载音乐","最近播放","我的歌手","我的电台"]
            cell.textLabel?.text = data[indexPath.row]
            return cell
        }
            
        else if indexPath.section == 1
        {
            cell.textLabel?.text = "我喜欢的音乐"
            return cell
        }
        else{
            
            let data = ["评论最多的纯音乐汇总","流行与古典的碰撞产物","听觉盛宴|凄美纯音"]
            cell.textLabel?.text = data[indexPath.row]
            return cell
        }
        
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0
        {return 0}
        else {return 30}
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(13)
        label.frame = CGRectMake(20, 0, 150, 30)
        view.addSubview(label)
        if section == 0
        {
            return nil
            
        }
        if section == 1
        {
            label.text = "我创建的歌单"
            return view
        }
        else
        {
            
            label.text = "我收藏的歌单"
            return view
        }
        
    }
    
}
