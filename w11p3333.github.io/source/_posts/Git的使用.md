---
title: Git的使用
date: 2016-04-17

---

网上关于git命令的使用虽然多，但是太杂而且错误百出，我也是踩了许多坑，总结了下常用的。现在觉得敲git简直不要太爽233333
<!--more-->
### git的安装

       
先安装homebrew
再执行brew install git

### 配置git ssh
在终端

		//邮箱不一定是github账号
		ssh-keygen -t rsa -C "yourname@hotmail.com"

		//按3个回车，密码为空。
		//获取key
		cat ~/.ssh/id_rsa.pub
		将得到的key在github中ssh key中添加
		//连接github
		ssh -T git@github.com
		//出现Hi w11p3333! You've successfully authenticated, but GitHub does not provide shell access.为成功
		
###搭建github博客
见此文http://www.jianshu.com/p/4eaddcbe4d12

如发生报错：ERROR Process failed: layout/.DS_Store, 那么进入主题里面layout和_partial目录下，使用删除命令：

        rm-rf.DS_Store
本地测试：hexo s
退出测试：control + c
发布博客：hexo clean && hexo g && hexo d
前文：<!--more-->
### 一个项目完整的git流程
在这之前你应该在github上已经创建好仓库了

   		  //注意要先cd到项目目录
		  //克隆项目
		  git clone https://github.com/GithubName/ProjectName.git
		  //更改仓库地址
		  git remote add origin       https://github.com/GithubName/ProjectName.git
		  //添加项目
		  git add -A     // -A是添加全部 只添加修改的话使用git add .
		  //提交修改
		  git commit -m "edit"
		  //如果项目与当地不一致
		  git pull  // 如果提示错误了使用  git pull --rebase origin master
		  //提交到远程仓库
		  git push -u origin master


### 一些常用的命令
### 更改远程仓库
		   git remote add origin https://github.com/GithubName/ProjectName.git
### 删除远程仓库内所有文件
		cd到项目文件夹

		  git rm * -r  
		  git add .
		  git commit -m "clear"
		  git push -u origin master
		回退版本
		 git log   //查看日志 找到对应的hash值
		 git reset --hard f093b6ed512f761a346e2e5c0f00230e448c217c  //改成对应的hash值
### 退出git log
    按q
### 修改用户
		[~]$ git config --global user.name "lubin" 
		[~]$ git config --global user.email lubin.z@gmail.com 
### 在readme中添加图片 
首先要添加图片到远程仓库里
            
             ![](https://github.com/yourname/yourProjectname/raw/master/image/pic.png)
             
### 常见的问题
###    1.The following untracked working tree files would be overwritten by checkout和 Please move or remove them before you can merge
解决方案

    git clean  -d  -fx ""
    其中
    x  -----删除忽略文件已经对git来说不识别的文件
    d  -----删除未被添加到git的路径中的文件
    f  -----强制运行
    

### 2.remote origin already exists
解决方案

        1、先输入$ git remote rm origin
        
        2、再输入$ git remote add 
### Not a git repository (or any of the parent directories): .git

git init就可以了！ 


### 3.Pull is not possible because you have unmerged files.
local文件冲突了,pull会使用git merge导致冲突，需要将冲突的文件resolve掉 

        git add -u, git commit       