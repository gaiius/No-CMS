DROP TABLE IF EXISTS `cms_config`;
/*split*/
DROP TABLE IF EXISTS `cms_module_dependency`;
/*split*/
DROP TABLE IF EXISTS `cms_module`;
/*split*/
DROP TABLE IF EXISTS `cms_group_privilege`;
/*split*/
DROP TABLE IF EXISTS `cms_group_navigation`;
/*split*/
DROP TABLE IF EXISTS `cms_group_widget`;
/*split*/
DROP TABLE IF EXISTS `cms_group_user`;
/*split*/
DROP TABLE IF EXISTS `cms_group`;
/*split*/
DROP TABLE IF EXISTS `cms_quicklink`;
/*split*/
DROP TABLE IF EXISTS `cms_navigation`;
/*split*/
DROP TABLE IF EXISTS `cms_widget`;
/*split*/
DROP TABLE IF EXISTS `cms_privilege`;
/*split*/
DROP TABLE IF EXISTS `cms_user`;
/*split*/
DROP TABLE IF EXISTS `cms_authorization`;
/*split*/
DROP TABLE IF EXISTS `ci_sessions`;
/*split*/
DROP TABLE IF EXISTS `help_topic`;
/*split*/
DROP TABLE IF EXISTS `help_group`;
/*split*/

