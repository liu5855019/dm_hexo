---
title: linux -- ubuntu config root
updated: 2022-12-27 03:46:48Z
created: 2022-12-27 03:46:48Z
tags:
  - linux
  - ubuntu
---

### 1. 修改 sshd_config

```shell
cd /etc/ssh
vim sshd_config

# 找到 Authentication 下的 PermitRootLogin prohibit-password
#修改为:
PermitRootLogin yes
```


### 2. 重启 ssh

```shell
/etc/init.d/ssh restart
```

### 3. 重置 root 用户的密码
  - Ubuntu的默认root密码是随机的，即每次开机都有一个新的root密码

    1. 切换到普通用户
    2. sudo passwd
    3. 根据提示输入当前用户的密码, 然后重置 root 的new密码
    4. 看到 password updated successfully, 就是重置好了

