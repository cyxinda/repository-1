# 1. 登录到MySQL服务器
# 2. 使用以下命令更改root用户的主机限制，将其更改为“%”
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'mypassword';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'mypassword';
#3. 授予root用户远程访问数据库的权限
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
flush privileges;
#4. 重启mysql服务
