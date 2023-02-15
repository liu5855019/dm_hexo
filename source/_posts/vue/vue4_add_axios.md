---
title: vue5 -- add axios
date: 2023-02-10 16:12:20
tags: [vue, axios]
categroies: [vue]
---

### 1. axios
- axios 是用来网络请求的

### 2. 安装
```
  npm install --save axios
```

### 3. 使用axios / 封装
- request.ts
```ts
// request.ts

// 导入
import axios  from "axios";
// import * as tools from './tools';

// 创建实例
const request = axios.create({
    // baseURL: '/api',
    baseURL: 'https://localhost:6001',
    timeout: 5000
});

// 请求拦截器
request.interceptors.request.use((config) => {
    config.headers["x-requestid"] = tools.Random(99999, 9999999);
    return config;
}, (error) => {
    return Promise.reject(error);
});

// 返回拦截器
request.interceptors.response.use((response) => {
    if (response.status == 200) {
        // todo
    }
    return response;
}, (error) => {
    return Promise.reject(error);
});

// 导出接口方法
export function LogDotaGetDeviceList() {
    return request({
        url: "/LogDota/GetDeviceList",
        method: "GET"
    })
}
```
- tools.ts (非必要)
```ts
// tools.ts

export function Random(min: number, max: number ) {
    return Math.floor(Math.random() * (max - min)) + min;
}
```

### 4.使用 request.ts

```ts
<script lang="ts">

import { defineComponent } from 'vue';
import * as request from "@/assets/common/request";

export default defineComponent({
    created() {
        request.LogDotaGetDeviceList()
        .then(res => {
            console.log(res);
        })
        .catch(err => {
            console.error(err);
        })
    }
})

</script>
```



