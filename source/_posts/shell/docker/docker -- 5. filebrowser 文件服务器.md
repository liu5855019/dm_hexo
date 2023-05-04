---
title: docker -- 5. filebrowser 文件服务器
updated: 2023-04-24 09:39:26Z
created: 2023-04-24 09:39:26Z
tags:
  - docker
  - filebrowser
---

# filebrowser 文件服务器

### 地址
- github地址: [GitHub](https://github.com/filebrowser/filebrowser/)
- feature: [Feature](https://filebrowser.org/features)

### 主要功能
- 上传文件
- 浏览文件
- 分享文件
- 下载文件
- shell
- 默认账号密码: admin -- admin


<!-- more -->





### Docker 中使用

#### docker run
```shell
docker run \
  -v /path/to/root:/srv \
  -v /path/to/filebrowser.db:/database/filebrowser.db \
  -v /path/to/settings.json:/config/settings.json \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -p 8080:80 \
  filebrowser/filebrowser:s6
```


#### docker-compose
```yaml
version: '3.7'
services:
  filebrowser:
    image: filebrowser/filebrowser:s6
    container_name: filebrowser
    restart: always
    ports:
      - 8006:80
    volumes:
      - ./filebrowser/srv:/srv
      - ./filebrowser/database:/database
      - ./filebrowser/config:/config
```



