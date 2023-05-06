---
title: dotnet Guid to 16进制字符串
updated: 2023-05-05 06:38:08Z
created: 2023-05-05 06:37:58Z
---

```
Guid guid = Guid.NewGuid();
var id = BitConverter.ToString(guid.ToByteArray()).Replace("-", "");
Console.WriteLine(id);
```