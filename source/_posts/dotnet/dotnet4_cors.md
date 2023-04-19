---
title: dotnet -- 4. set 跨域 Cors
date: 2022-09-21 11:58:12
tags: [dotnet, .netcore]
categories: [dotnet]
---

### .netcore cors
1. 配置跨域是后端职责所在

2. 核心代码如下:
    ```csharp
      // 从 appsetting 获取跨域列表
      var hostList = configuration.GetSection("Cors").GetChildren().Select(w => w.Value).ToArray();
      services.AddCors(setupAction =>
      {
          // 配置跨域规则
          setupAction.AddPolicy("cors", setupAction =>
          {
              //setupAction.AllowAnyOrigin();
              setupAction.AllowAnyHeader();
              setupAction.AllowAnyMethod();
              setupAction.AllowCredentials().WithOrigins(hostList);
          });
      });

      // 使用跨域中间件
      app.UseCors("cors");
    ```

3. 辅助代码
    1. appsetting.json
    ```json
    {
      "Logging": {
        "LogLevel": {
          "Default": "Information",
          "Microsoft.AspNetCore": "Warning"
        }
      },
      "Cors": [
        "http://localhost:5000",
        "http://192.168.52.21:5000"
      ]
    }
    ```
    2. configuration, services, app
    ```csharp
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            var services = builder.Services;
            var configuration = builder.Configuration;

            var app = builder.Build();
            app.Run();
        }
    }
    ```
