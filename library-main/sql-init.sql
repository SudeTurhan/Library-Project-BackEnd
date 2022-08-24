-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 02, 2022 at 12:34 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `django`
--

-- --------------------------------------------------------

--
-- Table structure for table `api_book`
--

DROP TABLE IF EXISTS `api_book`;
CREATE TABLE IF NOT EXISTS `api_book` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) COLLATE utf8_bin NOT NULL,
  `genre` varchar(100) COLLATE utf8_bin NOT NULL,
  `stock` bigint(20) UNSIGNED NOT NULL,
  `page_number` varchar(2000) COLLATE utf8_bin NOT NULL,
  `publication_year` varchar(4) COLLATE utf8_bin NOT NULL,
  `subject` longtext COLLATE utf8_bin,
  `daily_price` double NOT NULL,
  `author_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `api_book_author_id_85dc432b_fk_api_customuser_id` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `api_comment`
--

DROP TABLE IF EXISTS `api_comment`;
CREATE TABLE IF NOT EXISTS `api_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comment` longtext COLLATE utf8_bin NOT NULL,
  `comment_date` datetime(6) NOT NULL,
  `book_id` bigint(20) NOT NULL,
  `member_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `api_comment_book_id_8fa90b67_fk_api_book_id` (`book_id`),
  KEY `api_comment_member_id_663b2d9b_fk_api_customuser_id` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `api_customuser`
--

DROP TABLE IF EXISTS `api_customuser`;
CREATE TABLE IF NOT EXISTS `api_customuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_bin NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8_bin NOT NULL,
  `first_name` varchar(150) COLLATE utf8_bin NOT NULL,
  `last_name` varchar(150) COLLATE utf8_bin NOT NULL,
  `email` varchar(254) COLLATE utf8_bin NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `biography` longtext COLLATE utf8_bin,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `api_customuser`
--

INSERT INTO `api_customuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `biography`) VALUES
(1, 'pbkdf2_sha256$320000$pzpzovLLTZsH8vIJ4ONUO2$Pjy9uWNkYpOoOSfSFtbuB6v8pcyIw2KCZHHfMn31YB4=', '2022-02-02 11:46:45.000000', 1, 'Claush', '', '', '', 1, 1, '2022-02-02 11:46:28.000000', '');

-- --------------------------------------------------------

--
-- Table structure for table `api_customuser_groups`
--

DROP TABLE IF EXISTS `api_customuser_groups`;
CREATE TABLE IF NOT EXISTS `api_customuser_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_customuser_groups_customuser_id_group_id_d5b0c2ab_uniq` (`customuser_id`,`group_id`),
  KEY `api_customuser_groups_group_id_f049027c_fk_auth_group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `api_customuser_groups`
--

INSERT INTO `api_customuser_groups` (`id`, `customuser_id`, `group_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `api_customuser_user_permissions`
--

DROP TABLE IF EXISTS `api_customuser_user_permissions`;
CREATE TABLE IF NOT EXISTS `api_customuser_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_customuser_user_perm_customuser_id_permission_9deacd8d_uniq` (`customuser_id`,`permission_id`),
  KEY `api_customuser_user__permission_id_8735d73e_fk_auth_perm` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `api_payment`
--

DROP TABLE IF EXISTS `api_payment`;
CREATE TABLE IF NOT EXISTS `api_payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `process_id` bigint(20) NOT NULL,
  `credit_card` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `method` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `api_payment_process_id_88120502_fk_api_rentlogs_id` (`process_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `api_rentlogs`
--

