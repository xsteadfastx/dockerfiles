-- MySQL dump 10.16  Distrib 10.1.13-MariaDB, for Linux (x86_64)
--
-- Host: db    Database: wallabag
-- ------------------------------------------------------
-- Server version	10.0.20-MariaDB-1~wheezy-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `wallabag_annotation`
--

DROP TABLE IF EXISTS `wallabag_annotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_annotation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `entry_id` int(11) DEFAULT NULL,
  `text` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `quote` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ranges` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_A7AED006A76ED395` (`user_id`),
  KEY `IDX_A7AED006BA364942` (`entry_id`),
  CONSTRAINT `FK_A7AED006A76ED395` FOREIGN KEY (`user_id`) REFERENCES `wallabag_user` (`id`),
  CONSTRAINT `FK_A7AED006BA364942` FOREIGN KEY (`entry_id`) REFERENCES `wallabag_entry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_annotation`
--

LOCK TABLES `wallabag_annotation` WRITE;
/*!40000 ALTER TABLE `wallabag_annotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallabag_annotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallabag_config`
--

DROP TABLE IF EXISTS `wallabag_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `theme` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `items_per_page` int(11) NOT NULL,
  `language` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rss_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rss_limit` int(11) DEFAULT NULL,
  `reading_speed` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_87E64C53A76ED395` (`user_id`),
  CONSTRAINT `FK_87E64C53A76ED395` FOREIGN KEY (`user_id`) REFERENCES `wallabag_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_config`
--

