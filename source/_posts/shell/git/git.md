---
title: git 命令小记
date: 2022-12-02 18:02:50
tags: git
---



### 配置

1. git config --global user.name "xxxxxx"		
		
		配置全局用户名 

2. git config --global user.email "xxxxxx@xxx.com"  
		
		配置全局用户邮箱

3. git config --global core.editor vim  	
		
		配置git 提交信息的编辑器

4. 以上命令省去 --global 

		可以对单独的项目进行配置

5. 在git的全局配置（~/.gitconfig）中可以对 一些命令起别名 

6. 在每个git管理的项目中可以假如 .gitignore 文件用来设置 可以被忽略的文件格式


### 基础命令

1. git status 
		
		查看文件状态

2. git add <file1> <file2> <file3>  
		
		把文件添加到git , 需要添加多个文件时，可以使用 add .或者 add * 来批量添加所有文件

3. git commit -m "备注信息" 
		
		git commit -a -m "备注信息" 可以把 已经至少add过一次的所有文件（假如是新文件，就不会被提交）的修改提交
		
		提交文件，并且加上提交时的备注信息，如果不加-m 会进入编辑器界面编辑备注信息

4. git log 

		查看历史提交记录
		
5. git tag <tagname> -m"备注" <commit值>

		给固定的记录打上标记
		
6. git cat-file -p <commit值>

		查看指定commit中所包含的内容
		tree 是指本次提交中的文件结构 parent 是本次commit的父节点 blob 是具体的文件的对象

### 撤销修改

1. git checkout  <file> 

		从历史区中捡出 file 把当前工作区中修改的内容覆盖掉 这样的操作比较危险，误操作时容易把工作区的改动全部删除
		
2. git stash  
		
		把当前工作区的中修改撤销 ，撤销的修改会以 栈 的形式存放 ，如果需要把撤销再复原的话，可以使用 git stash pop 把撤销拿回来; 如果需要彻底清空 stash里的内容可以 使用 git stash clear来清除垃圾区

3. git rm <file>
	
		可以把文件从历史区中删除，所以要想从git管理中删除某一个文件，必须使用 git rm，而不是直接使用rm
		
4. git reset HEAD <file>
		
		可以把已经add到暂存区的修改再撤销回工作区vi
		
		
### 对比文件差异

1. git diff <file>

		

### 分支操作

1. git branch 

		列出当前所有分支
	1.1 git branch --all   // 所有的分支


2. git branch <分支名> 

		基于当前分支的最新提交拉取一次分支

3. git checkout <分支名> 

		切换到指定的分支上去
		- 切换远程分支到本地
		git checkout -b cad_team_a remotes/origin/cad_team_a

4. git branch -d <分支名> 

		删除指定的分支 ，如果确定需要删除可以使用 -D 强制删除
		
5. git checkout -b <分支名>

		会创建并且切换到该分支	
		
6. git reset --hard <commit值>

		可以回退本分支上的某一次 具体的提交
		
7. git merge <分支名>

		merge是把指定分支合并到当前的分支
		git merge --no-merged 可以查看当前还有哪些分支与当前分支没有合并的
		git merge --merge 可以查看已经与当前分支合并过的分支
		
8. git cherry-pick <commit值>

		从别的分支上捡出一个commit与当前分支合并

9. git rebase

		重衍（变基）命令
		将某个分支的改动直接加入到某一指定分支上冲重新开展，效果是在最终的log里看不到有侧分支的痕迹
		1  切换到需要 重衍的 分支  		git checkout someBranch （需要重衍的分支）
		2  执行重衍命令           		git rebase baseBranch (重衍基于的分支)
		3  切换到基于的分支合并重衍的分支	git checkout baseBranch > git merge someBranch

### 远程操作

1. git clone 
		
		克隆远端仓库
		
		基于ssh的远端地址 ssh://qingyun@192.168.1.233:/Users/qingyun/Desktop/code1512/Code/20160128/TestRemote
		基于http/https的远端地址 http(https)://xxx.xxx.com/xxxx.git 

		加 -o 可以给远端仓库改名，默认是 origin

2. git remote

		列出远端仓库列表
		
		git remote rename remoteName newName  给远端仓库改名
		git remote show 列出远端仓库列表
		git remote add <仓库名> <远端地址>	添加新的远端仓库
		git remote rm <仓库名> 删除指定远端仓库
	
3. git fetch

		拉取远端仓库内容
		git fetch <仓库名> 拉取指定远端仓库的内容
		
		fetch只是把远端仓库内容下载到本地，如果需要将内容与本地分支合并 需要
		git merge <仓库名>/<分支名>
		
4. git pull <仓库名> <远端分支名>

		拉取远端分支并且跟本地分支合并 类似 fetch+merge 的组合
		
5. git push <仓库名> <本地分支名>
    
        推送到服务器

6. git push <仓库名> :<服务器分支名>

        删除服务器上的某一分支
		
		


