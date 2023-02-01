---
title: vue3 -- add add sass
date: 2023-02-01 10:13:01
tags: [vue, sass]
categroies: [vue]
---

### 1. install
npm 安装
```shell
npm i node-sass sass-loader -D
```

### 2. 此处安装可能出问题, 用下面方法可能能解决
- 管理员身份运行 powershell
```shell
npm install --global --producttion windows-build-tools
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

<style lang="scss">
.hello{
  background: yellow;
  .el-button{
    color: red;
  }
}
</style>

```

### 4. reset.css
- 在 src>assets>css 下创建reset.css文件
- 粘贴下面内容
```html
/* http://meyerweb.com/eric/tools/css/reset/ 
   v2.0 | 20110126
   License: none (public domain)
*/

html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
	font: inherit;
	vertical-align: baseline;
}
/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure, 
footer, header, hgroup, menu, nav, section {
	display: block;
}
body {
	line-height: 1;
}
ol, ul {
	list-style: none;
}
blockquote, q {
	quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
	content: '';
	content: none;
}
table {
	border-collapse: collapse;
	border-spacing: 0;
}
```
- 在 App.vue 文件里 < style> 第一行加 @import
```html
<style lang="scss">
@import url('./assets/css/reset.css');
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /* margin-top: 60px; */
}
```
