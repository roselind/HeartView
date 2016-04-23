//
//  CMPlayViewController.swift
//  WeiCloudMusic
//
//  Created by 卢良潇 on 16/3/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import KGFloatingDrawer
import AFNetworking
import AFSoundManager
import SDWebImage


protocol ChannelProtocol {
    func onChannelChange(id:String)
}
class CMPlayViewController: UIViewController {
    //数据源
    var musicInfo = [NSDictionary]()
    var musicPath = "http://www.douban.com/j/app/radio/people?app_name=radio_desktop_win&version=100&type=n&channel="
    var imageUrl:String?
    var duration:String?
    var player:AFSoundPlayback?
    @IBOutlet weak var cdPlayerImage: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var ablumImageView: CMAlbumImage!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    //判断是否在旋转
    var isRoatating: Bool!
    //唱针动画初始偏移
    var mOriginTransform : CGAffineTransform?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUI()
        setBgImage()
        loadMusic()
        ablumImageView.albumImageView?.image = UIImage(named: "5")
        //开始旋转
        ablumImageView.startRoatating()
        isRoatating = true
        self.playBtn.selected = true
        
       
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.hidden = false
    }
    
    /**
     背景毛玻璃效果
     */
    func setBgImage()
    {
    let blureffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
    let visualView = UIVisualEffectView(effect: blureffect)
        visualView.frame = UIScreen.mainScreen().bounds
        visualView.alpha = 1
        bgImage.addSubview(visualView)
    }
    
    func setUI()
    {
        self.tabBarController?.tabBar.hidden = true
        mOriginTransform = cdPlayerImage.transform
        setAnchorPoint(CGPointMake(0.25, 0.16), forView: self.cdPlayerImage)
    }
    
    
    func loadMusic()
    {
        //默认频道1
        let path = musicPath + "2"
        AFHTTPSessionManager().GET(path, parameters: nil, success: { (_, JSON) in
  
            self.musicInfo = JSON!["song"] as! [NSDictionary]
                       self.setupMusicInfo()
            }) { (_, error) in
                print(error)
        }
        
        let path2 = "http://music.163.com/api/playlist/detail?id=58451795"
        AFHTTPSessionManager().GET(path2, parameters: nil, success: { (_, JSON) in
         
            }) { (_, error) in
                print(error)
        }
        
    }
    
    
   func  setupMusicInfo()
   {
    //设置专辑封面
    imageUrl = musicInfo[0].valueForKey("picture") as! String
    self.ablumImageView.albumImageView?.sd_setImageWithURL(NSURL(string: imageUrl!), placeholderImage: UIImage(named: "cm2_default_cover_program"))
    //设置背景图片
    self.bgImage.sd_setImageWithURL(NSURL(string: imageUrl!))
    //标题
    self.titleLabel.text = musicInfo[0].valueForKey("artist") as! String
    //歌曲路径
    let musicurl = musicInfo[0].valueForKey("url") as! String
    
    //开始播放音乐
    
    
    AFSoundManager.sharedManager().startStreamingRemoteAudioFromURL(musicurl) { (percentage, elapsedTime, timeRemaining, error, finished) in
        //
    }
    
    
    AFSoundManager.sharedManager().startStreamingRemoteAudioFromURL(musicurl, andBlock: { (percentage, elapsedTime, timeRemaining, error, finished) -> Void in
        if error != nil {
            print(error)
        } else {
            if finished {
                
            } else {
                self.duration = String(percentage)
                
               //设置进度条
                self.progressView.setProgress(CFloat(percentage) * 0.01, animated: true)
                //设置时间方法
                func generateString(time:CGFloat) -> String {
                    if !time.isNaN {
                        let all:Int = Int(time)
                        let m:Int = all%60
                        let f:Int = Int(all/60)
                        var time:String = ""
                        //小时
                        if f<10{
                            time = "0\(f):"
                        }else{
                            time = "\(f):"
                        }
                        // 分钟
                        if m<10{
                            time += "0\(m)"
                        }else{
                            time += "\(m)"
                        }
                        return time
                    } else {
                        return "00:00"
                    }
                }
               
              self.duration = String(format: "%.0f", elapsedTime)
              
                //赋值时间
                self.startTime.text = generateString(elapsedTime)
                self.endTime.text = generateString(timeRemaining)
               
            }
        }
    })
    
    
    
    //设置锁屏信息
    setLockedScreenInfo()

    
    }
    
  
    
 //弹出菜单点击
    @IBAction func drawClick(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerViewController.toggleDrawer(KGDrawerSide.Left, animated: true) { (finished) -> Void
            in
        }
    }


 //   播放点击
 
    @IBAction func playClick(sender: AnyObject) {
        if isRoatating == true
        {
            pause()
            
        }
        else
        {
           
           resume()
            
                }
    }
    
    //暂停
    func pause()
    {
        ablumImageView.pauseRoatating()
        cdPlayerAnimation()
        isRoatating = false
        self.playBtn.selected = false
        AFSoundManager.sharedManager().pause()
    }
    
    //重新播放
    func resume()
    {
        ablumImageView.resumeRoatating()
        cdPlayerAnimation()
        isRoatating = true
        self.playBtn.selected = true
        AFSoundManager.sharedManager().resume()
    }
    //红心按钮
    @IBAction func likeClick(sender: AnyObject) {
        if self.likeBtn.selected == true
        {
        self.likeBtn.selected = false
        }
        else
        {
            self.likeBtn.selected = true
        }
    }
    
    //nav我的按钮
    @IBAction func meClick(sender: AnyObject) {
        
    }
    
    //唱针动画
    func cdPlayerAnimation()
    {
        if isRoatating == true {
     UIView.animateWithDuration(0.75, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.cdPlayerImage.transform =  CGAffineTransformMakeRotation(-CGFloat(M_PI / 6))
        
        }, completion: nil)
        }
        else
        {
    UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                self.cdPlayerImage.transform =  self.mOriginTransform!
                
                }, completion: nil)
        
    }
    }
    
    
    //修改唱针位置
    func  setAnchorPoint(anchorPoint:CGPoint,forView:UIImageView)
    {
        var newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = CGPointApplyAffineTransform(newPoint, view.transform)
        oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        forView.layer.position = position
        forView.layer.anchorPoint = anchorPoint
    }
    
    
    //设置锁屏信息
    func setLockedScreenInfo()
    {
        //获取锁屏界面中心
        let playingInfoCenter = MPNowPlayingInfoCenter.defaultCenter()
        //设置专辑封面
  
         let artwork = MPMediaItemArtwork(image: UIImage(named: "5")!)
        //MPMediaItemPropertyAlbumTitle：专辑名
        //MPMediaItemPropertyPlaybackDuration:currentTime：时间长度条
        let info = [MPMediaItemPropertyArtwork:artwork,MPMediaItemPropertyAlbumTitle:self.titleLabel.text!] as [String:AnyObject]?
        
        
        playingInfoCenter.nowPlayingInfo = info
        //让应用可以接受远程事件
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
    }
    
    
    // MARK: - Channel Delegate
    override func remoteControlReceivedWithEvent(event: UIEvent?)
    {
        
   
        
        UIEventSubtype.RemoteControlPause
        
        switch event!.subtype {
        case UIEventSubtype.RemoteControlPause:
            pause()
        case UIEventSubtype.RemoteControlPlay:
            resume()
        default:
            print("111")
        }
        
        
    }


    
}


