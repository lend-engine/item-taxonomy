# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.44)
# Database: taxonomy
# Generation Time: 2024-05-31 19:45:09 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table item_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `item_type`;

CREATE TABLE `item_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `emission_factor` decimal(10,2) DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_44EE13D2727ACA70` (`parent_id`),
  CONSTRAINT `FK_44EE13D2727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `item_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `item_type` WRITE;
/*!40000 ALTER TABLE `item_type` DISABLE KEYS */;

INSERT INTO `item_type` (`id`, `parent_id`, `name`, `emission_factor`, `note`)
VALUES
	(1,NULL,'Toys & Games',NULL,NULL),
	(2,NULL,'Garden',1.30,NULL),
	(9,NULL,'Electric & Electronic',1.00,NULL),
	(19,NULL,'Cameras & Optics',NULL,NULL),
	(20,NULL,'Clothing',NULL,NULL),
	(23,NULL,'Sporting Goods',NULL,NULL),
	(24,NULL,'Luggage & Bags',NULL,NULL),
	(25,NULL,'Home',NULL,NULL),
	(26,25,'Kitchen & Dining',NULL,NULL),
	(27,26,'Kitchen utensils',NULL,NULL),
	(28,26,'Kitchen applicances',NULL,NULL),
	(29,26,'Food storage',NULL,NULL),
	(30,26,'Barware',NULL,NULL),
	(31,19,'Cameras',NULL,NULL),
	(32,19,'Lenses',NULL,NULL),
	(33,1,'Outdoor Play Equipment',NULL,NULL),
	(34,1,'Toys',NULL,NULL),
	(35,1,'Games',NULL,NULL),
	(36,1,'Puzzles',NULL,NULL),
	(37,36,'Jigsaw puzzles',NULL,NULL),
	(38,36,'Wooden puzzles',NULL,NULL),
	(39,36,'Metal puzzles',NULL,NULL),
	(40,35,'Board Games',NULL,NULL),
	(41,35,'Card Games',NULL,NULL),
	(42,35,'Portable Electronic Game Devices',NULL,NULL),
	(43,35,'Poker',NULL,NULL),
	(44,35,'Dice Games',NULL,NULL),
	(45,34,'Bath Toys',NULL,NULL),
	(46,34,'Musical Toys',NULL,NULL),
	(47,33,'Playhouses',NULL,NULL),
	(48,33,'Trampolines',NULL,NULL),
	(49,33,'Swing Sets',NULL,NULL),
	(50,33,'Bouncy Castles',NULL,NULL),
	(51,2,'Outdoor Living',NULL,NULL),
	(52,51,'Hammocks',NULL,NULL),
	(53,51,'Garden Furniture',NULL,NULL),
	(54,2,'Gardening',NULL,NULL),
	(55,2,'Outdoor Power Equipment',NULL,NULL),
	(56,55,'Chainsaws',NULL,NULL),
	(57,55,'Pressure Washers',NULL,NULL),
	(58,55,'Snow Blowers',NULL,NULL),
	(59,55,'Hedge Trimmers',NULL,NULL),
	(60,55,'Strimmers / Whippersnippers',NULL,NULL),
	(61,55,'Lawn Mowers',NULL,NULL),
	(62,54,'Gardening Tools',NULL,NULL),
	(63,23,'Exercise & Fitness',NULL,NULL),
	(64,63,'Yoga Mats',NULL,NULL),
	(65,63,'Exercise Balls',NULL,NULL),
	(66,63,'Medicine Balls',NULL,NULL),
	(67,63,'Exercise Bands',NULL,NULL),
	(68,63,'Foam Rollers',NULL,NULL),
	(69,63,'Exercise Steps',NULL,NULL),
	(70,63,'Free Weights',NULL,NULL),
	(71,63,'Balance Trainers',NULL,NULL),
	(72,23,'Indoor Games',NULL,NULL),
	(73,23,'Camping & Hiking',NULL,NULL),
	(74,73,'Tents',NULL,NULL),
	(75,73,'Sleeping Mats',NULL,NULL),
	(76,73,'Hiking Poles',NULL,NULL),
	(77,73,'Camp Cookers',NULL,NULL),
	(78,23,'Fishing',NULL,NULL),
	(79,23,'Cycling',NULL,NULL),
	(80,23,'Climbing',NULL,NULL),
	(81,23,'Winter Sports',NULL,NULL),
	(82,23,'Water Sports',NULL,NULL),
	(83,23,'Beach Games',NULL,NULL),
	(84,83,'Kites',NULL,NULL),
	(85,25,'Household Appliances',NULL,NULL),
	(86,25,'Lighting',NULL,NULL),
	(87,25,'Linens & Bedding',NULL,NULL),
	(88,25,'Decor',NULL,NULL),
	(89,85,'Floor Carpet & Steam Cleaners',NULL,NULL),
	(90,85,'Floor Polishers',NULL,NULL),
	(91,85,'Wallpaper Steamers',NULL,NULL),
	(92,85,'Vacuum Cleaners',NULL,NULL),
	(93,85,'Water Heaters',NULL,NULL),
	(94,85,'Air Conditioners',NULL,NULL),
	(95,85,'Water Purifiers',NULL,NULL),
	(96,85,'Fans',NULL,NULL),
	(97,85,'Space Heaters',NULL,NULL),
	(98,85,'Outdoor Heaters',NULL,NULL),
	(99,85,'Outdoor Misters / Coolers',NULL,NULL),
	(100,NULL,'Entertainment',NULL,NULL),
	(101,100,'Party Supplies',NULL,NULL),
	(102,100,'Visual Effects',NULL,NULL),
	(103,100,'Audio Equipment',NULL,NULL),
	(104,100,'Hobbies & Creative Arts',NULL,NULL),
	(105,104,'Juggling Balls / Skittles',NULL,NULL),
	(106,104,'Magic Sets',NULL,NULL),
	(107,104,'Art & Crafting Tools',NULL,NULL),
	(108,104,'Knitting Equipment',NULL,NULL),
	(109,100,'Homebrewing & Winemaking',NULL,NULL),
	(110,109,'Bottling Bottles',NULL,NULL),
	(111,109,'Fruit Presses',NULL,NULL),
	(112,109,'Beer Brewing Equipment',NULL,NULL),
	(113,109,'Wine Making Equipment',NULL,NULL),
	(114,100,'Musical Instruments',NULL,NULL),
	(115,114,'Brass Instruments',NULL,NULL),
	(116,114,'String Instruments',NULL,NULL),
	(117,114,'Wind Instruments',NULL,NULL),
	(118,114,'Percussion Instruments',NULL,NULL),
	(119,114,'Pianos',NULL,NULL),
	(120,114,'Musical Instrument Accessories',NULL,NULL),
	(121,102,'Fog Machines',NULL,NULL),
	(122,102,'Disco Balls',NULL,NULL),
	(123,102,'Visual Effects Lighting',NULL,NULL),
	(124,NULL,'Business & Industrial',NULL,NULL),
	(125,124,'Safety Equipment',NULL,NULL),
	(126,125,'Protective Eyewear',NULL,NULL),
	(127,125,'Protective Headwear / Hard Hats',NULL,NULL),
	(128,125,'Safety Gloves',NULL,NULL),
	(129,125,'Protective Aprons',NULL,NULL),
	(130,125,'Work Safety Tethers',NULL,NULL),
	(131,125,'Work Safety Harnesses',NULL,NULL),
	(132,125,'Welding Helmets',NULL,NULL),
	(133,9,'Audio',NULL,NULL),
	(134,9,'Video',NULL,NULL),
	(135,9,'Communications',NULL,NULL),
	(136,9,'Computers',NULL,NULL),
	(137,9,'Navigation',NULL,NULL),
	(138,9,'Electrical Accessories',NULL,NULL),
	(139,133,'Stage Equipment',NULL,NULL),
	(140,133,'Audio Players & Recorders',NULL,NULL),
	(141,133,'Public Address (PA) Systems',NULL,NULL),
	(142,133,'DJ & Speciality Audio',NULL,NULL),
	(143,133,'Megaphones',NULL,NULL),
	(144,134,'Video Players & Recorders',NULL,NULL),
	(145,134,'Projectors',NULL,NULL),
	(146,134,'Televisions',NULL,NULL),
	(147,134,'Video Editing Hardware',NULL,NULL),
	(148,134,'Computer Monitors',NULL,NULL),
	(149,9,'Video Game',NULL,NULL),
	(150,149,'Game Consoles',NULL,NULL),
	(151,149,'Game Console Accessories',NULL,NULL),
	(152,35,'Video Games',NULL,NULL),
	(153,NULL,'Furniture',NULL,NULL),
	(154,153,'Benches',NULL,NULL),
	(155,153,'Chairs (Wooden)',NULL,NULL),
	(156,153,'Futons',NULL,NULL),
	(157,153,'Sofas',NULL,NULL),
	(158,153,'Shelving',NULL,NULL),
	(159,153,'Outdoor Furniture',NULL,NULL),
	(160,159,'Outdoor Tables',NULL,NULL),
	(161,159,'Outdoor Chairs',NULL,NULL),
	(162,159,'Outdoor Storage Boxes',NULL,NULL),
	(163,153,'Baby & Toddler Furniture',NULL,NULL),
	(164,163,'High Chairs',NULL,NULL),
	(165,163,'Booster Seats',NULL,NULL),
	(166,163,'Cribs & Cradles',NULL,NULL),
	(167,163,'Cots & Toddler Beds',NULL,NULL),
	(168,153,'Office Furniture',NULL,NULL),
	(169,153,'Chairs (Metal)',NULL,NULL),
	(170,NULL,'Health & Beauty',NULL,NULL),
	(171,170,'Hearing Aids',NULL,NULL),
	(172,170,'Incontinence Aids',NULL,NULL),
	(173,170,'Medical Alarm Systems',NULL,NULL),
	(174,170,'Bed Pans',NULL,NULL),
	(175,170,'Light Therapy Lamps',NULL,NULL),
	(176,170,'Biometric Monitors',NULL,NULL),
	(177,176,'Bathroom Scales',NULL,NULL),
	(178,176,'Blood Pressure Monitors',NULL,NULL),
	(179,176,'Medical Thermometers',NULL,NULL),
	(180,176,'Blood Glucose Meters',NULL,NULL),
	(181,176,'Activity Monitors',NULL,NULL),
	(182,176,'Heart Rate Monitors',NULL,NULL),
	(183,170,'Mobility & Accessibility',NULL,NULL),
	(184,183,'Wheelchairs',NULL,NULL),
	(185,183,'Walking Aids',NULL,NULL),
	(186,183,'Accessibility Furniture',NULL,NULL),
	(187,170,'Supports & Braces',NULL,NULL),
	(188,170,'Pill Boxes',NULL,NULL),
	(189,170,'Physical Therapy Equipment',NULL,NULL),
	(190,NULL,'Baby & Toddler',NULL,NULL),
	(191,190,'Baby Monitors',NULL,NULL),
	(192,190,'Baby & Pet Safety Gates',NULL,NULL),
	(193,190,'Baby Safety Locks',NULL,NULL),
	(194,190,'Nappies / Diapers',NULL,NULL),
	(195,190,'Baby Carriers',NULL,NULL),
	(196,190,'Pushchairs & Prams',NULL,NULL),
	(197,190,'Baby Baths',NULL,NULL),
	(198,135,'Misc Communications Equipment',NULL,NULL),
	(199,136,'Laptops',NULL,NULL),
	(200,136,'Desktop Computers',NULL,NULL),
	(201,136,'Keyboards',NULL,NULL),
	(202,136,'Computer Mice',NULL,NULL),
	(203,136,'Tablet Computers',NULL,NULL),
	(204,9,'Print, Copy, Scan & Fax',NULL,NULL),
	(205,204,'3D Printers',NULL,NULL),
	(206,204,'Scanners',NULL,NULL),
	(207,204,'Photocopiers',NULL,NULL),
	(208,NULL,'_raw',NULL,NULL),
	(209,208,'Metal Items',NULL,NULL),
	(210,208,'Plastic Items',NULL,NULL),
	(211,208,'Wooden Items',NULL,NULL),
	(212,208,'Rubber Items',NULL,NULL),
	(213,137,'GPS Tracking Equipment',NULL,NULL),
	(214,137,'Sat Nav & GPS Equipment',NULL,NULL),
	(215,73,'Compasses',NULL,NULL),
	(216,73,'Camping Cookware',NULL,NULL),
	(217,73,'Sleeping Bags',NULL,NULL),
	(218,78,'Fishing Rods',NULL,NULL),
	(219,78,'Fishing Nets',NULL,NULL),
	(220,78,'Fishing Reels & Accessories',NULL,NULL),
	(221,78,'Spearfishing Guns',NULL,NULL),
	(222,79,'Bicycles / Bikes',NULL,NULL),
	(223,79,'Unicycles',NULL,NULL),
	(224,79,'Cycle Helmets',NULL,NULL),
	(225,79,'Cycle Clothing',NULL,NULL),
	(226,80,'Climbing Ropes',NULL,NULL),
	(227,80,'Climbing Harnesses',NULL,NULL),
	(228,80,'Climbing Hardware',NULL,NULL),
	(229,80,'Climbing Helmets',NULL,NULL),
	(230,80,'Ice Climbing Tools',NULL,NULL),
	(231,80,'Ice Screws',NULL,NULL),
	(232,23,'Skating & Skateboarding',NULL,NULL),
	(233,232,'Inline Skates',NULL,NULL),
	(234,232,'Roller Skates',NULL,NULL),
	(235,232,'Skateboards',NULL,NULL),
	(236,232,'Roller Skis',NULL,NULL),
	(237,82,'Surf Boards',NULL,NULL),
	(238,82,'Wetsuits',NULL,NULL),
	(239,82,'Body Boards',NULL,NULL),
	(240,82,'Kayaks',NULL,NULL),
	(241,82,'SUPs',NULL,NULL),
	(242,82,'Lifejackets',NULL,NULL),
	(243,82,'Drysuits',NULL,NULL),
	(244,72,'Bowling Balls',NULL,NULL),
	(245,72,'Skittles',NULL,NULL),
	(246,72,'Dartboards & Darts',NULL,NULL),
	(247,72,'Ping Pong Bats & Balls',NULL,NULL),
	(248,81,'Skis - Downhill',NULL,NULL),
	(249,81,'Snowboards',NULL,NULL),
	(250,81,'Sledges',NULL,NULL),
	(251,81,'Snowshoes',NULL,NULL),
	(252,81,'Ski Poles',NULL,NULL),
	(253,81,'Skis - Cross Country',NULL,NULL),
	(254,81,'Avalance Safety Equipment',NULL,NULL),
	(255,83,'Beach Bats & Balls',NULL,NULL),
	(256,23,'Sports Equipment',NULL,NULL),
	(257,256,'Racquets - Generic',NULL,NULL),
	(258,256,'Ball - Generic',NULL,'Football, basketball, netball, volleyball'),
	(259,256,'Net - Generic',NULL,NULL),
	(260,256,'Bats - Generic',NULL,'Baseball, Cricket, Rounders'),
	(261,256,'Cricket Stumps',NULL,NULL),
	(262,256,'Sports Pads',NULL,NULL),
	(263,256,'Sports Helmets',NULL,NULL);

/*!40000 ALTER TABLE `item_type` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
