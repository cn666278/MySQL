# MySQL安装建议：  
## 方法1:
1. [b站MySQL3小时入门教程](https://www.bilibili.com/video/BV1PT4y1e7UU?spm_id_from=333.337.search-card.all.click&vd_source=4a72f95e2a1694bfd8c010db6a72530d)  
> PS.视频开头附带了安装过程以及安装链接(.msi文件安装)，但是可能会由于多次安装或者各种系统问题导致安装失败，可以参考方法2.  
  
  
## 方法2：  

2. [Mysql下载安装和配置方法(看了必成功)](https://www.bilibili.com/video/BV1EJ411p7Ty?spm_id_from=333.788.top_right_bar_window_history.content.click)    
> PS.安装包下载法，并且非常详细的介绍了环境变量等配置  
[图形化管理工具MySQL workbench](https://dev.mysql.com/downloads/workbench/)    

**视频文字概况：**  

第一步：去官网下载安装 [mysql.com](https://dev.mysql.com/downloads/)   

第二步：先解压，然后在mysql下创建一个my.ini文件，更改my.ini文件里面的前两行安装目录（详细可见项目中文件my.ini），  
第二行加上\data，my.ini文件不能多一个符号或者少一个符号，在path（环境变量里面）加上mysql路径（E:\mysql\mysql-8.0.25-winx64\bin）(填写自己的mysql安装路径)  

第三步：进入命令指示符（管理员模式下运行cmd）,  
输入mysqld --initialize-insecure --user=mysql,初始化数据库，并设置默认root为空，初始化完成后，在mysql根目录中会自动生成data文件  
再输入mysqld -install,为windows安装mysql服务，默认服务名为mysql  
出现service successfully installed.表示配置完成  
启动数据库net start mysql,  
输入mysql -u root -p ,不用输入密码直接回车  
出现mysql>配置完成  
输入(alter user user() identified by "密码";)  
mysql退出 mysql>quit;  
输入net stop mysql关闭数据库  

PS.
1. 使用方法2安装好MySQL server之后，需要去MySQL workbench修改server设置  
如图：  

<img src="https://github.com/cn666278/MySQL/blob/main/MySQL%E9%85%8D%E7%BD%AE.jpg" width="80%">

2. 设置完成后点击test connection，显示链接正常即可

3. 在终端（cmd）输入指令启动数据库 **(!如果显示error请用管理员模式打开cmd)**    
> net start mysql

4. 返回 MySQL workbench 主页（注意一定要返回），重新点击local instance，并且输入密码，即可完成MySQL 的启动  

5. 关闭数据库  
> net stop mysql
