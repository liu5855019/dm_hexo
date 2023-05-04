---
title: vue1 -- vue cli create project
updated: 2023-01-30 13:18:55Z
created: 2023-01-30 13:18:55Z
tags:
  - vue
  - vue_cli
---

### 1. install
```shell
#  初始化项目依赖文件
npm init -y 

# 安装脚手架
cnpm i -D @vue/cli

# 查看vuecli版本
npx vue -V

# 创建项目 貌似只能小写
npx vue create project-one

```

- 安装 cnpm
> npm install -g cnpm --registry=https://registry.npm.taobao.org



### 2. config vue.config.js

```js
const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    open: true,
    host: "localhost"
  }
})
```

