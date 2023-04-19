---
title: sql -- cursor
date: 2023-02-08 14:59:06
tags: [sql, cursor]
---

### open_cursor

- 查看所有游标
```sql
SELECT * FROM v$open_cursor ORDER BY LAST_SQL_ACTIVE_TIME DESC 
```

- 查看游标 sql_text 执行次数
```sql
SELECT SQL_TEXT, COUNT(SQL_TEXT) times FROM  v$open_cursor  
GROUP BY SQL_TEXT
ORDER BY times DESC 
```


- FIND WHICH SESSION IN USING MORE CURSORS.
```sql
SELECT sid,user_name, COUNT(*) "Cursors per session"
FROM v$open_cursor where user_name not like 'SYS'
GROUP BY sid,user_name
ORDER BY "Cursors per session" DESC;
```


- Find which SQL is using more cursors
```sql
select sid, sql_id ,sql_text, count(*) as "OPEN CURSORS", USER_NAME 
from v$open_cursor
--where sid in ('&SID') 
GROUP BY SID,SQL_TEXT,USER_NAME,sql_id
ORDER BY "OPEN CURSORS" DESC;
```


- 游标最大数
```sql
select p.value as max_open_cur
from v$sesstat a, v$statname b, v$parameter p
where a.statistic# = b.statistic#
and b.name = 'opened cursors current'
and p.name= 'open_cursors'
group by p.value;
```