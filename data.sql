PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE "categories" (
  "id" int(11) NOT NULL ,
  "name" varchar(50) NOT NULL,
  "slug" varchar(75) NOT NULL,
  "entryNum" int(11) NOT NULL,
  "createdTime" datetime DEFAULT NULL,
  "modifiedTime" datetime DEFAULT NULL,
  PRIMARY KEY ("id")
);
INSERT INTO "categories" VALUES(1,'未分类','uncategoried',0,NULL,NULL);
INSERT INTO "categories" VALUES(2,'Python','python',1,NULL,NULL);
INSERT INTO "categories" VALUES(3,'PHP','php',1,NULL,NULL);
INSERT INTO "categories" VALUES(4,'PHP','php',0,NULL,NULL);
INSERT INTO "categories" VALUES(5,'JavaScript','javascript',0,NULL,NULL);
INSERT INTO "categories" VALUES(6,'Linux','linux',0,NULL,NULL);
INSERT INTO "categories" VALUES(7,'VIM','vim',0,NULL,NULL);
INSERT INTO "categories" VALUES(8,'数据库配置','database-config',0,NULL,NULL);
INSERT INTO "categories" VALUES(9,'服务器配置','server-config',0,NULL,NULL);
CREATE TABLE "comments" (
  "id" int(11) NOT NULL ,
  "entryId" int(11) NOT NULL,
  "email" varchar(50) NOT NULL,
  "username" varchar(50) NOT NULL,
  "url" varchar(255) DEFAULT NULL,
  "comment" text,
  "createdTime" datetime DEFAULT NULL,
  PRIMARY KEY ("id")
);
INSERT INTO "comments" VALUES(1,3,'mykingheaven@gmail.com','abcabc','#','测试留言','2009-12-09 01:37:00');
CREATE TABLE "entries" (
  "id" int(11) NOT NULL ,
  "title" varchar(255) NOT NULL,
  "slug" varchar(255) DEFAULT NULL,
  "content" text,
  "categoryId" int(11) NOT NULL,
  "createdTime" datetime NOT NULL,
  "modifiedTime" datetime NOT NULL,
  "viewNum" int(11) DEFAULT '0',
  "commentNum" int(11) DEFAULT '0',
  PRIMARY KEY ("id")
);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(1,'使用jQuery创建可拖拽排序列表','jquery-drag-and-drop','项目中需要用到拖拽排序,于是去研究了jQuery的UI,发现它提供了一种非常简单的方式来实现可视化排序.
首先是html代码:
<pre lang="html">
<ul id="test">
 <li>first</li>
 <li>second</li>
 <li>third</li>
</ul>
<input id="test-button" type="button">
<input id="show" type="text">
</pre>
然后在script中导入jQuery,ui.core和ui.sortable3个包:
<pre lang="html">
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="ui.core.js"></script>
<script type="text/javascript" src="ui.sortable.js"></script>
</pre>
对应的javascript脚本为:
<pre lang="javascript">
$(document).ready(function(){
 $(''#test'').sortable({
 items:''li''
 });
 $(''#test-button'').click(function(){
 $(''#show'').attr(''value'',$(''#test'').sortable(''toArray''));
 });
});
</pre>
对上述代码的解释:
要排序的东西放在ul里,用sortable()来使列表可排序,items指出要排序的元素,使用sortable(''toArray'')来获得当前的排序结果.',1,'2009-03-19 09:42:57','2009-03-19 09:42:57',2,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum) VALUES(2,'打造顺手的Vim环境','useful-vim-env','Vim超强的定制性为我们提供了很多便利，它众多的插件更是加速了我们的开发速度，下面就列出了笔者常用的几个插件：

1.Nerd Tree -- 将目录和文件以树的形式显示在编辑器的左侧
2.Taglist -- 快速定位程序的变量,函数和类,方便查找和修改
3.Nerd Commenter -- 快速对代码进行注释,方便调试
4.SnippetsEmu -- 提供TextMate般的快速代码片段录入
<!--more-->
下载地址为:
1.<a href="http://www.vim.org/scripts/script.php?script_id=1658">NerdTree</a>
2.<a href="http://www.vim.org/scripts/script.php?script_id=273">Taglist</a>
3.<a href="http://www.vim.org/scripts/script.php?script_id=1218">Nerd Commenter</a>
4.<a href="http://www.vim.org/scripts/script.php?script_id=1318">SnippetsEmu</a>

安装方法非常的简单:
1.前3个插件只要将下载下来的压缩包解压,然后将plugin目录里的文件放入~/.vim/plugin/目录,将doc目录的文件放入~/.vim/doc/目录即可,安装taglist的前提是系统必须安装有excuberant-ctags程序(Ubuntu和Debian用户可以从新立得里安装此程序,其它linux请搜索其安装方法).
2.SnippetsEmu插件的安装稍微有点繁琐,方法为:将下载下来的压缩包解压,会得到2个.vba文件,分别用vim打开这2个文件,然后输入命令'':so %''进行安装即可.

