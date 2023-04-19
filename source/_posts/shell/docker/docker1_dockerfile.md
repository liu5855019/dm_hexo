---
title: docker -- 1. Dockerfile
date: 2023-04-07 11:09:18
tags: [docker, dockerfile]
categories: [docker]
wordcount: 100
---

### 作用
- Dockerfile 是用来构建镜像的
- Dockerfile 里的每一行, build 的时候都会对应一个 image





### 调试
- 思路
  - dockerfile 里的每一行, build 的时候都会对应一个 image
  - 一个image可以使用 docker create 命令创建一个 container
  - 然后使用 docker export 命令将 container 导出为压缩包
  - 解压即可看到image对应的文件

```bash

docker build . -t image1

docker create --name pack1 image1

docker export pack1 > pack1.tar

```

### COPY 命令使用
1. copy: 从本地路径 copy 到 image 内部
    ```Dockerfile
    # 设置 image 工作目录为 /src
    WORKDIR /src

    # 第一个. : 本地 Dockerfile 所在路径
    # 第二个. : image内 /src
    # 类似于linux: copy ./* /src
    COPY . .
    ``` 
2. copy 只能访问到 Dockerfile 所在目录, 所以:
   - 只能是 COPY . .
   - 不能 COPY .. .
3. 路径说明
    ```Dockerfile
    # Dockerfile 初始本地路径
    # /root/github/dir1/Dockerfile
    # /root/github/dir1/***.sln
    # /root/github/dir1/DM.Log.Service/***.scproj

    WORKDIR /src
    COPY . .

    # 此时, image内路径为:
    # /src/Dockerfile
    # /src/***.sln
    # /src/DM.Log.Service/***.

    # 即: /root/github/dir1/ == /src/

    WORKDIR "/src/DM.Log.Service/."
    ```
4. copy image 内部文件
    ```Dockerfile
    FROM build AS publish
    WORKDIR /app

    # --from=publish : 设置从 publish image进行copy
    # /app/publish : image 内部的路径 /app/publish
    # . : image内部WORKDIR所在路径, /app
    COPY --from=publish /app/publish .
    ```

### 示例

```Dockerfile
#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .
WORKDIR "/src/DM.Log.Service/."

RUN dotnet restore "./DM.Log.Service.csproj"
RUN dotnet build "./DM.Log.Service.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "./DM.Log.Service.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DM.Log.Service.dll"]
```




