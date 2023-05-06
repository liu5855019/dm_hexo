---
title: dotnet -- 5. 中间件 Middleware
updated: 2023-05-05 09:23:59Z
created: 2022-09-21 03:58:12Z
tags:
  - .netcore
  - dotnet
---

### 概念
- 地址: https://learn.microsoft.com/zh-cn/aspnet/core/fundamentals/middleware/?view=aspnetcore-7.0



### 常用中间件

1. 异常/错误处理
	  - 当应用在开发环境中运行时：
		- 开发人员异常页中间件 (UseDeveloperExceptionPage) 报告应用运行时错误。
		- 数据库错误页中间件 (UseDatabaseErrorPage) 报告数据库运行时错误。
	  - 当应用在生产环境中运行时：
		- 异常处理程序中间件 (UseExceptionHandler) 捕获以下中间件中引发的异常。
		- HTTP 严格传输安全协议 (HSTS) 中间件 (UseHsts) 添加 Strict-Transport-Security 标头。
2. HTTPS 重定向中间件 (UseHttpsRedirection) 将 HTTP 请求重定向到 HTTPS。
3. 静态文件中间件 (UseStaticFiles) 返回静态文件，并简化进一步请求处理。
4. Cookie 策略中间件 (UseCookiePolicy) 使应用符合欧盟一般数据保护条例 (GDPR) 规定。
5. 用于路由请求的路由中间件 (UseRouting)。
6. 身份验证中间件 (UseAuthentication) 尝试对用户进行身份验证，然后才会允许用户访问安全资源。
7. 用于授权用户访问安全资源的授权中间件 (UseAuthorization)。
8. 会话中间件 (UseSession) 建立和维护会话状态。 如果应用使用会话状态，请在 Cookie 策略中间件之后和 MVC 中间件之前调用会话中间件。
9. 用于将 Razor Pages 终结点添加到请求管道的终结点路由中间件（带有 MapRazorPages 的 UseEndpoints）。
```csharp
  if (env.IsDevelopment())
  {
      app.UseDeveloperExceptionPage();
      app.UseDatabaseErrorPage();
  }
  else
  {
      app.UseExceptionHandler("/Error");
      app.UseHsts();
  }
  app.UseHttpsRedirection();
  app.UseStaticFiles();
  app.UseCookiePolicy();
  app.UseRouting();
  app.UseAuthentication();
  app.UseAuthorization();
  app.UseSession();
  app.MapRazorPages();
```