对插件的设置请参考上一篇日志:<a href="http://davidshieh.cn/index.php/2009/03/13/vim配置/">个人的vim配置</a>',1,'2009-03-19 10:02:35','2009-03-19 10:02:35',2,0);
INSERT INTO "entries"(id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum) VALUES(3,'PHP中的日期处理','PHP中的日期处理','在PHP中处理日期非常的简单,尽管Mysql中有DateTime字段,但是使用起来还有没有PHP的time()函数方便.在数据库设计的时候,把存储时间的字段设置为int(11),存储数据的时候,该字段的数据为time()即可.time()函数的作用就是产生当前时间的时间戳,一般为一个11位的数字,例如1235035834.

在我们要显示时间的时候,显示该时间戳自然不行,PHP里提供了date()函数来格式化该时间戳,比如我们使用date("Y-m-d H:i:s",1235035834)即可得到该时间戳的日期和时间,这里为"2009-02-19 17:30:34",非常的方便.date()函数接受2个参数,第一个为日期的格式,有很多参数来控制显示的格式,"Y"表示4位数的年,"m"表示2位数的月份,"d"表示2位数的天,"H"表示24小时制的小时,"i"表示分钟,"s"表示秒数,需要更多的格式,可以查阅官网的说明 &nbsp;:&nbsp; <a href="http://cn2.php.net/manual/en/function.date.php">Date函数</a>

<span style="color: #ff0000;"><strong>还有一个函数strftime()也可以做日期的格式化,这2个函数的区别就是,部分的linux和所有的windows都不支持该函数,就是说,只有部分的linux可以使用该函数,所以,如果要写跨平台的PHP代码,还是要使用date()函数.</strong></span>',1,'2009-03-19 10:16:50','2009-03-19 10:16:50',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(4,'Apache基于端口的虚拟机的配置','Apache基于端口的虚拟机的配置','修改httpd.conf文件,加入以下代码:

<pre lang="conf">
#监听88端口
Listen 88
#虚拟机的配置
<virtualHost *:88>
 ServerAdmin webmaster@localhost
 DocumentRoot /home/icefox/phpmyadmin/ #该虚拟机的目录
 <directory /home/icefox/phpmyadmin/> #该目录的配置
 Options FollowSymLinks
 AllowOverride All #开启地址重写
 Order allow,deny #设置访问规则
 allow from all
 </directory>
 ErrorLog /var/log/apache2/error.log #设置改虚拟机的错误日志文件的存放地址
</virtualHost>
</pre>

修改完一定要重启apache使新配置生效.',1,'2009-03-19 10:24:52','2009-03-19 10:24:52',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(5,'使用PIL按比例做缩略图','使用PIL按比例做缩略图','项目中遇到头像的制作~这里使用的方法会不失比例的缩放图片~代码:
<pre lang="python">
im = Image.open(''ceshi.jpg'')
size = im.size
if size[0] > size[1]:
 rate = float(120) / float(size[0])
else:
 rate = float(90) / float(size[1])
new_size = (int(size[0] * rate), int(size[1] * rate))
new = im.resize(new_size, Image.BILINEAR)
new.save(''new.jpg'')
</pre>
唯一值得注意的地方算比例的时候,一定记得加float,不然算出来的比例会是0,然后就是算生成的缩略图大小的时候,要用int,这样算出来的大小才会是整数.',1,'2009-03-22 23:34:47','2009-03-22 23:34:47',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(6,'Yii拾遗(陆续添加中)','yYii拾遗(陆续添加中)','<strong>1.View中的语法.</strong>
Yii在view里使用自己的语法,常用的是if语句和foreach语句,跟php的语法非常相似.if的语法为:
<pre lang="PHP">
<?php if ($foo): ?>
 <?php echo $foo; ?>
<?php elseif ($bar): ?>
 <?php echo $bar; ?>
<?php else: ?>
 <?php echo "nothing..."; ?>
<?php endif; ?>
</pre>
foreach的语法为:
<pre lang="PHP">
<?php foreach ($ones as $key => $value): ?>
 <?php echo "key is ".$key " ---- ."value is ".$value; ?>
<?php endforeach; ?>
</pre>
基本和php的语法相同,只是这里没有大括号,全部由'':''来代替,结束的时候使用end.

<strong>2.Model的关系定义.</strong>
在Model里,可以定义该Model和其它model的关系,比如说,belongs_to和has_many等.在Model加入relations()方法或者修改西安曾的relations()方法,下面给出一个例子:
<pre lang="PHP">
<?php
public function relations() {
 return array(
 ''topicCount'' => array(self::STAT, ''TClubTopic'', ''_club''),
 ''creator''=>array(self::BELONGS_TO, ''TUser'', ''_creator''),
 ''topics'' => array(self::HAS_MANY, ''TClubTopic'', ''_club''),
 );
}
?>
</pre>
topicCount和creator定义的是返回对象的别名.
self::STAT定义的是关联表的记录数,相当于一个count.self::BELONGS_TO定义的是1对1的关系,比如说,日志跟用户的关系,一个日志对应一个用户.self::HAS_MANY定义的是多对多的关系,一个用户可能有很多的日志,他跟日志的关系就是多对多了.
TClubTopic和TUser是关联的Model名字,_club和_creator关联Model的外键.

<strong>3.指定Model链接的表名.</strong>
有时需要让Model指向的表名和Model的名字不一样,可以定义以下的一个方法:
<pre lang="PHP">
public function tableName() {
 return ''foo_bar'';
}
</pre>',1,'2009-03-25 17:12:08','2009-03-25 17:12:08',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(7,'U盘安装ArchLinux-200902-x86_64','U盘安装ArchLinux-200902-x86_64','ArchLinux的200902版放出来有一段时间了，最近决定升级系统为64位的，并且可以尝试下EXT4的文件系统。由于没有刻录机，ArchLinux对硬盘安装的支持又不好～所以决定用U盘来安装。

<strong>准备工作：</strong>
下载archlinux-200902-core-x86_64.img,并在linux用dd将镜像写入U盘，命令为：
dd if=/path/to/archlinux-200902-core-x86_64.img of=/dev/sdb
一般U盘的位置为/dev/sdb，如果以上命令有错误的话，建议查看下U盘的位置并修改上面的命令。

<strong>引导计算机：</strong>
修改CMOS的设置，将USB－ZIP的启动放在硬盘的前面，并修改硬盘的启动顺序，将U盘放在本机硬盘的前面，然后重启计算机即可。
<!--more-->
<strong>安装Arch：</strong>
由于机器本身已经有linux分区，所以不需要对硬盘进行分区，只需要选择挂载点即可，由于200902支持ext4，这里的分区类型当然要选择ext4了。设置结束后，进行包选择。本机使用的是无线上网，所以在base的基础上，还要选择相应的无线网卡模块和iwconfig包以确保无线的使用，本人使用的无线模块是rt71w。其它的设置和之前的arch没有什么区别了，locale的选择上，en只需要选择utf-8即可，中文需要选择gdk,utf-8和gb2312，GB10830没有特殊需求的话，就不用选择了。安装完成后重新启动计算机即可进入base system了。

<strong>升级系统：</strong>
Arch的更新非常快 ，所以安装完系统以后需要进行一次升级。先使用pacman -Sy跟源进行同步，然后使用pacman -Suv进行升级。

<strong>安装桌面系统：</strong>
装桌面前，我们需要创建一个自己的用户。很多人喜欢开着root跑，但是我不推荐这样做，使用自己的帐户可以避免自己的误操作给系统带来麻烦。建立新用户并设置用户的密码，命令为：
useradd -m -s /bin/bash <em>username</em>
passwd <em>username</em>
上面的username为要设置的用户名。gnome桌面默认是不允许以root登录的，所以切记要在桌面装好前建立自己的用户。
要装桌面首先要装xorg,这是所有桌面系统的基础，命令为:
pacman -S xorg hwd
装好xorg后使用hwd -x生成xorg.conf配置文件，这个命令会生成xorg.conf.vesa文件，将这个文件改名为xorg.cong即可。
接下来就是gnome的安装了，命令为：
pacman -S gnome gdm gnome-terminal
gdm是gnome使用的登录器，gnome-terminal是gnome下的一个终端模拟器。
xorg加上gnome，大概有270M，网速150K的话，大概需要将近1个小时的时间，我就打了一个小时的街霸，嘿嘿。
安装完成后，使用pacman -S nvidia-173xx来安装显卡的驱动，本人所用的是nvidia 9600GSO的显卡，ATI显卡驱动的安装请查阅archlinux的wiki。装好驱动后，修改xorg.conf，将里面的Load "type1"去掉，然后将Driver里的vesa改成nvidia，保存退出即可。修改/etc/inittab文件，将boot to console里的3改成5，意思是系统启动后引导到Xorg，再将xdm的这一行注释掉，将gdm这一行的注释去掉，意思是使用gdm作为登录管理器。最后使用reboot重新启动计算机，就会看到熟悉的gnome登录界面了。',1,'2009-03-27 22:21:10','2009-03-27 22:21:10',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(8,'Archlinux系统配置和优化','Archlinux系统配置和优化','Arch默认的配置非常简单，我们需要修改和优化它，以使它可以更好的供我们使用。
下面的所有配置都是建立在gnome桌面系统上，所有的命令都是以root身份执行的，如果不想用root登录，可以在命令前加sudo。

<strong>一、字体的优化</strong>
Arch自带的字体非常的难看，中文字体更是难看之极，所以我们需要安装一些好看的字体来美化我们的系统。使用下面的命令安装所有需要的字体：
pacman -S ttf-arphic-uming ttf-arphic-ukai wqy-zenhei wqy-bitmapfont ttf-dejavu ms-fonts
安装完成后，需要修改/etc/fonts/conf.d/44-wqy-zenhei.conf以打开embeddedbitmap, 将里面name="embeddedbitmap"的值false改成true。
<!--more-->
<strong>二、桌面的美化</strong>
Arch自带的主题比较少～我们可以自行安装一些其它主题以我们的系统更加美观。使用下面的命令安装主题：
pacman -S gtk-engine-murrine gtk2-themes-collection gtk-aurora-engine gtk-candido-engine gtk-rezlooks-engine
安装完成即可以在外观里选择喜欢的主题了。

<strong>三、安装网络管理器</strong>
Arch本身并不带网络管理器，只是使用系统配置来登录网络，如果只用的是无线网络的话，每次都手动连接网络的话，非常的麻烦，这个时候，就需要安装网络管理器了。使用下面的命令来安装网络管理器：
pacman -S gnome-network-manager
安装完成后，修改/etc/rc.conf文件，将里面的INTERFACES里装载的模块都点掉，只留下lo，改成以下的样子，INTERFACES=(lo !eth0 !ath0)。然后禁掉系统本身的network选项，并开启hal，dhcdbd和networkmanager3个进程，将DAEMONS里的东西改成以下这样：DAEMONS=( ... !network hal dhcdbd networkmanager networkmanager-dispatcher ... )。修改完成后，我们要继续修改/etc/pam.d/gdm文件，以确保netwokrmanager可以顺利修改机器的网络配置，确保这个文件里有以下2行：
auth optional pam_gnome_keyring.so
session optional pam_gnome_keyring.so auto_start
然后修改/etc/pam.d/passwd文件，加入这行：
password optional pam_gnome_keyring.so
这一步做完后，将自己加入network这个用户组里，命令为gpasswd -a <em>USERNAME</em> network。完成后启动计算机即可。

<strong>四、安装声卡</strong>
Arch的内核已经带有声卡的驱动，我们需要用以下的命令来安装声卡必须的库，命令为：
pacman -S alsa-lib alsa-utils alsa-oss
安装完成后，需要修改/etc/modprobe.conf以确保最后读取snd_pcsp模块，在该文件里加入如下内容：
options snd-pcsp index=2
完成后使用gpasswd -a <em>USERNAME</em> audio将自己加入audio用户组。重新启动计算机即可生效。

<strong>五、配置HAL自动挂载</strong>
Linux以前的挂载都是用mount命令，虽然非常的简单，但是如果经常要用别的分区的话，也是很麻烦的事情。所以我们需要配置HAL以实现自动挂载分区和移动硬盘。首先使用下面的命令以确保你没有漏安装包：
pacman -S hal dbus pmount ntfs-3g
然后修改/etc/rc.conf文件，在DAEMONS里加入hal，例如DAEMONS=(syslog-ng hal network ...)。然后使用如下命令将自己加入到用户组里：
gpasswd -a <em>USERNAME</em> optical
gpasswd -a <em>USERNAME</em> storage
接下来创建/etc/hal/fdi/policy/20-ntfs-config-write-policy.fdi文件，在里面写上如下的内容：
<pre lang="XML">
<?xml version="1.0" encoding="UTF-8"?>
<deviceinfo version="0.2">
 <device>
 <match key="volume.fstype" string="ntfs">
 <match key="@block.storage_device:storage.hotpluggable" bool="true">
 <merge key="volume.fstype" type="string">ntfs-3g</merge>
 <merge key="volume.policy.mount_filesystem" type="string">ntfs-3g</merge>
 <append key="volume.mount.valid_options" type="strlist">locale=</append>
 </match>
 </match>
 </device>
</deviceinfo>
</pre>
接着修改/etc/PolicyKit/PolicyKit.conf，以改变挂载的权限，在里面加入如下内容：
<pre lang="XML">
 <match user="USERNAME"> <!-- replace with your login or delete the line if you want to allow all users to manipulate devices (keep security issues in mind though) -->
 <match action="org.freedesktop.hal.storage.*">
 <return result="yes"/>
 </match>
 <match action="hal-storage-mount-fixed-extra-options"> <!-- for internal devices mounted with extra options like a wished mount point -->
 <return result="yes" />
 </match>
 <match action="hal-storage-mount-removable-extra-options"> <!-- for external devices mounted with extra options like a wished mount point -->
 <return result="yes" />
 </match>
 </match> <!-- don''t forget to delete this line if you deleted the first one -->
</pre>
将里面的USERNAME改成你的用户名即可。重新启动X使配置失效。

<strong>六、安装mplayer</strong>
Linux上比较好用的播放器就是mplayer了，Arch自然可以很轻松的安装和使用mplayer了，使用下面的命令安装mplayer，支持的编码和插件：
pacman -S mplayer codecs mplayer-plugin

<strong>七、安装必要的软件</strong>
Arch本身带的软件比较少，我们需要安装一些必要的软件以方便日常的使用，首先要安装的就是file-roller，这是对文件进行相应操作的工具，比如说，对文件进行压缩和解压缩，当然，使用它正确操作文件的话，需要安装相应的压缩和解压程序，安装命令为：
pacman -S file-roller unrar zip unzip',1,'2009-03-27 22:48:21','2009-03-27 22:48:21',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(9,'Arch使用Fcitx输入法','arch%e4%bd%bf%e7%94%a8fcitx%e8%be%93%e5%85%a5%e6%b3%95','之前一直使用的是SCIM的输入法,虽然有些别扭,但是也没有动过更换输入法的念头.最近受朋友鼓动,去尝试了下Fcitx,感觉还不错,附上安装和配置的过程.
首先使用sudo pacman -S fcitx安装输入法,然后修改~/.bashrc文件,加入如下内容:
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim
export XMODIFIERS="@im=fcitx"
保存后重新登录.
这时我们就可以使用fcitx &来启动输入法,希望以后每次登录自动启动输入法,可以将这句命令加入到会话中.
由于我们平常用的输入法都是使用,.来切换选词,所以我们可以修改~/.fcitx/conf/的文件来改变Fcitx切换选择的快捷键.',1,'2009-03-30 20:04:14','2009-03-30 20:04:14',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(10,'Arch配置Apache+Mysql+PHP','arch%e9%85%8d%e7%bd%aeapachemysqlphp','Arch上配置Apache+Mysql+PHP还是有些麻烦的,它跟其它的发行版有些许不同,下面我们就来一点一点的配置它们.

<strong>安装Apache+Mysql+PHP</strong>
使用命令pacman -S apache mysql php来安装3个软件.

<strong>配置Apache:</strong>
Apache的主要配置文件是/etc/httpd/conf/httpd.conf,我们在里面要去掉一些不使用的模块,以使apache跑的更轻松,以下模块都是可以不用的:
authnz_ldap_module, ldap_module, unique_id_module, proxy_module, proxy_connect_module, proxy_ftp_module, proxy_http_module, proxy_ajp_module, proxy_balancer_module, ssl_module, dav_module, cgi_module, cgid_module, dav_fs_module
修改DocumentRoot和&lt;Directory "/var/http"&gt;, 将里面的路径改成你的web根目录, 再去掉关于ssl和cgi的配置信息,并将Include conf/extra/httpd-userdir.conf行注释掉.在文件的最末尾加入如下2行使Apache启动时加载PHP5:
LoadModule php5_module modules/libphp5.so
Include conf/extra/php5_module.conf
最后,将http这个用户加入你的组,命令为gpasswd -a http <em>USERNAME</em>
启动apache的命令为sudo /etc/rc.d/httpd start.

<!--more-->
<strong>配置Mysql</strong>
Mysql的配置相对比较简单,使用sudo /etc/rc.d/mysqld start启动Mysql, 然后使用mysqladmin -u <strong>root</strong> -p password <em>root</em>来设置密码,注意,黑体的位置输入你要设置的用户名,斜体的是该用户名的密码,第一次使用这个命令会提示你输入root的密码,由于我们还没有密码,所以直接按回车即可.

<strong>配置PHP</strong>
PHP的配置比Apache要简单一些.第一步需要修改//etc/php/php.ini里面的open_basedir变量,确保里面有你的web根目录的路径.第二步修改加载的库,按照需要选择自己要用的库即可.

上述的所有配置均是以开发为目的的配置,如果需要做服务器使用的话,请修改相应的配置,并增加安全配置.

P.S.
将httpd和mysqld加入rc.conf文件可以使apache和mysql随系统一起启动,例如:
DAEMONS=(... httpd mysqld ...)',1,'2009-03-30 20:53:29','2009-03-30 20:53:29',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(11,'使用PDO尝试自己写一个数据库类(放出0.1版)','%e4%bd%bf%e7%94%a8pdo%e5%b0%9d%e8%af%95%e8%87%aa%e5%b7%b1%e5%86%99%e4%b8%80%e4%b8%aa%e6%95%b0%e6%8d%ae%e5%ba%93%e7%b1%bb%e6%ad%a3%e5%9c%a8%e5%bc%80%e5%8f%91%e4%b8%ad','长久以来, 一直是使用框架的数据库类来操作数据库,很少自己来写这个东西.最近看到pdo,发现这个东西用来写数据库的类很合适,于是打算尝试下自己写一个数据库的类,不知道能写到什么程度,呵呵

这个类要用完全面向对象的方法来操作数据,每一条记录就是一个对象,记录中的每一个字段,就是对象的一个属性.对象拥有保存,更改和删除的方法.

如果能写出来,就叫0.1版本吧,呵呵.希望能够借此多多熟悉php的面向对象特性.

代码还没有完全写完,先贴出来部分.
<!--more-->
<pre lang="PHP">
<?php
/**
 * =========================================
 * ======== ShiehDB ver 0.1 alpha =========
 * =========================================
 *
 * Created by David Shieh at 2009-04-15
 *
 * E-mail : mykingheaven@gmail.com
 * Gtalk : mykingheaven@gmail.com
 * QQ : 55832168
 *
 * 如果大家对本程序有任何的建议和修改意见,
 * 欢迎大家与我探讨,
 * 希望这个类可以使大家的数据库操作更加的方便
 *
 * 此类既可以直接使用,也可以继承使用
 *
 */
class ShiehDB {

 //要操作的表名
 public $_tableName = null;

 //最终执行的sql语句
 private $_sql = '''';

 /**
 * 构造函数,连接数据库
 * @param string $host
 * @param string $dbname
 * @param string $username
 * @param string $password
 */
 public function __construct($host, $dbname, $username, $password) {
 try {
 $this->_db = new PDO(''mysql:dbname=''.$dbname.'';host=''.$host, $username, $password);
 } catch (PDOException $e) {
 die($e->getMessage());
 }
 }

 /**
 * 查询数据
 * @return array
 */
 public function find() {
 if (!$this->_tableName)
 return $this->errorCode(''201'');
 $this->_sql = ''SELECT '';

 //要获取的字段
 if (isset($this->fields))
 $this->getFields();
 else
 $this->_sql = $this->_sql.''* '';

 //生成sql语句
 $this->_sql = $this->_sql.''FROM ''.$this->_tableName;

 //查询的条件
 if (isset($this->conditions))
 $this->getConditions();

 //返回sql语句ѯ
 return $this->_sql;
 }

 /**
 * 更新数据
 * @return
 */
 public function save() {
 //判断有无ID,有则做update操作,无则做insert操作
 if (isset($this->id)) {
 echo ''1'';
 } else {
 $this->_sql = ''INSERT INTO ''.$this->_tableName." ";

 $array = get_object_vars($this);
 $keys = array();
 $values = array();
 foreach ($array as $key => $value) {
 if ($key[0] !== ''_'') {
 $keys[] = ''`''.$key.''`'';
 $values[] = $value;
 }
 }

 $keys = implode('','', $keys);
 $values = implode('','', $values);

 $this->_sql = $this->_sql."(".$keys.'') VALUES (''.$values.'')'';
 return $this->_sql;
 }
 }

 /**
 * 执行自定义sql语句
 * @return array
 * @param string $sql
 */
 public function query($sql) {
 if (!empty($sql)) {
 $stmt = $this->_db->prepare($sql);
 $stmt->execute();
 $num = $stmt->columnCount();
 $result = array();
 for ($i = 1;$i < $num;$i++) {
 $result[] = $stmt->fetchObject();
 }
 return $result;
 }
 }

 /**
 * 查询错误信息代码
 * @return
 * @param string $code
 */
 private function errorCode($code) {
 $codes = array(
 ''201'' => ''No table used.''
 );
 return $codes[$code];
 }

 /**
 * 处理查询的条件
 * @return
 */
 private function getConditions() {
 if (isset($this->conditions)) {
 $result = '''';
 $keys = array_keys($this->conditions);
 $num = count($keys);

 for ($i = 0;$i < $num;$i++) {
 if ($i !== ($num -1) ) {
 $result = $result."`".$keys[$i]."` = ".$this->conditions[$keys[$i]]." AND ";
 }
 else $result = $result."`".$keys[$i]."` = ".$this->conditions[$keys[$i]];
 }

 $this->_sql = $this->_sql." WHERE ".$result;
 unset($this->conditions);
 }

 }

 /**
 * 处理读取的字段
 * @return
 */
 private function getFields() {
 if (isset($this->fields)) {
 $temp = implode('','', $this->fields);
 $this->_sql = $this->_sql.$temp." ";
 unset($this->fields);
 }
 }

 /**
 * 处理排序
 * @return
 */
 private function getOrders() {

 }
}
?>
</pre>

