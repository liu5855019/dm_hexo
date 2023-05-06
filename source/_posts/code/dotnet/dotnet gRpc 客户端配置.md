---
title: dotnet gRpc 客户端配置
updated: 2023-05-05 06:33:17Z
created: 2023-05-05 06:33:01Z
---

# 1. 包依赖 (使用 nuget 安装)

Grpc.AspNetCore

# 2. 复制 proto 文件

# 3. 在项目文件中加入:
```
<ItemGroup>
	<Protobuf Include="Protos\greet.proto" GrpcServices="Client"/>
</ItemGroup>
``` 