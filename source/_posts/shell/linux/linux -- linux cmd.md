---
title: linux -- linux cmd
updated: 2023-05-05 07:15:53Z
created: 2023-02-08 06:58:57Z
tags:
  - linux
---

### 查看系统信息
```bash
uname -a
```

### 查看硬盘情况
	df -h
	du -h /root		列举  /root 下所有目录 及子目录文件/文件夹大小
	du -sh /root 	/root 大小
	du -sh * 查看当前目录下, 所有大小
	

### 查看ip
```bash
	ifconfig -all
```

### 重启
```
	reboot
```

### 关机
```
	shutdown -h now
```

### 查看当前所在位置
```
	pwd
```

### 查看命令所在位置
> which (要查询的命令)
> 例如: which pod
> 结果: /usr/local/bin/pod


### 进程
#### pstree
- 查看进程树

#### ps
```bash
ps -ef
# -f 显示 UID, PID, PPID
# -e 列出所有进程信息,  如同 -A

ps -ef --forest 
#按tree的样子打印进程信息
```



#### 创建进程列表
- shell 的进程列表理念: 使用 小括号 ()
	```bash
	(cd ~; pwd; ls;)
	```

#### 检测是否在子 shell 环境中
- 该变量==0: 在当前shell中运行, !=0: 开启子shell运行
	```bash
	$BASH_SUBSHELL  
	```