使用方法:
1.直接使用该类:
<pre lang="PHP">
<?php
include(''shiehdb.php'');
$db = new ShiehDB(''localhost'', ''test'', ''root'', ''root'');
$db->_tableName = ''tableName'';
$db->conditions = array(''username'' => ''user'');
$user = $db->find();
?>
</pre>

2.继承该类:
<pre lang="PHP">
<?php
include(''shiehdb.php'');
class User extends ShiehDB {
 public function __construct() {
 parent::__construct(''localhost'', ''test'', ''root'', ''root'');
 $this->_tableName = ''user'';
 }
}

$user = new User();
$user->conditions = array(''id'' => 1);
echo $user->find();
?>
</pre>',1,'2009-03-31 15:42:16','2009-03-31 15:42:16',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(12,'Linux下的取色器','linux%e4%b8%8b%e7%9a%84%e5%8f%96%e8%89%b2%e5%99%a8','最近需要做HTML~需要一个取色器~一直以来Linux底下都没有什么好的取色器软件~
偶然间发现Gcolor2~还不错~是个Gnome下的取色软件~试用过后~觉得很是好用~再也不需要Gimp取色了~
安装命令为:
pacman -S gcolor2',1,'2009-04-03 00:10:46','2009-04-03 00:10:46',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(13,'Yii请求处理流程分析','yii-workflow','近日对Yii的请求处理有些疑惑~所以便开始了对Yii的源码的研究.
[caption id="attachment_100" align="alignnone" width="420" caption="Yii请求处理流程图"]<img src="http://davidshieh.cn/wp-content/uploads/2009/04/flow.png" alt="Yii请求处理流程图" title="flow" width="420" height="520" class="size-full wp-image-100" />[/caption]
这是官方的一副流程图.
打开源码~开始了请求的追踪.
<!--more-->
当一次请求被处理的时候~程序先调用了project/index.php文件,里面有如下几行代码:
<pre lang="PHP">
// change the following paths if necessary
$yii=dirname(__FILE__).''/../yii/framework/yii.php'';
$config=dirname(__FILE__).''/protected/config/main.php'';

