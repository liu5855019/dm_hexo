---
title: dotnet Attribute
updated: 2023-05-05 06:37:15Z
created: 2023-05-05 06:37:09Z
---

```
        // 只有在 debug 模式下才运行
        [Conditional("DEBUG")]
        public void newFunc()
        {
            Console.WriteLine("new func");
        }
        
        // 当调用 oldFunc 的时候会报警告已弃用
        [Obsolete("This is old func, please use new func")]
        // 同上
        [Obsolete("This is old func, please use new func",false)]
        // 当调用的时候直接报错误
        [Obsolete("This is old func, please use new func",true)]
        public void oldFunc()
        {
            Console.WriteLine("old func");
        }
```

### 下面这篇文章写得非常好, 我就不再写了
### [好文在此1](https://www.cnblogs.com/ghfsusan/archive/2009/07/15/1524192.html)
### [好文在此2](https://www.cnblogs.com/jiangxifanzhouyudu/p/11107734.html)

