---
title: vue2 -- add element ui / plus
updated: 2023-01-31 09:27:23Z
created: 2023-01-31 09:27:23Z
tags:
  - element_ui
  - vue
---

### 1. install
npm 安装
```shell
npm i element-ui -S
```

### 2. 完整引入

```js
import Vue from 'vue'
import App from './App.vue'

import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

Vue.use(ElementUI)

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
}).$mount('#app')

```

### 3. use
```html
<template>
  <div class="hello">
    <h1>hello</h1>
    <el-button>hello</el-button>
    <el-button type="primary">primary</el-button>
    <el-button type="info"> info </el-button>
    <el-button type="danger">danger</el-button>
    <el-button type="success">success</el-button>
  </div>
</template>

```

### 4. vue3 用的是 element plus

- 官网 [https://element-plus.gitee.io/zh-CN/](https://element-plus.gitee.io/zh-CN/)

- 安装
  ```bash
  npm install element-plus --save
  ```
- 使用
  - main.ts
      ```ts
        import { createApp } from 'vue'
        import ElementPlus from 'element-plus'
        import 'element-plus/dist/index.css'
        import App from './App.vue'

        const app = createApp(App)

        app.use(ElementPlus)
        app.mount('#app')
      ```
- 使用 icon, 需要安装与引用
  地址: [https://element-plus.gitee.io/zh-CN/component/icon.html](https://element-plus.gitee.io/zh-CN/component/icon.html)