DROP TABLE IF EXISTS `api_rentlogs`;
CREATE TABLE IF NOT EXISTS `api_rentlogs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `due` date NOT NULL,
  `is_paid` tinyint(1) NOT NULL,
  `daily_price` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `api_rentlogs_book`
--

DROP TABLE IF EXISTS `api_rentlogs_book`;
CREATE TABLE IF NOT EXISTS `api_rentlogs_book` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rentlogs_id` bigint(20) NOT NULL,
  `book_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_rentlogs_book_rentlogs_id_book_id_818e7e2e_uniq` (`rentlogs_id`,`book_id`),
  KEY `api_rentlogs_book_book_id_f71f0682_fk_api_book_id` (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `api_rentlogs_member`
--

DROP TABLE IF EXISTS `api_rentlogs_member`;
CREATE TABLE IF NOT EXISTS `api_rentlogs_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rentlogs_id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_rentlogs_member_rentlogs_id_customuser_id_ae25ecf4_uniq` (`rentlogs_id`,`customuser_id`),
  KEY `api_rentlogs_member_customuser_id_04752f84_fk_api_customuser_id` (`customuser_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'Author'),
(2, 'Librarian'),
(3, 'Member');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `auth_group_permissions`
--

INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13),
(14, 1, 14),
(15, 1, 15),
(16, 1, 16),
(17, 1, 17),
(18, 1, 18),
(19, 1, 19),
(20, 1, 20),
(21, 1, 21),
(22, 1, 22),
(23, 1, 23),
(24, 1, 24),
(25, 2, 1),
(26, 2, 2),
(27, 2, 3),
(28, 2, 4),
(29, 2, 5),
(30, 2, 6),
(31, 2, 7),
(32, 2, 8),
(33, 2, 9),
(34, 2, 10),
(35, 2, 11),
(36, 2, 12),
(37, 2, 13),
(38, 2, 14),
(39, 2, 15),
(40, 2, 16),
(41, 2, 17),
(42, 2, 18),
(43, 2, 19),
(44, 2, 20),
(45, 2, 21),
(46, 2, 22),
(47, 2, 23),
(48, 2, 24),
(49, 3, 1),
(50, 3, 2),
(51, 3, 3),
(52, 3, 4),
(53, 3, 5),
(54, 3, 6),
(55, 3, 7),
(56, 3, 8),
(57, 3, 9),
(58, 3, 10),
(59, 3, 11),
(60, 3, 12),
(61, 3, 13),
(62, 3, 14),
(63, 3, 15),
(64, 3, 16),
(65, 3, 17),
(66, 3, 18),
(67, 3, 19),
(68, 3, 20),
(69, 3, 21),
(70, 3, 22),
(71, 3, 23),
(72, 3, 24);

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_customuser'),
(22, 'Can change user', 6, 'change_customuser'),
(23, 'Can delete user', 6, 'delete_customuser'),
(24, 'Can view user', 6, 'view_customuser'),
(25, 'Can add payment', 7, 'add_payment'),
(26, 'Can change payment', 7, 'change_payment'),
(27, 'Can delete payment', 7, 'delete_payment'),
(28, 'Can view payment', 7, 'view_payment'),
(29, 'Can add book', 8, 'add_book'),
(30, 'Can change book', 8, 'change_book'),
(31, 'Can delete book', 8, 'delete_book'),
(32, 'Can view book', 8, 'view_book'),
(33, 'Can add rent logs', 9, 'add_rentlogs'),
(34, 'Can change rent logs', 9, 'change_rentlogs'),
(35, 'Can delete rent logs', 9, 'delete_rentlogs'),
(36, 'Can view rent logs', 9, 'view_rentlogs'),
(37, 'Can add comment', 10, 'add_comment'),
(38, 'Can change comment', 10, 'change_comment'),
(39, 'Can delete comment', 10, 'delete_comment'),
(40, 'Can view comment', 10, 'view_comment');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8_bin,
  `object_repr` varchar(200) COLLATE utf8_bin NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext COLLATE utf8_bin NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_api_customuser_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2022-02-02 11:46:54.961981', '1', 'Author', 1, '[{\"added\": {}}]', 3, 1),
(2, '2022-02-02 11:47:01.481391', '2', 'Librarian', 1, '[{\"added\": {}}]', 3, 1),
(3, '2022-02-02 11:47:05.777568', '3', 'Member', 1, '[{\"added\": {}}]', 3, 1),
(4, '2022-02-02 12:05:26.271942', '1', 'Claush', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8_bin NOT NULL,
  `model` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(8, 'api', 'book'),
(10, 'api', 'comment'),
(6, 'api', 'customuser'),
(7, 'api', 'payment'),
(9, 'api', 'rentlogs'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8_bin NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2022-02-02 11:45:54.191696'),
(2, 'contenttypes', '0002_remove_content_type_name', '2022-02-02 11:45:54.327729'),
(3, 'auth', '0001_initial', '2022-02-02 11:45:54.736152'),
(4, 'auth', '0002_alter_permission_name_max_length', '2022-02-02 11:45:54.816173'),
(5, 'auth', '0003_alter_user_email_max_length', '2022-02-02 11:45:54.824174'),
(6, 'auth', '0004_alter_user_username_opts', '2022-02-02 11:45:54.832176'),
(7, 'auth', '0005_alter_user_last_login_null', '2022-02-02 11:45:54.840179'),
(8, 'auth', '0006_require_contenttypes_0002', '2022-02-02 11:45:54.848180'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2022-02-02 11:45:54.856183'),
(10, 'auth', '0008_alter_user_username_max_length', '2022-02-02 11:45:54.864185'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2022-02-02 11:45:54.872187'),
(12, 'auth', '0010_alter_group_name_max_length', '2022-02-02 11:45:54.944203'),
(13, 'auth', '0011_update_proxy_permissions', '2022-02-02 11:45:54.952205'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2022-02-02 11:45:54.960207'),
(15, 'api', '0001_initial', '2022-02-02 11:45:55.512349'),
(16, 'admin', '0001_initial', '2022-02-02 11:45:55.832723'),
(17, 'admin', '0002_logentry_remove_auto_add', '2022-02-02 11:45:55.848724'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2022-02-02 11:45:55.872733'),
(19, 'sessions', '0001_initial', '2022-02-02 11:45:56.000766'),
(20, 'api', '0002_book_rentlogs_payment_comment', '2022-02-02 11:59:55.720917'),
(21, 'api', '0003_alter_rentlogs_member', '2022-02-02 12:03:07.160166'),
(22, 'api', '0004_payment_credit_card_payment_method_and_more', '2022-02-02 12:08:53.210228');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) COLLATE utf8_bin NOT NULL,
  `session_data` longtext COLLATE utf8_bin NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('qzij1beo1xvp6yps44pxsia1b8x5lm6v', '.eJxVjDsOwjAQBe_iGll2_Kek5wzWeneDA8iR4qRC3B0ipYD2zcx7iQzbWvPWeckTibPQ4vS7FcAHtx3QHdptlji3dZmK3BV50C6vM_Hzcrh_BxV6_dZsPSfLmkBhGLzDQfk4Kgs6UEHL0dLoDEJibdgRBmuItE-ONEMsRrw_71I4YA:1nFE61:5GesXSHZ643Y4ftRSBkwprLw3ryJT9aNA-I4eje-iCo', '2022-02-16 11:46:45.673763');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_book`
--
ALTER TABLE `api_book`
  ADD CONSTRAINT `api_book_author_id_85dc432b_fk_api_customuser_id` FOREIGN KEY (`author_id`) REFERENCES `api_customuser` (`id`);

--
-- Constraints for table `api_comment`
--
ALTER TABLE `api_comment`
  ADD CONSTRAINT `api_comment_book_id_8fa90b67_fk_api_book_id` FOREIGN KEY (`book_id`) REFERENCES `api_book` (`id`),
  ADD CONSTRAINT `api_comment_member_id_663b2d9b_fk_api_customuser_id` FOREIGN KEY (`member_id`) REFERENCES `api_customuser` (`id`);

--
-- Constraints for table `api_customuser_groups`
--
ALTER TABLE `api_customuser_groups`
  ADD CONSTRAINT `api_customuser_group_customuser_id_9eb4b783_fk_api_custo` FOREIGN KEY (`customuser_id`) REFERENCES `api_customuser` (`id`),
  ADD CONSTRAINT `api_customuser_groups_group_id_f049027c_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `api_customuser_user_permissions`
--
ALTER TABLE `api_customuser_user_permissions`
  ADD CONSTRAINT `api_customuser_user__customuser_id_5365c9ba_fk_api_custo` FOREIGN KEY (`customuser_id`) REFERENCES `api_customuser` (`id`),
  ADD CONSTRAINT `api_customuser_user__permission_id_8735d73e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Constraints for table `api_payment`
--
ALTER TABLE `api_payment`
  ADD CONSTRAINT `api_payment_process_id_88120502_fk_api_rentlogs_id` FOREIGN KEY (`process_id`) REFERENCES `api_rentlogs` (`id`);

--
-- Constraints for table `api_rentlogs_book`
--
ALTER TABLE `api_rentlogs_book`
  ADD CONSTRAINT `api_rentlogs_book_book_id_f71f0682_fk_api_book_id` FOREIGN KEY (`book_id`) REFERENCES `api_book` (`id`),
  ADD CONSTRAINT `api_rentlogs_book_rentlogs_id_be9d0cdf_fk_api_rentlogs_id` FOREIGN KEY (`rentlogs_id`) REFERENCES `api_rentlogs` (`id`);

--
-- Constraints for table `api_rentlogs_member`
--
ALTER TABLE `api_rentlogs_member`
  ADD CONSTRAINT `api_rentlogs_member_customuser_id_04752f84_fk_api_customuser_id` FOREIGN KEY (`customuser_id`) REFERENCES `api_customuser` (`id`),
  ADD CONSTRAINT `api_rentlogs_member_rentlogs_id_d79e7846_fk_api_rentlogs_id` FOREIGN KEY (`rentlogs_id`) REFERENCES `api_rentlogs` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_api_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `api_customuser` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
