---
title: docker -- 3. ddns-go
updated: 2023-04-24 07:31:04Z
created: 2023-04-24 07:31:04Z
tags:
  - ddns
  - docker
---

# ddns-go

### github地址
- 地址: [__GitHub__](https://github.com/jeessy2/ddns-go)

### 主要功能
- 自动获得你的公网 IPv4 或 IPv6 地址，并解析到对应的域名服务。

### 主要特性
- 支持Mac、Windows、Linux系统，支持ARM、x86架构
- 支持 Docker 中部署; 
  > 重要:
  > docker 部署的时候需要使用host模式 
  > host模式只能在linux中使用 
  > 所以只能在 linux 中 Docker 部署
- 支持的域名服务商 Alidns(阿里云) 
- 支持多个域名同时解析
- 网页中配置，简单又方便，默认勾选禁止从公网访问
- 支持Webhook通知

<!-- more -->





### Docker 中使用

#### docker run
- code
```bash
docker run -d --name ddns-go \
--restart=always \
--net=host \
-v ./root:/root \
jeessy/ddns-go
```
- 在浏览器中打开http://主机IP:9876，修改你的配置，成功


#### docker-compose
```yaml
version: '3.7'
services:
  ddns:
    image: jeessy/ddns-go
    container_name: ddns-go
    restart: always
    network_mode: host
    volumes:
      - ./ddns-go/root:/root
    environment:
      TZ: Asia/Shanghai
```


### 系统中直接使用
- 看官网方法

### 其他功能
- 看官网