CREATE TABLE `cms_authorization` (
  `authorization_id` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,
  `authorization_name` varchar(45) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`authorization_id`),
  UNIQUE KEY `authorization_name` (`authorization_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_group` (
  `group_id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(45) NOT NULL,
  `description` text,
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `group_name` (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_widget` (
  `widget_id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `widget_name` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `description` text,
  `url` varchar(45) DEFAULT NULL,
  `authorization_id` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `index` int(20) NOT NULL DEFAULT '0',
  `is_static` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `static_content` text,
  `slug` varchar(50),
  PRIMARY KEY (`widget_id`),
  UNIQUE KEY `widget_name` (`widget_name`),
  KEY `authorization_id` (`authorization_id`),
  CONSTRAINT `cms_widget_ibfk_1` FOREIGN KEY (`authorization_id`) REFERENCES `cms_authorization` (`authorization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE IF NOT EXISTS `cms_navigation` (
  `navigation_id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `navigation_name` varchar(45) NOT NULL,
  `parent_id` int(20) unsigned DEFAULT NULL,
  `title` varchar(45) NOT NULL,
  `description` text,
  `url` varchar(100) DEFAULT NULL,
  `authorization_id` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `index` int(20) NOT NULL DEFAULT '0',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `is_static` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `static_content` text,
  `only_content` int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`navigation_id`),
  UNIQUE KEY `navigation_name` (`navigation_name`),
  KEY `parent_id` (`parent_id`),
  KEY `authorization_id` (`authorization_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_quicklink` (
  `quicklink_id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `navigation_id` int(20) unsigned NOT NULL,
  `index` int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`quicklink_id`),
  UNIQUE KEY `navigation_id` (`navigation_id`),
  CONSTRAINT `cms_quicklink_ibfk_1` FOREIGN KEY (`navigation_id`) REFERENCES `cms_navigation` (`navigation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_privilege` (
  `privilege_id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `privilege_name` varchar(45) NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `description` text,
  `authorization_id` tinyint(4) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`privilege_id`),
  UNIQUE KEY `privilege_name` (`privilege_name`),
  KEY `authorization_id` (`authorization_id`),
  CONSTRAINT `cms_privilege_ibfk_1` FOREIGN KEY (`authorization_id`) REFERENCES `cms_authorization` (`authorization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_user` (
  `user_id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `activation_code` varchar(45) NULL,
  `real_name` varchar(45) DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_group_widget` (
  `group_id` int(20) unsigned NOT NULL,
  `widget_id` int(20) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`widget_id`),
  KEY `widget_id` (`widget_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `cms_group_widget_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `cms_group` (`group_id`),
  CONSTRAINT `cms_group_widget_ibfk_2` FOREIGN KEY (`widget_id`) REFERENCES `cms_widget` (`widget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_group_navigation` (
  `group_id` int(20) unsigned NOT NULL,
  `navigation_id` int(20) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`navigation_id`),
  KEY `navigation_id` (`navigation_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `cms_group_navigation_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `cms_group` (`group_id`),
  CONSTRAINT `cms_group_navigation_ibfk_2` FOREIGN KEY (`navigation_id`) REFERENCES `cms_navigation` (`navigation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_group_privilege` (
  `group_id` int(20) unsigned NOT NULL,
  `privilege_id` int(20) unsigned NOT NULL,
  PRIMARY KEY (`privilege_id`,`group_id`),
  KEY `group_id` (`group_id`),
  KEY `privilege_id` (`privilege_id`),
  CONSTRAINT `cms_group_privilege_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `cms_group` (`group_id`),
  CONSTRAINT `cms_group_privilege_ibfk_2` FOREIGN KEY (`privilege_id`) REFERENCES `cms_privilege` (`privilege_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_group_user` (
  `group_id` int(20) unsigned NOT NULL,
  `user_id` int(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cms_group_user_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `cms_group` (`group_id`),
  CONSTRAINT `cms_group_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `cms_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_module` (
  `module_id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `module_name` varchar(50) NOT NULL,
  `module_path` varchar(50) NOT NULL,
  `user_id` int(20) unsigned NOT NULL,
  PRIMARY KEY (`module_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cms_module_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `cms_user` (`user_id`),
  UNIQUE KEY `module_path` (`module_path`),
  UNIQUE KEY `module_name` (`module_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_module_dependency` (
  `module_dependency_id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(20) unsigned NOT NULL,
  `child_id` int(20) unsigned NOT NULL,
  PRIMARY KEY (`module_dependency_id`),
  KEY `parent_id` (`parent_id`),
  KEY `child_id` (`child_id`),
  CONSTRAINT `cms_module_dependency_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `cms_module` (`module_id`),
  CONSTRAINT `cms_module_dependency_ibfk_2` FOREIGN KEY (`child_id`) REFERENCES `cms_module` (`module_id`),
  UNIQUE KEY `module_parent_child` (`parent_id`, `child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE `cms_config` (
  `config_id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `config_name` varchar(50) NOT NULL,
  `value` text NULL,
  `description` text,
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `config_name` (`config_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*split*/

CREATE TABLE IF NOT EXISTS  `ci_sessions` (
    `session_id` varchar(40) DEFAULT '0' NOT NULL,
    `ip_address` varchar(16) DEFAULT '0' NOT NULL,
    `user_agent` varchar(120) NOT NULL,
    `last_activity` int(10) unsigned DEFAULT 0 NOT NULL,
    `user_data` text NOT NULL,
    PRIMARY KEY (`session_id`),
    KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;;
/*split*/

CREATE TABLE IF NOT EXISTS `help_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
/*split*/

CREATE TABLE IF NOT EXISTS `help_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `title` varchar(60) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;
/*split*/

INSERT INTO `cms_authorization` (`authorization_id`, `authorization_name`, `description`) VALUES
(1, 'Everyone', 'All visitor of the web are permitted (e.g:view blog content)'),
(2, 'Unauthenticated', 'Only non-member visitor, they who hasn''t log in yet (e.g:view member registration page)'),
(3, 'Authenticated', 'Only member (e.g:change password)'),
(4, 'Authorized', 'Only member with certain privilege (depend on group)');
/*split*/

INSERT INTO `cms_group` (`group_id`, `group_name`, `description`) VALUES
(1, 'Admin', 'Every member of this group can do everything possible, but only programmer can turn the impossible into real :D'),
(2, 'Employee', 'Just an example, employee role');
/*split*/

INSERT INTO `cms_user` (`user_id`, `user_name`, `email`, `password`, `real_name`, `active`) VALUES
(1, '@adm_username', '@adm_email', '@adm_password', '@adm_realname', 1);
/*split*/

INSERT INTO `cms_navigation` (`navigation_id`, `navigation_name`, `parent_id`, `title`, `description`, `url`, `authorization_id`, `index`, `active`, `is_static`, `static_content`, `only_content`) VALUES
(1, 'main_login', NULL, 'Login', 'Visitor need to login for authentication', 'main/login', 2, 1, 1, 0, NULL, 0),
(2, 'main_forgot', NULL, 'Forgot password', 'Accidentally forgot password', 'main/forgot', 2, 3, 1, 0, NULL, 0),
(3, 'main_logout', NULL, 'Logout', 'Logout for deauthentication', 'main/logout', 3, 2, 1, 0, NULL, 0),
(4, 'main_management', NULL, 'CMS Management', 'The main management of the CMS. Including User, Group, Privilege and Navigation Management', 'main/management', 4, 6, 1, 0, NULL, 0),
(5, 'main_register', NULL, 'Register', 'New User Registration', 'main/register', 2, 4, 1, 0, NULL, 0),
(6, 'main_change_profile', NULL, 'Change Profile', 'Change Current Profile', 'main/change_profile', 3, 5, 1, 0, NULL, 0),
(7, 'main_group_management', 4, 'Group Management', 'Group Management', 'main/group', 4, 0, 1, 0, NULL, 0),
(8, 'main_navigation_management', 4, 'Navigation Management', 'Navigation management', 'main/navigation', 4, 3, 1, 0, NULL, 0),
(9, 'main_privilege_management', 4, 'Privilege Management', 'Privilege Management', 'main/privilege', 4, 2, 1, 0, NULL, 0),
(10, 'main_user_management', 4, 'User Management', 'Manage User', 'main/user', 4, 1, 1, 0, NULL, 0),
(11, 'main_module_management', 4, 'Module Management', 'Install Or Uninstall Thirdparty Module', 'main/module_management', 4, 5, 1, 0, NULL, 0),
(12, 'main_change_theme', 4, 'Change Theme', 'Change Theme', 'main/change_theme', 4, 6, 1, 0, NULL, 0),
(13, 'main_widget_management', 4, 'Widget Management', 'Manage Widgets', 'main/widget', 4, 4, 1, 0, NULL, 0),
(14, 'main_quicklink_management', 4, 'Quick Link Management', 'Manage Quick Link', 'main/quicklink', 4, 7, 1, 0, NULL, 0),
(15, 'main_config_management', 4, 'Configuration Management', 'Manage Configuration Parameters', 'main/config', 4, 8, 1, 0, NULL, 0),
(16, 'main_index', NULL, 'Home', 'There is no place like home :D', 'main/index', 1, 0, 1, 0, NULL, 0);
/*split*/

INSERT INTO `cms_quicklink` (`quicklink_id`, `navigation_id`, `index`) VALUES
(1, 16, 0),
(2, 5, 1),
(3, 2, 2),
(4, 4, 3);
/*split*/

INSERT INTO `cms_widget` (`widget_id`, `widget_name`, `title`, `description`, `url`, `authorization_id`, `active`, `index`, `is_static`, `static_content`, `slug`) VALUES
(1, 'login', 'Login', 'Visitor need to login for authentication', 'main/widget_login', 2, 1, 0, 1, '<form action="@site_url/main/login" method="post" accept-charset="utf-8"><label>Identity</label><br><input type="text" name="identity" value=""><br><label>Password</label><br><input type="password" name="password" value=""><br><input type="submit" name="login" value="Log In"></form>', 'sidebar'),
(2, 'logout', 'User Info', 'Logout', 'main/widget_logout', 3, 1, 1, 1, 'Welcome @user_name<br />\n<a href="@site_url/main/logout">logout</a><br />', 'sidebar'),
(3, 'social_plugin', 'Share This Page !!', 'Addthis', 'main/widget_social_plugin', 1, 1, 2, 1, '<!-- AddThis Button BEGIN -->\n<div class="addthis_toolbox addthis_default_style "><a class="addthis_button_preferred_1"></a> <a class="addthis_button_preferred_2"></a> <a class="addthis_button_preferred_3"></a> <a class="addthis_button_preferred_4"></a> <a class="addthis_button_preferred_5"></a> <a class="addthis_button_preferred_6"></a> <a class="addthis_button_preferred_7"></a> <a class="addthis_button_preferred_8"></a> <a class="addthis_button_preferred_9"></a> <a class="addthis_button_preferred_10"></a> <a class="addthis_button_preferred_11"></a> <a class="addthis_button_preferred_12"></a> <a class="addthis_button_preferred_13"></a> <a class="addthis_button_preferred_14"></a> <a class="addthis_button_preferred_15"></a> <a class="addthis_button_preferred_16"></a> <a class="addthis_button_compact"></a> <a class="addthis_counter addthis_bubble_style"></a></div>\n<script src="http://s7.addthis.com/js/250/addthis_widget.js?domready=1" type="text/javascript"></script>\n<!-- AddThis Button END -->', 'sidebar'),
(4, 'google_search', 'Search', 'Search from google', '', 1, 0, 3, 1, '<!-- Google Custom Search Element -->\n<div id="cse" style="width: 100%;">Loading</div>\n<script src="http://www.google.com/jsapi" type="text/javascript"></script>\n<script type="text/javascript">// <![CDATA[\n    google.load(''search'', ''1'');\n    google.setOnLoadCallback(function(){var cse = new google.search.CustomSearchControl();cse.draw(''cse'');}, true);\n// ]]></script>', 'sidebar'),
(5, 'google_translate', 'Translate !!', '<p>The famous google translate</p>', '', 1, 0, 4, 1, '<!-- Google Translate Element -->\n<div id="google_translate_element" style="display:block"></div>\n<script>\nfunction googleTranslateElementInit() {\n  new google.translate.TranslateElement({pageLanguage: "af"}, "google_translate_element");\n};\n</script>\n<script src="http://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>\n', 'sidebar'),
(6, 'calendar', 'Calendar', 'Indonesian Calendar', '', 1, 0, 5, 1, '<!-------Do not change below this line------->\n<div align="center" height="200px">\n    <iframe align="center" src="http://www.calendarlabs.com/calendars/web-content/calendar.php?cid=1001&uid=162232623&c=22&l=en&cbg=C3D9FF&cfg=000000&hfg=000000&hfg1=000000&ct=1&cb=1&cbc=2275FF&cf=verdana&cp=bottom&sw=0&hp=t&ib=0&ibc=&i=" width="170" height="155" marginwidth=0 marginheight=0 frameborder=no scrolling=no allowtransparency=''true''>\n    Loading...\n    </iframe>\n    <div align="center" style="width:140px;font-size:10px;color:#666;">\n        Powered by <a  href="http://www.calendarlabs.com/" target="_blank" style="font-size:10px;text-decoration:none;color:#666;">Calendar</a> Labs\n    </div>\n</div>\n\n<!-------Do not change above this line------->', 'sidebar'),
(7, 'google_map', 'Map', 'google map', '', 1, 0, 6, 1, '<!-- Google Maps Element Code -->\n<iframe frameborder=0 marginwidth=0 marginheight=0 border=0 style="border:0;margin:0;width:150px;height:250px;" src="http://www.google.com/uds/modules/elements/mapselement/iframe.html?maptype=roadmap&element=true" scrolling="no" allowtransparency="true"></iframe>', 'sidebar'),
(8, 'donate_nocms', 'Donate No-CMS', 'No-CMS Donation', NULL, 1, 1, 7, 1, '<div><form action="https://www.paypal.com/cgi-bin/webscr" method="post">\n<input type="hidden" name="cmd" value="_s-xclick" />\n<input type="hidden" name="hosted_button_id" value="VT38TLVZEZ9JN" />\n<input type="image" src="@base_url/assets/nocms/images/donation.png" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!" width="165px" height="auto" />\n<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1" />\n</form></div>', 'advertisement');

/*split*/

INSERT INTO `cms_privilege` (`privilege_id`, `privilege_name`, `title`, `description`, `authorization_id`) VALUES
(1, 'cms_install_module', 'Install Module', 'Install Module is a very critical privilege, it allow authorized user to Install a module to the CMS.<br />By Installing module, the database structure can be changed. There might be some additional navigation and privileges added.<br /><br />You''d be better to give this authorization only authenticated and authorized user. (I suggest to make only admin have such a privilege)\n&nbsp;', 4),
(2, 'cms_manage_access', 'Manage Access', 'Manage access\n&nbsp;', 4);
/*split*/

INSERT INTO `cms_config` (`config_id`, `config_name`, `value`, `description`) VALUES
(1, 'site_name', 'No-CMS', 'Site title'),
(2, 'site_slogan', 'A Free CodeIgniter Based CMS Framework', 'Site slogan'),
(3, 'site_logo', '@base_url/assets/nocms/images/No-CMS-logo.png', 'Site logo'),
(4, 'site_favicon', '@base_url/assets/nocms/images/No-CMS-favicon.png', 'Site favicon'),
(5, 'site_footer', 'goFrendiAsgard &copy; 2011', 'Site footer'),
(6, 'site_theme', 'neutral', 'Site theme'),
(7, 'site_language', 'english', 'Site language'),
(8, 'max_menu_depth', '5', 'Depth of menu recursive'),
(9, 'cms_email_address', 'no-reply@No-CMS.com', 'Email address'),
(10, 'cms_email_name', 'admin of No-CMS', 'Email name'),
(11, 'cms_email_forgot_subject', 'Re-activate your account at No-CMS', 'Email subject'),
(12, 'cms_email_forgot_message', 'Dear, @realname<br />Click <a href="@activation_link">@activation_link</a> to reactivate your account', 'Email message'),
(13, 'cms_email_useragent', 'Codeigniter', 'Default : CodeIgniter'),
(14, 'cms_email_protocol', 'smtp', 'Default : smtp, Alternatives : mail, sendmail, smtp'),
(15, 'cms_email_mailpath', '/usr/sbin/sendmail','Default : /usr/sbin/sendmail'),
(16, 'cms_email_smtp_host', '','eg : ssl://smtp.googlemail.com'),
(17, 'cms_email_smtp_user', '','eg : your_gmail_address@gmail.com'),
(18, 'cms_email_smtp_pass', '','your password'),
(19, 'cms_email_smtp_port', '465','smtp port, default : 465'),
(20, 'cms_email_smtp_timeout', '30','default : 30'),
(21, 'cms_email_wordwrap', 'TRUE', 'Enable word-wrap. Default : true, Alternatives : true, false'),
(22, 'cms_email_wrapchars', '76	', 'Character count to wrap at.'),
(23, 'cms_email_mailtype', 'html', 'Type of mail. If you send HTML email you must send it as a complete web page. Make sure you do not have any relative links or relative image paths otherwise they will not work. Default : html, Alternatives : html, text'),
(24, 'cms_email_charset', 'utf-8', 'Character set (utf-8, iso-8859-1, etc.).'),
(25, 'cms_email_validate', 'FALSE', 'Whether to validate the email address. Default: true, Alternatives : true, false'),
(26, 'cms_email_priority', '3', '1, 2, 3, 4, 5	Email Priority. 1 = highest. 5 = lowest. 3 = normal.'),
(27, 'cms_email_crlf', '\n', '"\r\n" or "\n" or "\r"	Newline character. (Use "\r\n" to comply with RFC 822).'),
(28, 'cms_email_newline', '\n', '"\r\n" or "\n" or "\r"	Newline character. (Use "\r\n" to comply with RFC 822).'),
(29, 'cms_email_bcc_batch_mode', 'FALSE', 'Enable BCC Batch Mode. Default: false, Alternatives: true'),
(30, 'cms_email_bcc_batch_size', '200', 'Number of emails in each BCC batch.');
/*split*/

INSERT INTO `cms_group_user` (`group_id`, `user_id`) VALUES
(1, 1);