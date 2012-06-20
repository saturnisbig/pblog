
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `slug` varchar(75) NOT NULL,
  `entryNum` int(11) NOT NULL,
  PRIMARY KEY (`id`)
  )ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `categories` (`id`, `name`, `slug`, `entryNum`) VALUES (1, 'Python', 'python', 1),
(2, 'PHP', 'php', 1),
(3, 'PHP', 'php', 0),
(4, 'JavaScript', 'javascript', 0),
(5, 'Linux', 'linux', 0),
(6, 'VIM', 'vim', 0),
(7, '数据库配置', 'database-config', 0),
(8, '服务器配置', 'server-config', 0);
