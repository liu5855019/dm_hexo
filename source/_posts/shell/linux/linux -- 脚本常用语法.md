---
title: linux -- 脚本常用语法
updated: 2023-05-05 07:36:10Z
created: 2023-05-05 06:43:23Z
---

# shell script

## Shebang
```bash
	#! /bin/bash
	#! /bin/python
```

## 执行方式
``` bash
	#  在当前进程执行，  所赋值的变量会保留
	source test.sh
	. test.sh

	# 在子进程中执行， 脚本执行结束子进程退出， 所赋值的变量会被回收
	bash test.sh
	./test.sh
```

## 字符串内执行命令用 __``__
- cat test.sh 
```bash
    #! /bin/bash

    echo "Current time: `date`";
```
- bash test.sh 
```bash
	Current time: Wed 24 Aug 2022 05:58:00 PM CST
```

## print user info
```bash
	echo "User name is: $USER";
	echo "User uid is: $UID";
	echo "User home is: $HOME";
````

## print who login
```bash
	who
```

## 特殊符号
- 取出当前变量的值
```bash
    ${vars} 
    $vars 
```

- 在括号｀｀中执行命令， 且得到执行结果
```bash
	$(cmd)
	`cmd`
```

- 开启子shell执行命令
```bash
    (pwd; ls; type;)
```


## 三目运算
- 语法: [ cmd ] && cmd || cmd

```bash
count=1
[ $((count++)) -lt 10 ] && echo "little than 10" || echo "great than 10"
```



## 双小括号 (())
- (()): 只会计算， 并没有结果
- $(()): 计算后返回结果

```bash

	i=1
	((i=i+1))	#运行结束后,  i=2

	echo $((i=i+1)) # 执行结果 3; 且 i=3;

	i=$((i+1))  #运行结束后,  i=4

	echo $((8>9)) #: 0
	echo $((8<9)) #: 1
	
	echo $((8*9)) #: 72

	echo $((8/9)) #: 0
	echo $((9/8)) #: 1

	echo $((8%6)) #: 2

	echo $((8**2))  #: 8的2次方 64
```

## 内置命令 / 外置命令
- 内置命令: 
    - 系统启动就加载入内存, 效率高, 占资源
    - 不会开启子进程执行
    - 内置命令和 shell 是一体的, 是shell的一部分
    - 查看所有内置命令:
		```bash
		compgen -b
		```
- 外置命令: 
    - 需要从硬盘加载, 读入内存
    - 一定会开启子进程执行
    - 可能存在如下目录:
        ```bash
        /bin
        /usr/bin
        /sbin
        /usr/sbin
        ```
- 通过 type 来查看 __内置__ / __外置__
	```bash
	type ps
	```
