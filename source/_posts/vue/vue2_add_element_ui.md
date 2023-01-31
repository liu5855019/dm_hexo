---
title: vue2 -- add element ui
date: 2023-01-31 17:27:23
tags: [vue, element_ui]
categroies: [vue]
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
