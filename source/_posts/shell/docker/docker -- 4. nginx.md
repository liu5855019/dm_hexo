---
title: docker -- 4. nginx
updated: 2023-04-24 08:53:32Z
created: 2023-04-24 08:53:32Z
tags:
  - docker
  - nginx
---

# nginx

### github地址


### 主要功能


### 主要特性


<!-- more -->





### Docker 中使用

#### docker run



#### docker-compose
```yaml
version: '3.7'
services:
  nginx:
    image: nginx
    container_name: nginx
    restart: always
    ports:
      - 8080:80
    volumes:
      - ./nginx/nginx:/etc/nginx
      - ./nginx/html:/usr/share/nginx/html
      - ./nginx/logs:/var/log/nginx
    environment:
      TZ: Asia/Shanghai
```



