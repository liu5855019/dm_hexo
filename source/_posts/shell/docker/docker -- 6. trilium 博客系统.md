---
title: docker -- 6. trilium 博客系统
updated: 2023-04-28 06:39:04Z
created: 2023-04-28 06:22:23Z
latitude: 34.34157500
longitude: 108.93977000
altitude: 0.0000
tags:
  - docker
---

### trilium  博客系统
---

### 地址

*   [中文 github 地址](https://trilium.netlify.app/)
*   [原版地址](https://github.com/zadam/trilium)
*   [wiki 地址](https://trilium.netlify.app)

### 主要功能(使用几天的感受)

*   支持 markdown, 但感觉不太多
*   Trilium 使用了很棒的[CKEditor 5](https://ckeditor.com/ckeditor-5/)作为它的编辑组件。但我感觉不太好用,  可能是不会
*   可以导出/导入markdown,  不是完美兼容
*   可以导出html
*   有客户端,  可以在客户端直接编辑, 随后同步到服务器
*   部署私有服务器, 数据在自己手中

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