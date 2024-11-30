

CREATE TABLE `chat` (
  `auth` int(11) NOT NULL,
  `name` int(11) NOT NULL DEFAULT '0',
  `ccname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` int(11) NOT NULL DEFAULT '0',
  `ccmessage` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ccaccess` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`auth`),
  CONSTRAINT `ch_auth` FOREIGN KEY (`auth`) REFERENCES `users` (`auth`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `maptiers` (
  `map` varchar(255) NOT NULL,
  `tier` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`map`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `mapzones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `map` varchar(255) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `corner1_x` float DEFAULT NULL,
  `corner1_y` float DEFAULT NULL,
  `corner1_z` float DEFAULT NULL,
  `corner2_x` float DEFAULT NULL,
  `corner2_y` float DEFAULT NULL,
  `corner2_z` float DEFAULT NULL,
  `destination_x` float NOT NULL DEFAULT '0',
  `destination_y` float NOT NULL DEFAULT '0',
  `destination_z` float NOT NULL DEFAULT '0',
  `track` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `data` int(11) NOT NULL DEFAULT '0',
  `prebuilt` tinyint(1) DEFAULT NULL,
  `form` tinyint(4) DEFAULT NULL,
  `target` varchar(63) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2177 DEFAULT CHARSET=utf8mb4;



CREATE TABLE `migrations` (
  `code` tinyint(4) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `playertimes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `style` tinyint(4) NOT NULL DEFAULT '0',
  `track` tinyint(4) NOT NULL DEFAULT '0',
  `time` float NOT NULL,
  `auth` int(11) DEFAULT NULL,
  `map` varchar(255) NOT NULL,
  `points` float NOT NULL DEFAULT '0',
  `exact_time_int` int(11) DEFAULT '0',
  `jumps` int(11) DEFAULT NULL,
  `date` int(11) DEFAULT NULL,
  `strafes` int(11) DEFAULT NULL,
  `sync` float DEFAULT NULL,
  `perfs` float DEFAULT '0',
  `completions` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `map` (`map`,`style`,`track`,`time`),
  KEY `auth` (`auth`,`date`,`points`),
  KEY `time` (`time`),
  KEY `map2` (`map`),
  CONSTRAINT `pt_auth` FOREIGN KEY (`auth`) REFERENCES `users` (`auth`)
) ENGINE=InnoDB AUTO_INCREMENT=9340 DEFAULT CHARSET=utf8mb4;




CREATE TABLE `stagetimespb` (
  `style` tinyint(4) NOT NULL,
  `track` tinyint(4) NOT NULL DEFAULT '0',
  `map` varchar(255) NOT NULL,
  `stage` tinyint(4) NOT NULL,
  `auth` int(11) NOT NULL,
  `time` float NOT NULL,
  PRIMARY KEY (`style`,`track`,`auth`,`map`,`stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `stagetimeswr` (
  `style` tinyint(4) NOT NULL,
  `track` tinyint(4) NOT NULL DEFAULT '0',
  `map` varchar(255) NOT NULL,
  `stage` tinyint(4) NOT NULL,
  `auth` int(11) NOT NULL,
  `time` float NOT NULL,
  PRIMARY KEY (`style`,`track`,`map`,`stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;




CREATE TABLE `startpositions` (
  `auth` int(11) NOT NULL,
  `track` tinyint(4) NOT NULL,
  `map` varchar(255) NOT NULL,
  `pos_x` float DEFAULT NULL,
  `pos_y` float DEFAULT NULL,
  `pos_z` float DEFAULT NULL,
  `ang_x` float DEFAULT NULL,
  `ang_y` float DEFAULT NULL,
  `ang_z` float DEFAULT NULL,
  `angles_only` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`auth`,`track`,`map`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `styleplaytime` (
  `auth` int(11) NOT NULL,
  `style` tinyint(4) NOT NULL,
  `playtime` float NOT NULL,
  PRIMARY KEY (`auth`,`style`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `users` (
  `auth` int(11) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `ip` int(11) DEFAULT NULL,
  `lastlogin` int(11) NOT NULL DEFAULT '-1',
  `points` float NOT NULL DEFAULT '0',
  `playtime` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`auth`),
  KEY `points` (`points`),
  KEY `lastlogin` (`lastlogin`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `duplicate_same_time`(
   `id` INT(11)   NOT NULL  ,
	`style` TINYINT(4)   NOT NULL  ,
	`track` TINYINT(4)   NOT NULL  ,
	`time` FLOAT(12)   NOT NULL  ,
	`auth` INT(11)   NULL  ,
	`map` VARCHAR(255)   NOT NULL  COLLATE utf8mb4_general_ci,
	`points` FLOAT(12)   NOT NULL  ,
	`exact_time_int` INT(11)   NULL  ,
	`jumps` INT(11)   NULL  ,
	`date` INT(11)   NULL  ,
	`strafes` INT(11)   NULL  ,
	`sync` FLOAT(12)   NULL  ,
	`perfs` FLOAT(12)   NULL  ,
	`completions` SMALLINT(6)   NULL  
);

CREATE TABLE `duplicate_time_detail`(
   `id` INT(11)   NOT NULL  ,
	`style` TINYINT(4)   NOT NULL  ,
	`track` TINYINT(4)   NOT NULL  ,
	`time` FLOAT(12)   NOT NULL  ,
	`auth` INT(11)   NULL  ,
	`map` VARCHAR(255)   NOT NULL  COLLATE utf8mb4_general_ci,
	`points` FLOAT(12)   NOT NULL  ,
	`exact_time_int` INT(11)   NULL  ,
	`jumps` INT(11)   NULL  ,
	`date` INT(11)   NULL  ,
	`strafes` INT(11)   NULL  ,
	`sync` FLOAT(12)   NULL  ,
	`perfs` FLOAT(12)   NULL  ,
	`completions` SMALLINT(6)   NULL  
);

CREATE TABLE `duplicated_time`(
   `style` TINYINT(4)   NOT NULL  ,
	`track` TINYINT(4)   NOT NULL  ,
	`auth` INT(11)   NULL  ,
	`map` VARCHAR(255)   NOT NULL  COLLATE utf8mb4_general_ci
);

CREATE TABLE `wrhrankall`(
   `wrrank` INT(1)   NOT NULL  ,
	`style` INT(2)   NOT NULL  ,
	`auth` INT(11)   NULL  ,
	`COUNT(*)` BIGINT(21)   NOT NULL  
);

CREATE TABLE `wrhrankbonus`(
   `wrrank` INT(1)   NOT NULL  ,
	`style` TINYINT(4)   NOT NULL  ,
	`auth` INT(11)   NULL  ,
	`wrcount` BIGINT(21)   NOT NULL  
);

CREATE TABLE `wrhrankcvar`(
   `wrrank` INT(1)   NOT NULL  ,
	`style` INT(2)   NOT NULL  ,
	`auth` INT(11)   NULL  ,
	`COUNT(*)` BIGINT(21)   NOT NULL  
);

CREATE TABLE `wrhrankmain`(
   `wrrank` INT(1)   NOT NULL  ,
	`style` TINYINT(4)   NOT NULL  ,
	`auth` INT(11)   NULL  ,
	`wrcount` BIGINT(21)   NOT NULL  
);

CREATE TABLE `wrs`(
   `id` INT(11)   NOT NULL  ,
	`style` TINYINT(4)   NOT NULL  ,
	`track` TINYINT(4)   NOT NULL  ,
	`time` FLOAT(12)   NOT NULL  ,
	`auth` INT(11)   NULL  ,
	`map` VARCHAR(255)   NOT NULL  COLLATE utf8mb4_general_ci,
	`points` FLOAT(12)   NOT NULL  ,
	`exact_time_int` INT(11)   NULL  ,
	`jumps` INT(11)   NULL  ,
	`date` INT(11)   NULL  ,
	`strafes` INT(11)   NULL  ,
	`sync` FLOAT(12)   NULL  ,
	`perfs` FLOAT(12)   NULL  ,
	`completions` SMALLINT(6)   NULL  
);

CREATE TABLE `wrs_min`(
   `time` FLOAT(12)   NULL  ,
	`map` VARCHAR(255)   NOT NULL  COLLATE utf8mb4_general_ci,
	`track` TINYINT(4)   NOT NULL  ,
	`style` TINYINT(4)   NOT NULL  
);