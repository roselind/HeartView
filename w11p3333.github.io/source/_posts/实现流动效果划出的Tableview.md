
---
title: 实现流动效果划出的Tableview
date: 2016-04-15
---
<!--more-->


先上Demo：https://github.com/w11p3333/LLXAnimateTableview

    ![动画效果][1]


  [1]: http://upload-images.jianshu.io/upload_images/1449048-2b19c0a5e72d99bc.GIF?imageMogr2/auto-orient/strip

主要实现：

    func animationTable() {
    
    self.tableView.reloadData()
    
    let cells = tableView.visibleCells
    let tableHeight: CGFloat = tableView.bounds.size.height
    
    for i in cells {
        let cell: UITableViewCell = i as UITableViewCell
        cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
    }
    
    var index = 0
    
    for a in cells {
        let cell: UITableViewCell = a as UITableViewCell
        UIView.animateWithDuration(1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            cell.transform = CGAffineTransformMakeTranslation(0, 0);
        }, completion: nil)
        
        index += 1
    }
        }

然后在viewWillAppear中调用它