---
title: vue5 -- 配置跨域
date: 2023-02-10 18:02:37
tags: [vue, cors]
categories: [vue]
---

### 1. 概念
- 同源策略：
  - 是一种约定，web 与 获取的数据同源, 才能被当前web接受/运行
  - 它是浏览器最核心也最基本的安全功能，如果缺少了同源策略，则浏览器的正常功能可能都会受到影响。

- 为什么会有不同源:
  - 在前后端分离的模式下，web 服务器 和 资源服务器会分开部署
  - 前后端的域名是不一致的，此时就会发生跨域访问问题 

- 跨域是什么：
  - 浏览器从一个域名的网页去请求另一个域名的资源时，域名、端口、协议任一不同，都是跨域
  - 即使域名相同, 端口不同 也是跨域的。



### 2. 跨域处理 
- 正规情况下, 需要后端配置跨域规则, 在后端把前端的地址端口配置进去即可

- 请求示例
  ```
  Host: 192.168.52.21:8001
  Connection: keep-alive
  Accept: */*
  Access-Control-Request-Method: GET
  Access-Control-Request-Headers: x-requestid
  Origin: http://192.168.52.21:8080
  User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
  Sec-Fetch-Mode: cors
  Referer: http://192.168.52.21:8080/
  Accept-Encoding: gzip, deflate
  Accept-Language: zh-CN,zh;q=0.9
  ```

- 返回示例
  ```
  HTTP/1.1 204 No Content
  Date: Fri, 10 Feb 2023 08:25:38 GMT
  Server: Kestrel
  Access-Control-Allow-Credentials: true
  Access-Control-Allow-Headers: x-requestid
  Access-Control-Allow-Methods: GET
  Access-Control-Allow-Origin: http://192.168.52.21:8080
  Vary: Origin
  ```

### 3. 伪跨域

- 但是作为vue前端开发者, 可能主导不了要访问的后端, 开发的时候还必须跨域访问, 然后就有了伪跨域 


- vue 伪跨域原理
  ```
  1. vue 可以配置一个代理, 这个代理是跟前端地址同源的
  2. 在启动调试的时候, 会同时启动这个代理服务
  3. 然后请求后台的时候, 把地址配置成这个代理服务, 请求这个代理服务; 
  4. 在代理服务中配置真正的后台地址, 代理服务再请求到真正的后台; 
  5. 后台返回数据后, 代理服务 返回到当前页面;
  ```

- vue 伪跨域实现
  1. 配置代理服务
      ```js
      // vue.config.js
      const { defineConfig } = require('@vue/cli-service')
      module.exports = defineConfig({
        devServer: {
          proxy: {        // 配置跨域, 开启一个代理服务
            '/api': {     // 代理服务的地址: /api
              target:'http://192.168.52.21:8001', // 真正的后台地址
              changOrigin: true,    // 同意跨域
              pathRewrite: {        // 重写url
                '/api':''
              }
            }
          }
        }
      })
      ```
  2. 配置url
      ```js
      const request = axios.create({
          baseURL: '/api',    //指向代理地址
          timeout: 5000
      });
      ```

### 4. 重中之重
- 跨域是后端要配置的
- 前端只能是伪跨域
- 发布的时候 baseURL 要切换为真正的后台地址