// remove the following line when in production mode
defined(''YII_DEBUG'') or define(''YII_DEBUG'',true);

require_once($yii);
Yii::createWebApplication($config)-&gt;run();
</pre>
这段代码首先讲yii.php文件和main.php文件放入2个变量中,然后设置了YII_DEBUG变量为true,接着require_once了yii.php文件,并调用了run()方法.

yii.php文件有如下代码:
<pre lang="PHP">
require(dirname(__FILE__).''/YiiBase.php'');
class Yii extends YiiBase
{
}
</pre>
这段代码导入了yiibase.php,并定义了类Yii,该类继承YiiBase.

main.php里面是各种配置的信息,将配置信息作为数组返回.
Yii继承YiiBase,于是又找到YiiBase.php文件,发现这个文件开始的时候定义了如下几个变量:YII_BEGIN_TIME,YII_DEBUG,YII_ENABLE_EXCEPTION_HANDLER,YII_ENABLE_ERROR_HANDLER和YII_BATH.
找到createWebApplication方法,里面就一条语句:
<pre lang="PHP">
return new CWebApplication($config);
</pre>
于是又找到yii/framework/web/CWebApplication.php文件,但是却没有在里面找到构造函数,由于该类继承CApplication,又找到yii/framework/base/CApplication.php,这个类里有构造函数,内容如下:
<pre lang="PHP">
public function __construct($config=null)
{
 Yii::setApplication($this);

 // set basePath at early as possible to avoid trouble
 if(is_string($config))
 $config=require($config);
 if(isset($config[''basePath'']))
 {
 $this->setBasePath($config[''basePath'']);
 unset($config[''basePath'']);
 }
 else
 $this->setBasePath(''protected'');
 Yii::setPathOfAlias(''application'',$this->getBasePath());
 Yii::setPathOfAlias(''webroot'',dirname($_SERVER[''SCRIPT_FILENAME'']));

 $this->preinit();

 $this->initSystemHandlers();
 $this->registerCoreComponents();

 $this->configure($config);
 $this->attachBehaviors($this->behaviors);
 $this->preloadComponents();

 $this->init();
}
</pre>
第一句Yii::setApplication($app);调用YiiBase里的setApplication()方法,该方法内容如下:
<pre lang="PHP">
public static function setApplication($app)
{
 if(self::$_app===null || $app===null)
 self::$_app=$app;
 else
 throw new CException(Yii::t(''yii'',''Yii application can only be created once.''));
}
</pre>
这个方法的目的是实例化一个app对象.
第6行到第14行设定了config和basePath.第15句和第16句设定了2个路径的快捷方式, webroot和application.
第18行调用了preinit()方法,该方法在该类中没有,是该类的父类CModule里的,但是找到yii/framework/base/CModule.php后,发现该方法内容为空.
第20行调用了initSystemHandlers,该方法位于该类中,内容如下:
<pre lang="PHP">
protected function initSystemHandlers()
{
 if(YII_ENABLE_EXCEPTION_HANDLER)
 set_exception_handler(array($this,''handleException''));
 if(YII_ENABLE_ERROR_HANDLER)
 set_error_handler(array($this,''handleError''),error_reporting());
}
</pre>
第21行调用了registerCoreComponents方法,该方法内容如下:
<pre lang="PHP">
protected function registerCoreComponents()
{
 $components=array(
 ''coreMessages''=>array(
 ''class''=>''CPhpMessageSource'',
 ''language''=>''en_us'',
 ''basePath''=>YII_PATH.DIRECTORY_SEPARATOR.''messages'',
 ),
 ''db''=>array(
 ''class''=>''CDbConnection'',
 ),
 ''messages''=>array(
 ''class''=>''CPhpMessageSource'',
 ),
 ''errorHandler''=>array(
 ''class''=>''CErrorHandler'',
 ),
 ''securityManager''=>array(
 ''class''=>''CSecurityManager'',
 ),
 ''statePersister''=>array(
 ''class''=>''CStatePersister'',
 ),
 );

 $this->setComponents($components);
}
</pre>
第23行调用了configure方法,该方法在父类CModule里,内容如下:
<pre lang="PHP">
public function configure($config)
{
 if(is_array($config))
 {
 foreach($config as $key=>$value)
 $this->$key=$value;
 }
}
</pre>
第24行调用了attachBehaviors方法,该方法位于父类CModule的父类CComponent类中,内容如下:
<pre lang="PHP">
public function attachBehaviors($behaviors)
{
 foreach($behaviors as $name=>$behavior)
 $this->attachBehavior($name,$behavior);
}
</pre>
第25行调用了preloadComponents方法,该方法同样位于父类CModule里,内容如下:
<pre lang="PHP">
protected function preloadComponents()
{
 foreach($this->preload as $id)
 $this->getComponent($id);
}
</pre>
第27行调用了init方法,该方法位于父类CModule方法中,内容为空.
至此Yii::createWebApplication($config)方法已经分析完成~剩下的就是run()方法了.',1,'2009-04-20 00:04:48','2009-04-20 00:04:48',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(14,'使用Yii开发简单新闻系统之一--建立项目','yii-article-system-tuturial-one','前端时间一直想一个适合新手入门的Yii实例, 一直没有完成, 这个周末有些时间, 把这个教程完成.