LOCK TABLES `wallabag_config` WRITE;
/*!40000 ALTER TABLE `wallabag_config` DISABLE KEYS */;
INSERT INTO `wallabag_config` VALUES (1,1,'material',12,'en',NULL,50,1);
/*!40000 ALTER TABLE `wallabag_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallabag_craue_config_setting`
--

DROP TABLE IF EXISTS `wallabag_craue_config_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_craue_config_setting` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `section` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `UNIQ_5D9649505E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_craue_config_setting`
--

LOCK TABLES `wallabag_craue_config_setting` WRITE;
/*!40000 ALTER TABLE `wallabag_craue_config_setting` DISABLE KEYS */;
INSERT INTO `wallabag_craue_config_setting` VALUES ('carrot','1','entry'),('demo_mode_enabled','0','misc'),('demo_mode_username','wallabag','misc'),('diaspora_url','http://diasporapod.com','entry'),('download_pictures','1','entry'),('export_csv','1','export'),('export_epub','1','export'),('export_json','1','export'),('export_mobi','1','export'),('export_pdf','1','export'),('export_txt','1','export'),('export_xml','1','export'),('piwik_enabled','0','analytics'),('piwik_host','http://v2.wallabag.org','analytics'),('piwik_site_id','1','analytics'),('pocket_consumer_key',NULL,'import'),('shaarli_url','http://myshaarli.com','entry'),('share_diaspora','1','entry'),('share_mail','1','entry'),('share_shaarli','1','entry'),('share_twitter','1','entry'),('show_printlink','1','entry'),('wallabag_support_url','https://www.wallabag.org/pages/support.html','misc'),('wallabag_url','http://v2.wallabag.org','misc');
/*!40000 ALTER TABLE `wallabag_craue_config_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallabag_entry`
--

DROP TABLE IF EXISTS `wallabag_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `title` longtext COLLATE utf8_unicode_ci,
  `url` longtext COLLATE utf8_unicode_ci,
  `is_archived` tinyint(1) NOT NULL,
  `is_starred` tinyint(1) NOT NULL,
  `content` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `mimetype` longtext COLLATE utf8_unicode_ci,
  `language` longtext COLLATE utf8_unicode_ci,
  `reading_time` int(11) DEFAULT NULL,
  `domain_name` longtext COLLATE utf8_unicode_ci,
  `preview_picture` longtext COLLATE utf8_unicode_ci,
  `is_public` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_F4D18282A76ED395` (`user_id`),
  CONSTRAINT `FK_F4D18282A76ED395` FOREIGN KEY (`user_id`) REFERENCES `wallabag_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_entry`
--

LOCK TABLES `wallabag_entry` WRITE;
/*!40000 ALTER TABLE `wallabag_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallabag_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallabag_entry_tag`
--

DROP TABLE IF EXISTS `wallabag_entry_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_entry_tag` (
  `entry_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`entry_id`,`tag_id`),
  KEY `IDX_C9F0DD7CBA364942` (`entry_id`),
  KEY `IDX_C9F0DD7CBAD26311` (`tag_id`),
  CONSTRAINT `FK_C9F0DD7CBA364942` FOREIGN KEY (`entry_id`) REFERENCES `wallabag_entry` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C9F0DD7CBAD26311` FOREIGN KEY (`tag_id`) REFERENCES `wallabag_tag` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_entry_tag`
--

LOCK TABLES `wallabag_entry_tag` WRITE;
/*!40000 ALTER TABLE `wallabag_entry_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallabag_entry_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallabag_oauth2_access_tokens`
--

DROP TABLE IF EXISTS `wallabag_oauth2_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_oauth2_access_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` int(11) DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_368A42095F37A13B` (`token`),
  KEY `IDX_368A420919EB6921` (`client_id`),
  KEY `IDX_368A4209A76ED395` (`user_id`),
  CONSTRAINT `FK_368A420919EB6921` FOREIGN KEY (`client_id`) REFERENCES `wallabag_oauth2_clients` (`id`),
  CONSTRAINT `FK_368A4209A76ED395` FOREIGN KEY (`user_id`) REFERENCES `wallabag_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_oauth2_access_tokens`
--

LOCK TABLES `wallabag_oauth2_access_tokens` WRITE;
/*!40000 ALTER TABLE `wallabag_oauth2_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallabag_oauth2_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallabag_oauth2_auth_codes`
--

DROP TABLE IF EXISTS `wallabag_oauth2_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_oauth2_auth_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `redirect_uri` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` int(11) DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_EE52E3FA5F37A13B` (`token`),
  KEY `IDX_EE52E3FA19EB6921` (`client_id`),
  KEY `IDX_EE52E3FAA76ED395` (`user_id`),
  CONSTRAINT `FK_EE52E3FA19EB6921` FOREIGN KEY (`client_id`) REFERENCES `wallabag_oauth2_clients` (`id`),
  CONSTRAINT `FK_EE52E3FAA76ED395` FOREIGN KEY (`user_id`) REFERENCES `wallabag_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_oauth2_auth_codes`
--

LOCK TABLES `wallabag_oauth2_auth_codes` WRITE;
/*!40000 ALTER TABLE `wallabag_oauth2_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallabag_oauth2_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallabag_oauth2_clients`
--

DROP TABLE IF EXISTS `wallabag_oauth2_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_oauth2_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `random_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `redirect_uris` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `allowed_grant_types` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_oauth2_clients`
--

LOCK TABLES `wallabag_oauth2_clients` WRITE;
/*!40000 ALTER TABLE `wallabag_oauth2_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallabag_oauth2_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallabag_oauth2_refresh_tokens`
--

DROP TABLE IF EXISTS `wallabag_oauth2_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_oauth2_refresh_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` int(11) DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_20C9FB245F37A13B` (`token`),
  KEY `IDX_20C9FB2419EB6921` (`client_id`),
  KEY `IDX_20C9FB24A76ED395` (`user_id`),
  CONSTRAINT `FK_20C9FB2419EB6921` FOREIGN KEY (`client_id`) REFERENCES `wallabag_oauth2_clients` (`id`),
  CONSTRAINT `FK_20C9FB24A76ED395` FOREIGN KEY (`user_id`) REFERENCES `wallabag_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_oauth2_refresh_tokens`
--

LOCK TABLES `wallabag_oauth2_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `wallabag_oauth2_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallabag_oauth2_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallabag_tag`
--

DROP TABLE IF EXISTS `wallabag_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` longtext COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_4CA58A8C989D9B62` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_tag`
--

LOCK TABLES `wallabag_tag` WRITE;
/*!40000 ALTER TABLE `wallabag_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallabag_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallabag_tagging_rule`
--

DROP TABLE IF EXISTS `wallabag_tagging_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_tagging_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) DEFAULT NULL,
  `rule` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tags` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:simple_array)',
  PRIMARY KEY (`id`),
  KEY `IDX_2D9B3C5424DB0683` (`config_id`),
  CONSTRAINT `FK_2D9B3C5424DB0683` FOREIGN KEY (`config_id`) REFERENCES `wallabag_config` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_tagging_rule`
--

LOCK TABLES `wallabag_tagging_rule` WRITE;
/*!40000 ALTER TABLE `wallabag_tagging_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallabag_tagging_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallabag_user`
--

DROP TABLE IF EXISTS `wallabag_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallabag_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `locked` tinyint(1) NOT NULL,
  `expired` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `credentials_expired` tinyint(1) NOT NULL,
  `credentials_expire_at` datetime DEFAULT NULL,
  `name` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `authCode` int(11) DEFAULT NULL,
  `twoFactorAuthentication` tinyint(1) NOT NULL,
  `trusted` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1D63E7E592FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_1D63E7E5A0D96FBF` (`email_canonical`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallabag_user`
--

LOCK TABLES `wallabag_user` WRITE;
/*!40000 ALTER TABLE `wallabag_user` DISABLE KEYS */;
INSERT INTO `wallabag_user` VALUES (1,'wallabag','wallabag','','',1,'p5gsyhbtw74w8wk8c4wkokccg0w4w0w','gFNVjPkEaJ9Fe1G3liHM5GQhfW17fYy+hzWwmFufj9gSwswzalM+qndrD5j3bXcST/JuNPRAlVm8cELLTz6bKw==',NULL,0,0,NULL,NULL,NULL,'a:2:{i:0;s:9:\"ROLE_USER\";i:1;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,NULL,'2016-04-06 08:30:49','2016-04-06 08:30:49',NULL,0,NULL);
/*!40000 ALTER TABLE `wallabag_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-06  8:34:31
