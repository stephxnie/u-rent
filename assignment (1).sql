-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 09, 2026 at 07:40 AM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `assignment`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for admin login',
  `name` varchar(50) NOT NULL COMMENT 'Name for admin',
  `email` varchar(100) NOT NULL COMMENT 'Email address of admin',
  `password` varchar(255) NOT NULL COMMENT 'Password for admin login',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `name`, `email`, `password`) VALUES
('AD0001', 'John', 'john@gmail.com', '0001'),
('AD0002', 'Lily Tan', 'lilytan@gmail.com', 'lilytan'),
('AD0003', 'Nelson', 'nelson@gmail.com', 'nelson3');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each category',
  `category_name` varchar(50) NOT NULL COMMENT 'Title of the item',
  `co2_save` decimal(8,2) NOT NULL COMMENT 'Estimated CO2 (in kg) saved for specific category',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `co2_save`) VALUES
('CG0001', 'Electronics', 15.00),
('CG0002', 'Books', 2.50),
('CG0003', 'Furniture', 40.00),
('CG0004', 'Tools', 18.00),
('CG0005', 'Others', 10.00);

-- --------------------------------------------------------

--
-- Table structure for table `challenge`
--

DROP TABLE IF EXISTS `challenge`;
CREATE TABLE IF NOT EXISTS `challenge` (
  `challenge_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each challenge',
  `title` varchar(255) NOT NULL COMMENT 'Title of the challenge',
  `description` text NOT NULL COMMENT 'Detailed explanation of the challenge',
  `point` int NOT NULL COMMENT 'Points rewarded for each challenge',
  `start_date` datetime NOT NULL COMMENT 'The date and time the user accepted this challenge',
  `end_date` datetime NOT NULL COMMENT 'The date and time the user marked the challenge as complete',
  `image` text NOT NULL COMMENT 'Image of the challenge',
  `admin_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references admin_id in Admin',
  PRIMARY KEY (`challenge_id`),
  KEY `challenge_admin` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `challenge`
--

INSERT INTO `challenge` (`challenge_id`, `title`, `description`, `point`, `start_date`, `end_date`, `image`, `admin_id`) VALUES
('CH0001', '1 Week Rent Instead of Buy', 'Rent any item from the marketplace instead of purchasing a new one to reduce waste in one week.', 150, '2025-12-01 00:00:00', '2025-12-07 23:59:59', 'rent_instead_buy.png', 'AD0001'),
('CH0002', 'List Your First Item', 'Upload and list your first rentable item.', 100, '2025-12-03 00:00:00', '2025-12-07 23:59:59', 'challenge02.jpg\r\n', 'AD0001'),
('CH0003', 'Student Budget Saver', 'Rent study-related items instead of buying them.', 250, '2025-12-10 00:00:00', '2025-12-17 23:59:59', 'challenge03.png', 'AD0002'),
('CH0004', 'Welcome to U-Rent', 'Welcome to our U-Rent. This is just for the first time user.', 1000, '2026-01-08 00:00:00', '2026-01-08 00:00:00', 'welcome.jpg', 'AD0001');

-- --------------------------------------------------------

--
-- Table structure for table `donation`
--

DROP TABLE IF EXISTS `donation`;
CREATE TABLE IF NOT EXISTS `donation` (
  `donation_id` varchar(4) NOT NULL COMMENT 'Primary Key, unique identifier for each Donation',
  `item` varchar(255) NOT NULL COMMENT 'Title of the item',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Category of the item',
  `description` text NOT NULL COMMENT 'Detailed description of the item',
  `conditions` text NOT NULL COMMENT 'Condition of the donation item',
  `image` text NOT NULL COMMENT 'Image of the donation item',
  `status` enum('Pending Verification','Verified','Rejected') NOT NULL COMMENT 'Current availability status of the item',
  `user_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references user_id in User',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `collection_date` date DEFAULT NULL,
  `collection_time` time DEFAULT NULL,
  `collection_location` text,
  `gv_id` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`donation_id`),
  KEY `donation_user` (`user_id`),
  KEY `donation_gv` (`gv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `donation`
--

INSERT INTO `donation` (`donation_id`, `item`, `category`, `description`, `conditions`, `image`, `status`, `user_id`, `date`, `collection_date`, `collection_time`, `collection_location`, `gv_id`) VALUES
('D001', 'DSLR Camera', 'Electronics', 'Canon DSLR camera suitable for beginners, lightly used.', 'Good', 'DSLR.avif\r\n', 'Verified', 'TP0001', '2026-01-04 14:22:58', '2026-01-23', '12:01:00', 'Apu residence', 'GV0001'),
('D002', 'Dress', 'Clothing', 'Worn only few times. Fabric is intact, with no visible stain and damage. Suitable for casual or semi-formal wear', 'Good', 'donation_695df948a05305.94758961.png', 'Pending Verification', 'TP0003', '2026-01-07 14:12:24', '2026-01-09', '10:55:00', 'Apu residence', 'GV0001'),
('D003', 'Percy Jackson Novel Set', 'Books', 'Pre-loved and well-kept. Pages are clean and readable, covers show light signs of use only. Suitable for young readers and fans of fantasy.', 'Good', 'donation_695df9eb7e9944.71231343.jpg', 'Pending Verification', 'TP0003', '2026-01-07 14:15:07', NULL, NULL, NULL, NULL),
('D004', 'Headphones', 'Electronics', 'In good working condition, no major damage', 'Well-worn', 'donation_695dfad309b3b9.19569053.jpg', 'Pending Verification', 'TP0004', '2026-01-07 14:18:59', NULL, NULL, NULL, NULL),
('D005', 'Toolbox', 'Tools', 'Used toolbox suitable for storing hand tools and accessories. Structurally intact with secure locks', 'Used', 'donation_695dfb790e4237.38579331.jpg', 'Pending Verification', 'TP0003', '2026-01-07 14:21:45', NULL, NULL, NULL, NULL),
('D006', 'Beanbag', 'Furniture', 'Comfortable and still good in shape. No major tears', 'Used', 'donation_695dfc06b88ad0.80988614.jpg', 'Pending Verification', 'TP0002', '2026-01-07 14:24:06', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ecoimpact`
--

DROP TABLE IF EXISTS `ecoimpact`;
CREATE TABLE IF NOT EXISTS `ecoimpact` (
  `eco_impact_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each eco impact record',
  `total_co2_save` decimal(8,2) NOT NULL COMMENT 'Total Estimated CO2 (in kg) saved for this specific rental transaction.',
  `record_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references record_id in Record',
  PRIMARY KEY (`eco_impact_id`),
  KEY `ecoimpact_record` (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `ecoimpact`
--

INSERT INTO `ecoimpact` (`eco_impact_id`, `total_co2_save`, `record_id`) VALUES
('EI002', 1.20, 'RC0003'),
('EI003', 0.80, 'RC0004'),
('EI004', 0.50, 'RC0005'),
('EI005', 0.60, 'RC0006'),
('EI006', 0.30, 'RC0007');

-- --------------------------------------------------------

--
-- Table structure for table `ecopoint`
--

DROP TABLE IF EXISTS `ecopoint`;
CREATE TABLE IF NOT EXISTS `ecopoint` (
  `eco_point_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each Ecopoint',
  `point` int NOT NULL COMMENT 'The number of Eco-Points that were deducted or earned from the user''s account',
  `source_type` enum('Challenge','Donation','Reward') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The type of source ',
  `source_id` varchar(6) NOT NULL COMMENT 'Id of the source',
  `user_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references user_id in User',
  PRIMARY KEY (`eco_point_id`),
  KEY `ecopoint_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `ecopoint`
--

INSERT INTO `ecopoint` (`eco_point_id`, `point`, `source_type`, `source_id`, `user_id`) VALUES
('EP0001', 100, 'Challenge', 'CH0001', 'TP0001'),
('EP0002', -100, 'Reward', 'RW0001', 'TP0001'),
('EP0003', 1000, 'Challenge', 'CH0004', 'TP0001'),
('EP0004', 1000, 'Challenge', 'CH0004', 'TP0003'),
('EP0005', 1000, 'Challenge', 'CH0004', 'TP0002'),
('EP0006', 1000, 'Challenge', 'CH0004', 'TP0004'),
('EP0007', 5, 'Donation', 'D002', 'TP0003'),
('EP0008', 30, 'Donation', 'D001', 'TP0001'),
('EP0009', 250, 'Challenge', 'CH0003', 'TP0001');

-- --------------------------------------------------------

--
-- Table structure for table `greenverifier`
--

DROP TABLE IF EXISTS `greenverifier`;
CREATE TABLE IF NOT EXISTS `greenverifier` (
  `gv_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each green verifier login',
  `name` varchar(50) NOT NULL COMMENT 'Name for green verifier',
  `email` varchar(100) NOT NULL COMMENT 'Email address of green verifier',
  `password` varchar(255) NOT NULL COMMENT 'Password for green verifier login',
  PRIMARY KEY (`gv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `greenverifier`
--

INSERT INTO `greenverifier` (`gv_id`, `name`, `email`, `password`) VALUES
('GV0001', 'Alan', 'alan@gmail.com', 'Alan1'),
('GV0002', 'Julia', 'julia@gmail.com', 'julia02'),
('GV0003', 'Charlie', 'charlie@gmail.com', 'charlie03');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `item_id` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Primary Key, unique identifier for each item',
  `item_name` varchar(50) NOT NULL COMMENT 'Title of the item',
  `price` decimal(5,2) NOT NULL COMMENT 'Price of the item',
  `status` enum('Available','Unavailable','Pending') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Current availability status of the item',
  `details` text NOT NULL COMMENT 'Detailed description of the item',
  `deposit` decimal(5,2) NOT NULL COMMENT 'Security deposit amount',
  `image` text NOT NULL COMMENT 'Image of the item',
  `meet_up_point` text NOT NULL COMMENT 'Address or location of meet up',
  `user_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references user_id in User',
  `category_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references user_id in Category',
  PRIMARY KEY (`item_id`),
  KEY `item_user` (`user_id`),
  KEY `item_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_id`, `item_name`, `price`, `status`, `details`, `deposit`, `image`, `meet_up_point`, `user_id`, `category_id`) VALUES
('A001', 'Canon EOS R5 Mirrorless', 140.00, 'Available', 'Excellent condition. Comes with one battery, charger and a 64GB SD Card. Lens not included.', 50.00, 'pictures/A001.avif', 'Block A, Room 1', 'TP0002', 'CG0001'),
('A002', 'Python Programming Textbook', 35.00, 'Available', 'Beginner-friendly Python programming textbook covering basics, data structures, functions, and simple projects. Suitable for university students.', 15.00, 'pictures/textbook.jpg', 'Library', 'TP0001', 'CG0002'),
('A003', 'Adjustable Study Table', 20.00, 'Available', 'Sturdy adjustable study table suitable for home study or dorm use. Clean and well-maintained.', 10.00, 'pictures/study_table.jpg', 'APU Residence Lobby', 'TP0001', 'CG0003'),
('A004', 'Bluetooth Speaker', 25.00, 'Available', 'Portable waterproof speaker with high-quality sound and long battery life.', 10.00, 'pictures/bluetooth speaker.png', 'Block E, Room 2', 'TP0004', 'CG0001'),
('A005', 'Folding Table', 15.00, 'Pending', 'Lightweight and portable table for events or temporary setups.', 10.00, 'pictures/Folder Table.jpg', 'Block C, Room 3', 'TP0002', 'CG0003'),
('A006', 'Toolbox Set', 20.00, 'Available', 'Includes screwdrivers, hammer, pilers, and basic repair tools.', 15.00, 'pictures/toolbox set.png', 'Block B, Room 1', 'TP0004', 'CG0004');

-- --------------------------------------------------------

--
-- Table structure for table `itemaction`
--

DROP TABLE IF EXISTS `itemaction`;
CREATE TABLE IF NOT EXISTS `itemaction` (
  `item_action_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each ItemAction',
  `action_type` enum('Approved','Rejected','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The type of action took for the item',
  `reason` text NOT NULL COMMENT 'Reason of the chosen action',
  `item_id` varchar(4) NOT NULL COMMENT 'Foreign Key, references item_id in Item',
  `admin_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references admin_id in Admin',
  PRIMARY KEY (`item_action_id`),
  KEY `itemaction_item` (`item_id`),
  KEY `itemaction_admin` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `itemaction`
--

INSERT INTO `itemaction` (`item_action_id`, `action_type`, `reason`, `item_id`, `admin_id`) VALUES
('IA001', 'Approved', 'Item meets all requirements', 'A004', 'AD0003');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
CREATE TABLE IF NOT EXISTS `notification` (
  `notification_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each notification',
  `recipient_role` enum('Owner','Rentel','Admin','Green Verifier') NOT NULL COMMENT 'Role of the recipients',
  `title` varchar(50) NOT NULL COMMENT 'Title of the notification',
  `message` text NOT NULL COMMENT 'Messages for the recipients',
  `reference_type` enum('Tree','Donation','Challenge','Reward','Repair','Report','Rental','Verification') NOT NULL COMMENT 'Type of the reference',
  `reference_id` varchar(8) NOT NULL COMMENT 'Reference id of the notification',
  `status` enum('Unread','Read') NOT NULL COMMENT 'Status of the notification',
  `update_time` datetime NOT NULL COMMENT 'Date and time of the notification sent',
  `user_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references user_id in User',
  PRIMARY KEY (`notification_id`),
  KEY `notification_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`notification_id`, `recipient_role`, `title`, `message`, `reference_type`, `reference_id`, `status`, `update_time`, `user_id`) VALUES
('NT0001', 'Owner', 'Tree planted!', 'Your donated tree has been planted! Check the planting progress in the Tree Status Page.', 'Tree', 'TR0001', 'Read', '2025-12-30 16:00:00', 'TP0001'),
('NT0002', 'Owner', 'Joining Successfully!', 'Congrats, you have joined the Welcome challenge successfully and 1000 eco points recorded!', 'Challenge', 'CH0004', 'Unread', '2026-01-08 02:09:11', 'TP0001'),
('NT0003', 'Owner', 'Joining Successfully!', 'Congrats, you have joined the Welcome challenge successfully and 1000 eco points recorded!', 'Challenge', 'CH0004', 'Unread', '2026-01-08 02:09:11', 'TP0002'),
('NT0004', 'Owner', 'Joining Successfully!', 'Congrats, you have joined the Welcome challenge successfully and 1000 eco points recorded!', 'Challenge', 'CH0004', 'Unread', '2026-01-08 02:12:26', 'TP0003'),
('NT0005', 'Owner', 'Joining Successfully!', 'Congrats, you have joined the Welcome challenge successfully and 1000 eco points recorded!', 'Challenge', 'CH0004', 'Unread', '2026-01-08 02:12:26', 'TP0004');

-- --------------------------------------------------------

--
-- Table structure for table `record`
--

DROP TABLE IF EXISTS `record`;
CREATE TABLE IF NOT EXISTS `record` (
  `record_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each record',
  `start_date` datetime NOT NULL COMMENT 'Date and time that the rental period officially begins',
  `return_date` datetime NOT NULL COMMENT 'Date and time that the rental period officially ended',
  `status` enum('Pending','Active','Complete','Cancelled','Overdue') NOT NULL COMMENT 'Current stage of the rental transaction',
  `item_id` varchar(4) NOT NULL COMMENT 'Foreign Key, references item_id in Item',
  `user_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references user_id in User',
  PRIMARY KEY (`record_id`),
  KEY `record_item` (`item_id`),
  KEY `record_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `record`
--

INSERT INTO `record` (`record_id`, `start_date`, `return_date`, `status`, `item_id`, `user_id`) VALUES
('RC0003', '2026-01-10 10:00:00', '2026-01-08 23:07:47', 'Complete', 'A001', 'TP0001'),
('RC0004', '2026-01-15 09:00:00', '2026-01-09 15:11:16', 'Complete', 'A002', 'TP0002'),
('RC0005', '2026-01-20 08:30:00', '2026-01-22 18:00:00', 'Active', 'A003', 'TP0003'),
('RC0006', '2026-01-25 11:00:00', '2026-01-27 19:00:00', 'Active', 'A004', 'TP0002'),
('RC0007', '2026-02-01 09:00:00', '2026-02-03 17:00:00', 'Active', 'A005', 'TP0003'),
('RC0008', '2026-01-07 11:57:57', '2026-01-09 15:17:50', 'Complete', 'A006', 'TP0001');

-- --------------------------------------------------------

--
-- Table structure for table `repair`
--

DROP TABLE IF EXISTS `repair`;
CREATE TABLE IF NOT EXISTS `repair` (
  `repair_id` varchar(6) NOT NULL,
  `project_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text NOT NULL,
  `status` enum('Pending','Under Review','Approved','Rejected') NOT NULL,
  `image` text NOT NULL,
  `user_id` varchar(6) NOT NULL,
  `gv_id` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reason` text,
  PRIMARY KEY (`repair_id`),
  KEY `repair_user` (`user_id`),
  KEY `repair_gv` (`gv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `repair`
--

INSERT INTO `repair` (`repair_id`, `project_title`, `description`, `status`, `image`, `user_id`, `gv_id`, `date`, `reason`) VALUES
('RE0001', 'How to fix Broken Chair', 'Learn simple techniques to repair a broken chair.', 'Pending', 'chair.jpg', 'TP0001', 'GV0001', '2026-01-04 14:25:02', NULL),
('RE0002', 'Laptop - Battery issue', 'Battery drains quickly and does not hold charge for long.\r\n\r\nSteps to Fix:\r\n1. Check battery health through system settings.\r\n2. Update the laptop’s operating system and drivers.\r\n3. Calibrate the battery by fully charging and discharging once.\r\n4. Replace the battery if the issue persists.', 'Pending', 'blog-laptop-needs-new-battery1.jpg', 'TP0001', NULL, '2026-01-07 14:29:40', NULL),
('RE0003', 'Mobile Phone – Cracked Screen', 'Screen is cracked but touch functionality still works.\r\n\r\nSteps to Fix:\r\n1. Back up all data.\r\n2. Power off the phone.\r\n3. Remove the damaged screen using proper tools.\r\n4. Install a replacement screen.\r\n5. Power on and test display and touch.', 'Pending', '1000_F_416530715_MnAq8xMrZP5hegnL4A2IwQW9096ZEoZQ.jpg', 'TP0002', NULL, '2026-01-07 14:31:56', NULL),
('RE0004', 'Printer – Paper Jam Error', 'Printer displays paper jam error even when no paper is visible.\r\n\r\nSteps to Fix:\r\n1. Turn off and unplug the printer.\r\n2. Open all access panels and remove debris.\r\n3. Clean paper rollers with a dry cloth.\r\n4. Restart the printer and run a test print.', 'Pending', 'R.jfif', 'TP0003', NULL, '2026-01-07 14:34:08', NULL),
('RE0005', 'Headphones – Loose Wiring', 'Sound cuts in and out when the cable is moved. One side may stop working due to loose internal wiring.\r\n\r\nSteps to Fix:\r\n1. Test headphones to locate the position where sound cuts out.\r\n2. Open the earcup or cable casing carefully.\r\n3. Identify the loose or broken wire.\r\n4. Resolder or reconnect the wire securely.\r\n5. Close the casing and test sound again.', 'Pending', 'maxresdefault.jpg', 'TP0003', NULL, '2026-01-07 14:37:55', NULL),
('RE0006', 'Beanbag – Torn Fabric', 'Small tear on the fabric causing the filling to leak.\r\n\r\nSteps to Fix:\r\n1. Empty or push filling away from the tear.\r\n2. Sew the tear using strong thread or fabric patch.\r\n3. Reinforce the area with fabric glue if needed.\r\n4. Allow to dry and test for leaks', 'Pending', 'R.png', 'TP0004', NULL, '2026-01-07 14:38:35', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
CREATE TABLE IF NOT EXISTS `review` (
  `review_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each review',
  `description` text COMMENT 'Feedback provided by the user ',
  `rating_stars` int NOT NULL COMMENT 'Rating of the item for review',
  `user_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references user_id in User',
  `item_id` varchar(4) NOT NULL COMMENT 'Foreign Key, references item_id in Item',
  PRIMARY KEY (`review_id`),
  KEY `review_user` (`user_id`),
  KEY `review_item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`review_id`, `description`, `rating_stars`, `user_id`, `item_id`) VALUES
('RV0001', 'Great camera, very easy to use. The owner was helpful!', 5, 'TP0001', 'A001'),
('RV0002', 'The table is good.', 5, 'TP0002', 'A003'),
('RV0003', 'This book is useful for beginners. Recommended!', 5, 'TP0001', 'A002'),
('RV0004', 'All good.', 5, 'TP0001', 'A006');

-- --------------------------------------------------------

--
-- Table structure for table `reward`
--

DROP TABLE IF EXISTS `reward`;
CREATE TABLE IF NOT EXISTS `reward` (
  `reward_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each reward',
  `badge` varchar(255) NOT NULL COMMENT 'Badge of the reward',
  `eco_point_required` int NOT NULL COMMENT 'Cost of Eco point that require to redeem the reward ',
  `tree_id` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Foreign Key, references tree_id in Tree',
  PRIMARY KEY (`reward_id`),
  KEY `reward_tree` (`tree_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `reward`
--

INSERT INTO `reward` (`reward_id`, `badge`, `eco_point_required`, `tree_id`) VALUES
('RW0001', 'Eco Warrior Badge', 100, 'TR0001'),
('RW0002', 'Kind Donator Badge', 200, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tree`
--

DROP TABLE IF EXISTS `tree`;
CREATE TABLE IF NOT EXISTS `tree` (
  `tree_id` varchar(8) NOT NULL COMMENT 'Primary Key, unique identifier for each tree',
  `eco_point_cost` int NOT NULL,
  `tree_type` enum('Evergreen','Rose','Lavender','Bonsai Tree') NOT NULL,
  `date` date NOT NULL COMMENT 'The date of the tree was planted',
  `status` enum('Pending','In Progress','Planted','') NOT NULL COMMENT 'The current status of the tree.',
  `location` text NOT NULL COMMENT 'Location of the tree planted',
  `image` text NOT NULL,
  `remarks` text NOT NULL COMMENT 'Remark on trees',
  `user_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references user_id in User',
  `gv_id` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Foreign Key, references gv_id in GreenVerifier',
  `requested_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tree_id`),
  KEY `tree_user` (`user_id`),
  KEY `tree_gv` (`gv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tree`
--

INSERT INTO `tree` (`tree_id`, `eco_point_cost`, `tree_type`, `date`, `status`, `location`, `image`, `remarks`, `user_id`, `gv_id`, `requested_date`) VALUES
('TR0001', 1000, 'Evergreen', '2025-11-20', 'Planted', 'APU Block A, Level 3', 'evergreen.jpg\r\n', 'Watered on Nov 20\n[06 Jan 2026] lol\n[06 Jan 2026] Tree successfully planted', 'TP0001', 'GV0001', '2026-01-04 14:24:07');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each student login',
  `username` varchar(50) NOT NULL COMMENT 'Username for user ',
  `email` varchar(100) NOT NULL COMMENT 'Email address of user',
  `phone_number` varchar(12) DEFAULT NULL COMMENT 'User’s optional contact phone number',
  `address` varchar(255) DEFAULT NULL COMMENT 'Address used for coordinating item pick-up/drop-off if needed',
  `password` varchar(255) NOT NULL COMMENT 'Password for user login',
  `status` enum('Active','Inactive','Suspended') NOT NULL COMMENT 'Current stage of the user',
  `total_eco_point` int NOT NULL COMMENT 'Total eco point of the user',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `email`, `phone_number`, `address`, `password`, `status`, `total_eco_point`) VALUES
('TP0001', 'test01', 'test01@gmail.com', '012-34567896', 'Kuala Lumpur', '1111', 'Active', 1380),
('TP0002', 'user02', 'user02@gmail.com', '016-34502589', 'Cheras', '222', 'Active', 1000),
('TP0003', 'Vivian', 'vivian@gmail.com', '012-36958425', 'Cyberjaya', 'vivian666', 'Active', 1000),
('TP0004', 'Jia', 'jia@gmail.com', '016-34502777', 'Kepong', '666', 'Active', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `userchallenge`
--

DROP TABLE IF EXISTS `userchallenge`;
CREATE TABLE IF NOT EXISTS `userchallenge` (
  `user_challenge_id` varchar(6) NOT NULL COMMENT 'Primary Key, unique identifier for each userchallenge',
  `total_eco_point` int NOT NULL COMMENT 'Total eco point of the challenge user took',
  `user_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references user_id in User',
  `challenge_id` varchar(6) NOT NULL COMMENT 'Foreign Key, references challenge_id in Challenge',
  PRIMARY KEY (`user_challenge_id`),
  KEY `userchallenge_challenge` (`challenge_id`),
  KEY `userchallenge_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `userchallenge`
--

INSERT INTO `userchallenge` (`user_challenge_id`, `total_eco_point`, `user_id`, `challenge_id`) VALUES
('UC0001', 100, 'TP0001', 'CH0001'),
('UC0002', 100, 'TP0001', 'CH0002'),
('UC0003', 1000, 'TP0001', 'CH0004'),
('UC0004', 1000, 'TP0003', 'CH0004'),
('UC0005', 1000, 'TP0002', 'CH0004'),
('UC0006', 1000, 'TP0004', 'CH0004'),
('UC0007', 250, 'TP0001', 'CH0003');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `challenge`
--
ALTER TABLE `challenge`
  ADD CONSTRAINT `challenge_admin` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `donation`
--
ALTER TABLE `donation`
  ADD CONSTRAINT `donation_gv` FOREIGN KEY (`gv_id`) REFERENCES `greenverifier` (`gv_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `donation_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `ecoimpact`
--
ALTER TABLE `ecoimpact`
  ADD CONSTRAINT `ecoimpact_record` FOREIGN KEY (`record_id`) REFERENCES `record` (`record_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ecopoint`
--
ALTER TABLE `ecopoint`
  ADD CONSTRAINT `ecopoint_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `item_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `itemaction`
--
ALTER TABLE `itemaction`
  ADD CONSTRAINT `itemaction_admin` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `itemaction_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `record`
--
ALTER TABLE `record`
  ADD CONSTRAINT `record_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `record_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `repair`
--
ALTER TABLE `repair`
  ADD CONSTRAINT `repair_gv` FOREIGN KEY (`gv_id`) REFERENCES `greenverifier` (`gv_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `repair_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `review_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `tree`
--
ALTER TABLE `tree`
  ADD CONSTRAINT `tree_gv` FOREIGN KEY (`gv_id`) REFERENCES `greenverifier` (`gv_id`),
  ADD CONSTRAINT `tree_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `userchallenge`
--
ALTER TABLE `userchallenge`
  ADD CONSTRAINT `userchallenge_challenge` FOREIGN KEY (`challenge_id`) REFERENCES `challenge` (`challenge_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `userchallenge_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
