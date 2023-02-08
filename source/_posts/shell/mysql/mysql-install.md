---
title: mysql install
date: 2022-12-17 11:24:25
tags: [sql, mysql]
---

## mysql install

### 创建文件
- 在要部署的地方, 创建 docker-compose.yaml 文件
- 创建 mysql 文件夹



### 编辑 docker-compose
```yaml

version: '3.7'
services:
  mysql:
    image: mysql
    container_name: mysql
    restart: always
    ports:
      - 3306:3306   
    volumes:
      - ./mysql/data:/var/lib/mysql
      - ./mysql/my.cnf:/etc/mysql/my.cnf
    environment:
      MYSQL_ROOT_PASSWORD: 123456
      TZ: Asia/Shanghai

```

### docker run
```sh
docker-compose up -d mysql
```
- other
```sh
docker run -d --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql
```

### 进入mysql
```sh
docker exec -it mysql sh
```

### update mysql passwrod type
```sh
# 进入 mysql
mysql -u root -p
# input password

alter user 'root'@'localhost' identified by '123456' password expire never;

# 修改localhost 的验证方式
alter user 'root'@'localhost' identified with mysql_native_password by '123456';

# 修改外部访问的验证方式, 外部访问直接改这个就行
alter user 'root'@'%' identified with mysql_native_password by '123456';

# 查看
select user,host,plugin,authentication_string from user;

```




