/**
 * only links table created.
 * todo: find the errors exists.
 * done 12/06/12 19:45:21 
 */

CREATE TABLE entries(
  id int(11) not null auto_increment primary key,
  title varchar(255) not null,
  slug varchar(255) unique,
  content text,
  created_time datetime not null,
  modified_time datetime not null,
  view_num int(11) default 0,
  comment_num int(11) default 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 

/* 创建外键的时候，字段的类型必须相同 */
CREATE TABLE comments (
  id serial primary key,
  entry_id int(11), /* need to add foreign key support */
  email varchar(50) not null,
  username varchar(50) not null,
  url varchar(255),
  comment text,
  created_time datetime
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 
/* add fk support */
/* create index IDX_comment_id on comments(id); */
alter table comments add constraint entry_id_fk FOREIGN KEY(entry_id) REFERENCES entries(id);

CREATE TABLE tags (
  id int(11) not null auto_increment primary key,
  name varchar(255) not null,
  entry_num int(11) not null
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

CREATE TABLE entry_tag (
  entry_id int(11) not null,
  tag_id int(11) not null
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

alter table entry_tag add constraint entry_tag_fk1 FOREIGN KEY(entry_id) REFERENCES entries(id);
alter table entry_tag add constraint entry_tag_fk2 FOREIGN KEY(tag_id) REFERENCES tags(id);

CREATE TABLE links (
  id serial primary key,
  name varchar(255) not null,
  url varchar(255) not null,
  description varchar(255) not null,
  created_time datetime not null
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

CREATE TABLE pages (
  id serial primary key,
  title varchar(255) not null,
  slug varchar(255) unique not null,
  content text,
  created_time datetime not null,
  modified_time datetime not null
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

INSERT INTO `tags` (`id`, `name`, `entry_num`) VALUES(1, 'python', 1),(2, 'test', 2);

INSERT INTO `links` (`id`, `name`, `url`, `created_time`) VALUES(1, 'web.py官网', 'http://webpy.org/', '2009-12-02 16:26:36'),
(2, 'Python官网', 'http://python.org/', '2009-12-02 16:27:00');

INSERT INTO `comments` (`id`, `entry_id`, `username`, `email`, `url`, `comment`, `created_time`) VALUES
(1, 3, 'abcabc', 'mykingheaven@gmail.com', '#', '测试留言', '2009-12-09 01:37:00');

INSERT INTO `entry_tag` (`entry_id`, `tag_id`) VALUES(1, 1),
(1, 2),
(2, 2),
(3, 1),
(3, 2);
INSERT INTO `entries` (`id`, `title`, `content`, `created_time`, `modified_time`, `view_num`, `comment_num`, `slug`) VALUES
(1, 'test entry', 'asdgsadgasdg','2009-12-02 13:31:27', '2009-12-02 13:31:32', 0, 0, 'test-entry'),
(2, 'second test entry', 'sdgasdgsadgsdgasdgas sdgasdg\r\nsdghasdhasdh\r\nsdhasdhsadh', '2009-12-01 13:31:57', '2009-12-01 13:32:00', 0, 0, 'second-test-entry'),
(3, '大卫粘贴使用量突破100!', '<p>十一前后的时候, 我做了一个简单的代码粘贴网, 功能比较简单, 但是速度还是比较快的, 主流的语言也都支持了.</p>\r\n\r\n<p>现在上线已经有一个月了, 使用量终于突破100了!</p>\r\n<p>第101贴是: http://david-paste.cn/paste/101/</p>\r\n\r\n<p>纪念一下!</p>\r\n<p>这里继续做广告, 如果你有一些代码需要给别人展示, 真的要考虑大卫粘贴, 又简单又好用, 访问地址 – http://david-paste.cn/</p>\r\n\r\nP.S. 现在上线的是大卫粘贴 0.2beta版, 0.3beta已经提上日程了, 无奈最近工作有些许忙, 透露一下, 0.3beta将采用web.py框架.', '2009-12-02 17:44:06', '2009-12-02 17:44:10', 0, 0, 'david-paste-100-pastes'),
(4, '我的Linux系统之伤', '<p>使用linux已经有1年之久了, 期间换过很多发行版. 每个人都有自己的linux路线, 我的路线是, Redhat->Ubuntu->Debian->Suse(装了后没怎么用就删了)->Fedora(使用时间没超过一周)->CentOS(只能算尝试)->ArchLinux->Gentoo, 这个路线比较曲折.</p>\r\n\r\n<p>其中比较钟意的有Debian, Arch和Gentoo, 目前使用的是Gentoo. 对我来说, Debian足够稳定, 但是软件包比较老, Arch足够新, 但是又没Gentoo的portage灵活, Gentoo又新又灵活, 但是不厌其烦的升级+编译, 也让我开始有一些厌倦了.</p>\r\n\r\n<p>前两天看上了Sabayon, 感觉还不错, 今天试用了下, 非常的失望, 简直就是Gentoo里的Ubuntu啊, 安装程序本身就有bug, 点掉的东西依然会装上, 选择了xfce, 装上的却是Gnome, 中文支持也有很严重的问题, 字高矮不齐, 应该是字体选择的问题. 进入系统后, 由于Sabayon的源非常少, 所以只能用它的官方源, 在意大利, 速度只有30K上下, 实在不能忍受. Sabayon的包管理系统是Entropy, 也是由python写的, 工作原理与Portage相似, 只是Entropy安装的载体是二进制包, Portage是源码. 但是Entropy有个致命的弱点, 就是它的更新不支持断点续传, 如果你在更新到99%的时候掉线了, 或者由于任何原因断掉的话, 下一次的更新将是从头开始!!!这让人不能接受!!!</p>\r\n\r\n<p>其实Sabayon的本意也许是好的, 给想使用Gentoo, 又嫌编译麻烦的人, 创造一个接触Gentoo的好机会, 但是无奈现在它们的团队还不够成熟, 作出来的发行版离Ubuntu还相差甚远.</p>\r\n\r\n<p>其实, 我所说的这些, 总结成一句话就是, 我已经不知道该选择哪个linux了. Gentoo的portage系统很优秀, USE也很灵活, 让我爱不释手, 但是不停的编译让我有些许厌倦. Arch的包很新, 但是无奈软件仓库没有Gentoo大, aur又不能自定义USE来编译, 让人想爱又爱不起来. 唉, 无奈我已经习惯Gentoo的各种命令和各种配置文件的存放位置了, 看来习惯真的是很改掉的.</p>\r\n', '2009-12-02 17:49:51', '2009-12-02 17:49:54', 0, 0, 'linux-select');

