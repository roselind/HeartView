//
//  CMListTableViewController.swift
//  WeiCloudMusic
//
//  Created by 卢良潇 on 16/3/28.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import AFNetworking
import KGFloatingDrawer

class CMListTableViewController: UITableViewController {

    var delegate: ChannelProtocol?
    //数据源
    var channelList:[NSDictionary] = [NSDictionary]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
       tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        loadList()
        let imageview = UIImageView(image: UIImage(named: "1"))
        tableView.backgroundView = imageview
    }

    func loadList()
    {
    let path = "http://www.douban.com/j/app/radio/channels"
    AFHTTPSessionManager().GET(path, parameters: nil, success: { (_, JSON) in
        self.channelList = JSON!["channels"] as! [NSDictionary]
        }) { (_, error) in
            print(error)
        }
        
    }
   
    // MARK: - Table view data source

 
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.channelList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
  
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text = channelList[indexPath.row].objectForKey("name") as?
        String

       

        return cell
    }
    

  
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).drawerViewController.closeDrawer(KGDrawerSide.Right, animated: true) { (finished) -> Void in
            
        }
    self.delegate?.onChannelChange(self.channelList[indexPath.row].objectForKey("channel_id") as! String)
    }
}
