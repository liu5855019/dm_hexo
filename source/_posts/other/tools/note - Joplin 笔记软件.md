---
title: note - Joplin 笔记软件
updated: 2023-04-28 07:11:58Z
created: 2023-04-28 07:03:06Z
latitude: 34.34157500
longitude: 108.93977000
altitude: 0.0000
tags:
  - note
  - tools
---

## Joplin 笔记软件
---




### 主要功能(使用几天的感受)

*   完美支持 markdown
*   可以导出/导入markdown
*   支持 tags, title, date 等
*   可以导出html
*   有客户端,  可以在客户端直接编辑, 随后同步到服务器
*   部署私有服务器, 数据在自己手中


### 地址

*   [中文 github 地址](https://trilium.netlify.app/)
*   [原版地址](https://github.com/zadam/trilium)
*   [wiki 地址](https://trilium.netlify.app)



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