首先我们来分析下项目需求:
这个新闻系统, 所有用户可以查新新闻, 但只有注册用户才可以评论新闻.用户可以随便注册成为注册用户.
建表的sql语句如下:
<pre lang="SQL">
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- 数据库: `shiehnews`
--

-- --------------------------------------------------------

--
-- 表的结构 `articles`
--

CREATE TABLE IF NOT EXISTS `articles` (
 `id` int(11) NOT NULL auto_increment,
 `userId` int(11) NOT NULL,
 `categoryId` int(11) NOT NULL,
 `title` varchar(255) NOT NULL,
 `createdTime` int(11) NOT NULL,
 `modifiedTime` int(11) NOT NULL,
 `content` text NOT NULL,
 `viewNum` int(11) NOT NULL default ''0'',
 `commentNum` int(11) NOT NULL default ''0'',
 PRIMARY KEY (`id`),
 KEY `fk_articles_users` (`userId`),
 KEY `fk_articles_categories` (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
 `id` int(11) NOT NULL auto_increment,
 `name` varchar(255) NOT NULL,
 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
 `id` int(11) NOT NULL auto_increment,
 `userId` int(11) NOT NULL,
 `articleId` int(11) NOT NULL,
 `comment` text NOT NULL,
 `createdTime` int(11) NOT NULL,
 `modifiedTime` int(11) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `fk_comments_articles` (`articleId`),
 KEY `fk_comments_users` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE IF NOT EXISTS `users` (
 `id` int(11) NOT NULL auto_increment,
 `username` varchar(45) NOT NULL,
 `password` varchar(45) NOT NULL,
 `articleNum` int(11) NOT NULL default ''0'',
 `commentNum` int(11) NOT NULL default ''0'',
 `email` varchar(50) NOT NULL,
 `nickname` varchar(50) default NULL,
 `createdTime` int(11) NOT NULL,
 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
</pre>

下载Yii框架, 我使用的是SVN版的, 大家可以下载1.0.7的.将Yii框架放到D:yii下,在D盘根目录下执行
yiiframeworkyiic.bat webapp shiehnews-yii
建立项目, 然后进入项目, 修改protectedconfigmain.php, 修改里面name值,改成ShiehNews, 接着修改db值
将db值修改为:
<pre lang="PHP">
''db'' => array(
 ''class'' => ''CDbConnection'',
 ''connectionString'' => ''mysql:host=localhost;dbname=shiehnews'',
 ''username'' => ''root'',
 ''password'' => ''root'',
 ''charset'' => ''utf8'',
),
</pre>
dbname改成数据库的名称,username和password改成自己数据库的用户名和密码.保存即可.
回到命令行, 进入shiehnews-yii目录, 执行
protectedyiic.bat shell
运行代码生成器, 使用model &lt;ModelName&gt;来建立4个model, 对应我们建的4张表, 这里给4个model启的名字分别为Article, Category, Comment, User, 建好后, 使用crud Article和crud User来建立脚手架. 完成后, 输入exit退出.

至此, 我们已经建立了需要的数据库, 也创建了项目目录, 同时也有了4个model和2个controller, 下一节开始, 我们一起来增加注册, 登录和注销的功能.',1,'2009-04-21 16:09:30','2009-04-21 16:09:30',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(15,'使用Yii开发简单文章系统之二--用户操作','yii-article-system-tutorial-2','上一节我们使用Yii的工具创建了项目, 并创建了我们会用到的model代码和controller代码, 从本节开始, 我们将不断的接触MVC, 不断的完善我们的系统.

打开protectedmodelsUser.php文件, 修改我们的User Model.
首先修改Model指向的表名, 将tableName()里面return的内容改成users, 如下:
<pre lang="PHP">
public function tableName() {
 return ''users'';
}
</pre>
<!--more-->

用户注册的时候, 我们需要用户来输入他喜欢的密码, 需要一个密码确认的字段, 为了防止机器人程序恶意注册, 我们还需要一个验证码字段, 所以要在User这个类里加入2个属性: passwordConfirm和verifyCode, 代码如下:
<pre lang="PHP">
 public $passwordConfirm;
 public $verifyCode;
</pre>

下面我们来添加User的字段验证规则.根据我们的需求, username, password, passwordConfirm, email和verifyCode都是必填项, 所以需要添加如下的规则:
array(''username, password, passwordConfirm, email, verifyCode'', ''required'')
另外, 我们希望用户名和nickname唯一, 就需要添加以下的规则:
array(''username'', ''unique''),
array(''nickname'', ''unique'')
注册的时候, 用户需要输入两遍密码以确保没有把密码输错, 这里就需要passwordConfirm字段的值等于password了, 可以使用以下的规则:
array(''passwordConfirm'', ''compare'', ''compareAttribute'' => ''password'')
这个规则的意思是, passwordConfirm的值必须与password相同.
这样, 我们完成好的验证规则就应该像下面的代码:
<pre lang="PHP">
 public function rules() {
 return array(
 array(''username, password, passwordConfirm, email, verifyCode'', ''required''),
 array(''username'', ''unique''),
 array(''username'', ''length'', ''min'' => 5, ''max'' => 12),
 array(''password'', ''length'', ''min'' => 5, ''max'' => 12),
 array(''nickname'', ''length'', ''min'' => 4, ''max'' => 20),
 array(''nickname'', ''unique''),
 array(''verifyCode'', ''captcha''),
 array(''passwordConfirm'', ''compare'', ''compareAttribute'' => ''password''),
 );
 }
</pre>

Yii的model里有个特殊的地方就是, 它可以保护字段的安全性, 所有放在safeAttributes()方法里的字段被认为是可以访问和修改的, 不在里面的字段则是需要保护的, 所以我们需要将我们刚才的字段都放进这个方法里, 如下:
<pre lang="PHP">
 public function attributeLabels() {
 return array(
 ''username'' => ''用户名'',
 ''password'' => ''密码'',
 ''passwordConfirm'' => ''密码确认'',
 ''email'' => ''邮件地址'',
 ''nickname'' => ''昵称'',
 ''verifyCode'' => ''验证码''
 );
 }
</pre>

好了, 现在我们已经有了一个完善的字段验证规则, 又确保了我们的字段是可以访问的, 现在该修改controller文件了. 打开protected/controllers/UserController.php文件, 创建一个新的方法register, 根据yii的规则, 所有允许用户访问的的action方法必须以action开头, 所以我们创建的方法名字应该是actionRegister()了.

书写该方法的方法体, 首先我们需要创建一个form, 这个form是一个Model的实例, 因为我们的目的是注册一个用户, 所以这个form需要是User的实例, 用以下代码:
$form = new User;
这个form建好后, 没有任何属性, 但是已经可以使用了, 我们需要将它传到view里去显示它, 以便让用户填写自己的信息, 使用代码:
$this->render(''register'', array(''form'' => $form));
将$form传到register试图并命名为form.

在protected/views/user目录下创建register.php文件, 内容如下:
<pre lang="PHP">
<h2>新用户注册</h2>

<?php echo CHtml::beginForm(); ?>

<?php echo CHtml::errorSummary($form); ?>

<p>
 <?php echo CHtml::activeLabelEx($form, ''username''); ?>
 <?php echo CHtml::activeTextField($form, ''username'', array(''size'' => 20, ''maxlength'' => 12)); ?>
</p>
<p>
 <?php echo CHtml::activeLabelEx($form, ''password''); ?>
 <?php echo CHtml::activePasswordField($form, ''password'', array(''size'' => 20, ''maxlength'' => 12)); ?>
</p>
<p>
 <?php echo CHtml::activeLabelEx($form, ''passwordConfirm''); ?>
 <?php echo CHtml::activePasswordField($form, ''passwordConfirm'', array(''size'' => 20, ''maxlength'' => 12)); ?>
</p>
<p>
 <?php echo CHtml::activeLabelEx($form, ''email''); ?>
 <?php echo CHtml::activeTextField($form, ''email'', array(''size'' => 20)); ?>
</p>
<p>
 <?php echo CHtml::activeLabelEx($form, ''nickname''); ?>
 <?php echo CHtml::activeTextField($form, ''nickname'', array(''size'' => 20, ''maxlength'' => 12)); ?>
</p>

<p>
 <label>&nbsp;</label>
 <?php $this->widget(''CCaptcha''); ?>
</p>

<p>
 <?php echo CHtml::activeLabelEx($form, ''verifyCode''); ?>
 <?php echo CHtml::activeTextField($form, ''verifyCode''); ?>
</p>

<p>
 <label>&nbsp;</label>
 <?php echo CHtml::submitButton(''注册''); ?>
</p>

<?php echo CHtml::endForm(); ?>
</pre>
里面调用了Yii提供的方法来创建我们需要的HTML标签, 有一个需要注意的地方就是里面使用$this->widget(''CCaptcha'');
来显示一个验证码, 用它的时候, 我们需要在controller里声明它, 声明的方法如下:
<pre lang="PHP">
 public function actions() {
 return array(
 ''captcha''=>array(
 ''class'' => ''CCaptchaAction'',
 ''backColor'' => 0xCCCCCC,
 ''testLimit'' => 1,
 ),
 );
 }
</pre>
这样,我们就可以在view里使用验证码了, 怎么样, 赶紧去试试吧, 访问url:
http://localhost/index.php?r=user/register
怎么?显示你没有权限访问该action, 嘿嘿, 这就对了, 在Yii的世界里, 任何一个action在被访问的时候, 都会检查它的权限的, 我们只需要到controller里找到accessRules()方法, 在''user'' => array(''*'')的这个array里, 将我们的action加进入, 就可以顺利访问了, 比如说:
<pre lang="PHP">
 array(''allow'', // allow all users to perform ''list'' and ''show'' actions
 ''actions'' => array(''register'', ''login'', ''logout'', ''captcha''),
 ''users'' => array(''*''),
 ),
</pre>
注意, 要在view里显示captcha, 也必须把captcha action加进去.
回到浏览器重新刷新一下, 怎么样, 我们的表单出来了吧.',1,'2009-04-21 16:24:53','2009-04-21 16:24:53',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(16,'ShiehNews 源码下载','shiehnews-%e6%ba%90%e7%a0%81%e4%b8%8b%e8%bd%bd','最近正在找工作~有些许忙碌~前面写的教程一直没有及时更新~这里放出ShiehNews的源码~感兴趣的朋友可以下来研究~我找到工作后~会把教程补齐的~
<a href="http://davidshieh.cn/wp-content/uploads/2009/04/shiehnews-yii.rar">点击下载源码</a>',1,'2009-04-24 00:21:56','2009-04-24 00:21:56',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(17,'优秀的数据库设计软件--MySQL Workbench','database-modeling-mysql-workbench','之前一直在寻找一款优秀的数据库设计软件,尝试了很多,都没有太中意的~
不经意间发现了MySQL Workbench, 由于是MySQL官方出的数据库软件,所以没有理由不试用一下.

软件不大, 大概有11M的样子, 安装时提示需要.Net Framework 2.0, 这是唯一让我不爽的地方. 为了使用它, 只好委屈下自己了.
<!--more-->
运行后, 发现界面非常的清爽, 如图:
[caption id="attachment_120" align="aligncenter" width="300" caption="MySQL Workbench 界面"]<img src="http://davidshieh.cn/wp-content/uploads/2009/04/mysql-workbench-300x224.png" alt="MySQL Workbench 界面" title="mysql-workbench" width="300" height="224" class="size-medium wp-image-120" />[/caption]

双击上面的"Add Diagram"创建模型图表, 在图表试图里, 左边有一系列的按钮, 上数第7个按钮是创建Table的按钮, 使用它来创建我们需要的表格, 具体过程不描述了, very easy的.
下面还有几个按钮是创建关联的. 如果要关联的字段已经写在表里了, 直接在表的信息栏里可以找到Foreign Keys这个标签.

下面是我为ShiehNews创建的关系图:
[caption id="attachment_121" align="aligncenter" width="300" caption="ShiehNews 关系图"]<img src="http://davidshieh.cn/wp-content/uploads/2009/04/shiehnews-eer-300x213.png" alt="ShiehNews 关系图" title="shiehnews-eer" width="300" height="213" class="size-medium wp-image-121" />[/caption]

MySQL Workbench同样支持将关系图转成sql文件, 点击File, 选择Export->Forward Engineer SQL create script...即可.',1,'2009-04-24 00:38:50','2009-04-24 00:38:50',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(18,'使用Yii优秀的CWebLogRoute组件','%e4%bd%bf%e7%94%a8yii%e4%bc%98%e7%a7%80%e7%9a%84cweblogroute%e7%bb%84%e4%bb%b6','用yiic生成的代码, 已经自带了log系统, 但是这个log是基于文件, 我们想查看一个页面都执行哪个sql语句的时候, 就需要加入另外一个log组件了.

修改main.php, 将下面的代码加入routes里, 完成后的代码如下:
<pre lang="PHP">
''routes''=>array(
 array(
 ''class'' => ''CWebLogRoute'',
 ''levels'' => ''trace,info,error,warning'',
 ''categories'' => ''system.db.*'',
 ),
 array(
 ''class''=>''CFileLogRoute'',
 ''levels''=>''error, warning, watch'',
 ''categories'' => ''system.*''
 ),
),
</pre>

如果不需要计入文件的话, 可以将CFileLogRoute这段去掉, 不过作为产品发布的话, 记录log文件倒是必须的.',1,'2009-04-26 00:37:21','2009-04-26 00:37:21',0,0);
INSERT INTO "entries" (id, title, slug, content, categoryId, createdTime, modifiedTime, viewNum, commentNum)VALUES(19,'ShiehNews 0.2版发布','shiehnews-02%e7%89%88%e5%8f%91%e5%b8%83','最近对ShiehNews进行了一些更改, 发布第二个版本, 就暂时叫为0.2版吧.

数据库建表命令在压缩包里的sql文件里.

欢迎大家提意见!~

<a href="http://davidshieh.cn/wp-content/uploads/2009/05/shiehnews-yii-02-beta.rar">ShiehNews-yii-02-beta</a>

P.S.感谢"Email是真的"仁兄的提醒~发现了我CategoryController的一个小问题
自己太粗心了~弄出来个语法错误~

修改CategoryController里的update Action, 代码如下:
<pre lang="PHP">
 public function actionUpdate() {
 $category=$this->loadCategory();
 if(isset($_POST[''Category'']))
 {
 $category->attributes=$_POST[''Category''];
 if($category->save())
 $this->redirect(array(''show'',''id''=>$category->id));
 }
 $this->render(''update'',array(''category''=>$category));
 }
</pre>',1,'2009-05-04 00:52:25','2009-05-04 00:52:25',0,0);
CREATE TABLE "entry_tag" (
  "entryId" int(11) NOT NULL,
  "tagId" int(11) NOT NULL
);
INSERT INTO "entry_tag" VALUES(1,1);
INSERT INTO "entry_tag" VALUES(1,2);
INSERT INTO "entry_tag" VALUES(2,2);
INSERT INTO "entry_tag" VALUES(3,1);
INSERT INTO "entry_tag" VALUES(3,2);
CREATE TABLE "links" (
  "id" bigint(20)  NOT NULL ,
  "name" varchar(255) NOT NULL,
  "url" varchar(255) NOT NULL,
  "description" varchar(255) NOT NULL,
  "createdTime" datetime NOT NULL,
  PRIMARY KEY ("id")
);
INSERT INTO "links" VALUES(1,'web.py官网','http://webpy.org/','','2009-12-02 16:26:36');
INSERT INTO "links" VALUES(2,'Python官网','http://python.org/','','2009-12-02 16:27:00');
CREATE TABLE "pages" (
  "id" int(11) NOT NULL,
  "title" varchar(255) NOT NULL,
  "slug" varchar(255) NOT NULL,
  "content" text,
  "createdTime" datetime NOT NULL,
  "modifiedTime" datetime NOT NULL,
  PRIMARY KEY ("id")
);
CREATE TABLE "tags" (
  "id" int(11) NOT NULL ,
  "name" varchar(255) NOT NULL,
  "entryNum" int(11) NOT NULL,
  PRIMARY KEY ("id")
);
INSERT INTO "tags" VALUES(1,'python',1);
INSERT INTO "tags" VALUES(2,'test',2);
CREATE TABLE "users" (
  "id" int(11) NOT NULL ,
  "username" varchar(100) NOT NULL,
  "passwd" varchar(50) NOT NULL,
  PRIMARY KEY ("id")
);
INSERT INTO "users" VALUES(1,'admin','21232f297a57a5a743894a0e4a801fc3');
CREATE INDEX "entries_slug" ON "entries" ("slug");
CREATE INDEX "links_id" ON "links" ("id");
CREATE INDEX "pages_slug" ON "pages" ("slug");
COMMIT;
