---
title: dotnet EF Code First 数据库同步
updated: 2023-05-05 06:36:11Z
created: 2023-05-05 06:35:53Z
---

DBContext 所需包:
```
Microsoft.EntityFrameworkCore
Microsoft.EntityFrameworkCore.Design
Microsoft.EntityFrameworkCore.SqlServer
Microsoft.EntityFrameworkCore.Tools
```

program 所需包:
```
Microsoft.EntityFrameworkCore.Design
```

### 1. 写好 DBContext
  * 配置 ConnectionString
  * 配置 DbSet<>
```
    public class DaimuDbContext : DbContext
    {
        public readonly string connectionString;

        public DaimuDbContext() : this(null) { }
            
        public DaimuDbContext(string ConnectionString)
        {
            if (ConnectionString == null ||
                ConnectionString.Length == 0)
            {
                //Configuration 
                connectionString = "ConnectionString";
            }
            else
            {
                connectionString = ConnectionString;
            }
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (optionsBuilder != null)
            {
                optionsBuilder.UseSqlServer(connectionString);
            }
        }

        public DbSet<UserInfo> UserInfo { get; set; }

        public DbSet<OrderInfo> OrderInfo { get; set; }
    }
```
### 2. 在 Startup 中注入

```
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddGrpc();
            services.AddDbContext<DaimuDbContext>();
        }
```

### 3. 打开 NuGet 命令行 , 并选择 DBContext 文件所在目录
### 4. 输入命令 , 生成 migration 文件
```
add-migration  <<#name#>>
```
### 5. 输入命令, 同步到数据库
```
update-database  <<#name#>>
```