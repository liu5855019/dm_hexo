---
title: Create Hexo
date: 2022-09-19 22:34:05
tags: hexo
---

# 初始化项目

- 找个文件夹
```shell
hexo init
```

# 使用 vexo theme
- theme 地址: [Vexo](https://github.com/yanm1ng/hexo-theme-vexo)


1. Download/Checkout this theme into your project

   ```
   cd your-hexo-folder

   git clone https://github.com/yanm1ng/hexo-theme-vexo.git themes/vexo

   cp -R themes/vexo/_source/* source/
   ```

2. Update project `_config.yml` theme config, look like this

   ```
   themes: vexo
   ```

   Here theme's name must same as the theme folder name.

3. Modify theme `themes/vexo/_config.yml` with your own info.

# 创建新文章

```
hexo new "title"
```

