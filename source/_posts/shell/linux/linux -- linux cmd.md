---
title: linux -- linux cmd
updated: 2023-04-28 06:27:50Z
created: 2023-02-08 06:58:57Z
tags:
  - linux
---

### 查看系统信息
> uname -a


### 查看硬盘情况
	df -h
	du -h /root		列举  /root 下所有目录 及子目录文件/文件夹大小
	du -sh /root 	/root 大小
	du -sh * 查看当前目录下, 所有大小
	

### 查看ip
```
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