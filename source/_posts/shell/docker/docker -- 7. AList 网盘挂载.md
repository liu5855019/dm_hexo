---
title: docker -- 7. AList 网盘挂载
updated: 2023-04-28 06:56:30Z
created: 2023-04-28 06:40:35Z
latitude: 34.34157500
longitude: 108.93977000
altitude: 0.0000
tags:
  - docker
---

### AList 网盘挂载
---

### 地址
- [AList GitHub](https://github.com/alist-org/alist)
- [Alist文档](https://alist.nn.ci/zh/guide/)

### 主要功能/特点
- 挂载本地
- 挂载各种网盘
- 网页统一访问
- 支持 WebDAV 协议对外访问

### Docker 中使用

```yaml
version: '3.7'
services:
  trilium:
    image: zadam/trilium
    container_name: trilium
    restart: always
    ports:
      - 8008:8080
    volumes:
      # 把同文件夹下的 trilium-data 目录映射到容器内
      - ./trilium/data:/home/node/trilium-data
    environment:
      # 环境变量表示容器内笔记数据的存储路径
      - TRILIUM_DATA_DIR=/home/node/trilium-data
```

### Docker 下查看admin密码
```bash
	docker exec -it alist bash
	./alist admin
```