---
title: linux 下 git 免密
updated: 2022-09-21 03:14:00Z
created: 2022-09-21 03:14:00Z
tags:
  - git
  - linux
---

### 方法一

1. cd到~/目录下，创建一个文件：touch .git-credentials
vim .git-credentials
2. 然后输入https://{username}:{password}@git.gitxx.com，比如http://fengjiaheng:password@git.gitxx.com
3. 然后执行：git config --global credential.helper store
4. 然后使用git config --list或者查看一下~/.gitconfig文件，会发现多了一行[credential] helper = store
5. 这时候再用 git 拉取仓库就不需要输入用户名和密码了。
注意：第4步必须要做，否则做完4、5步之后也不能免密码拉取成功，需要再次执行第4步骤。

### 方法二 粗暴使用型
Git Clone命令直接使用用户名密码Clone

git clone http://userName:password@链接
修改为 git clone https://username:password@链接

示例：
git clone git@http://112.12.122.22:t-mapi/hotel-tapi.git
修改为
git clone ‘http://username:password@112.12.122.22:t-mapi/hotel-tapi.git’


### 注意事项
（2）如果账号username或者password中有@符号,需要 将@替换为%40
（3）如果报错git clone event not found，需要将 git clone 后地址加上引号 ‘’