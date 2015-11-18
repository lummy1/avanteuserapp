-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 18, 2015 at 11:15 AM
-- Server version: 5.5.20
-- PHP Version: 5.3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `avanteso_avante`
--

-- --------------------------------------------------------

--
-- Table structure for table `agent`
--

CREATE TABLE IF NOT EXISTS `agent` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `agentId` varchar(150) NOT NULL,
  `merchantId` varchar(150) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `email` varchar(50) NOT NULL,
  `branchId` int(11) NOT NULL,
  `dateCreated` date NOT NULL,
  `password` varchar(200) NOT NULL,
  `default` bit(1) NOT NULL,
  `locked` bit(1) NOT NULL,
  `deactivate` bit(1) DEFAULT NULL COMMENT 'to totally deativate the agent',
  `reasons` varchar(600) NOT NULL,
  PRIMARY KEY (`sn`),
  UNIQUE KEY `agentId` (`agentId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `agent`
--

INSERT INTO `agent` (`sn`, `agentId`, `merchantId`, `firstname`, `lastname`, `email`, `branchId`, `dateCreated`, `password`, `default`, `locked`, `deactivate`, `reasons`) VALUES
(1, '07064393927', '2015', 'Abisoye', 'Obadare', 'ajolaoso@avante-cs.com', 1, '2015-04-20', 'fe7378ed7bb57e9c0e18d5d6cb275630', b'0', b'0', b'0', '');

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE IF NOT EXISTS `branch` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(500) NOT NULL,
  `address` varchar(250) DEFAULT NULL COMMENT 'branch address',
  `managerId` varchar(11) DEFAULT NULL COMMENT 'same as agent ID',
  PRIMARY KEY (`sn`),
  UNIQUE KEY `location` (`location`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`sn`, `location`, `address`, `managerId`) VALUES
(1, 'Lekki', '2B, Obafemi Anibaba street', '1'),
(2, 'Agege', '2, Penn Cinema', '1');

-- --------------------------------------------------------

--
-- Table structure for table `promo`
--

CREATE TABLE IF NOT EXISTS `promo` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `promoName` varchar(250) NOT NULL,
  `description` text,
  `DiscountOrPoint` char(1) DEFAULT NULL,
  `PercentageDiscount` float DEFAULT NULL,
  `Point` int(11) DEFAULT '0',
  `PointAmount` decimal(18,2) DEFAULT '0.00',
  `valueDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  PRIMARY KEY (`sn`),
  UNIQUE KEY `promoName` (`promoName`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `promo`
--

INSERT INTO `promo` (`sn`, `promoName`, `description`, `DiscountOrPoint`, `PercentageDiscount`, `Point`, `PointAmount`, `valueDate`, `endDate`) VALUES
(1, 'PMS', 'Petroleum products', 'P', 0, 0, '0.00', '2015-04-22', '2020-04-23'),
(2, 'Gucci Bag', 'A material item', 'D', 3, 0, '0.00', '2015-04-22', '2020-04-23'),
(3, 'Red Label', 'A brand of wine', 'P', 0, 1, '100.00', '2015-05-11', '2015-05-11');

-- --------------------------------------------------------

--
-- Table structure for table `promo_range`
--

CREATE TABLE IF NOT EXISTS `promo_range` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `promoname` varchar(150) NOT NULL,
  `lowerLimit` decimal(18,2) NOT NULL,
  `higherLimit` decimal(18,2) NOT NULL,
  `priceTag` decimal(18,2) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  `createdDate` datetime NOT NULL,
  `comment` varchar(400) NOT NULL,
  `valid` bit(1) NOT NULL,
  PRIMARY KEY (`sn`),
  KEY `promoname` (`promoname`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `promo_range`
--

INSERT INTO `promo_range` (`sn`, `promoname`, `lowerLimit`, `higherLimit`, `priceTag`, `points`, `createdDate`, `comment`, `valid`) VALUES
(1, 'Silver plan', '1000.00', '2000.00', '100.00', 0, '2015-05-08 13:58:14', 'created today 2015-05-08 13:58:14\n by Ambode Williams', b'1'),
(2, 'Bronze plan', '2001.00', '4001.00', '200.00', 0, '2015-05-10 17:26:58', 'created today 2015-05-10 17:26:58\n by Ambode Williams', b'1'),
(3, 'Gold', '4001.00', '10000.00', '300.00', 0, '2015-05-10 17:30:38', 'created today 2015-05-10 17:30:38\n by Ambode Williams', b'1'),
(4, 'diamond', '10001.00', '15000.00', '0.00', 0, '2015-07-14 00:00:00', '', b'1'),
(5, 'DD', '4.00', '78.00', '6.00', 0, '2015-07-17 00:00:00', 'created today 2015-07-17 by Accenture Nigeria', b'1'),
(6, 'HG', '89.00', '100.00', '8.00', 0, '2015-07-17 00:00:00', 'created today 2015-07-17 by Accenture Nigeria', b'1'),
(7, 'FG', '120.00', '156.00', '10.00', 0, '2015-07-17 00:00:00', 'created today 2015-07-17 by Accenture Nigeria', b'1'),
(8, 'DD', '4.00', '78.00', '6.00', 0, '2015-07-17 00:00:00', 'created today 2015-07-17 by Accenture Nigeria', b'1'),
(9, 'HG', '89.00', '100.00', '8.00', 0, '2015-07-17 00:00:00', 'created today 2015-07-17 by Accenture Nigeria', b'1'),
(10, 'FG', '120.00', '156.00', '10.00', 0, '2015-07-17 00:00:00', 'created today 2015-07-17 by Accenture Nigeria', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `sn` int(1) NOT NULL AUTO_INCREMENT,
  `merchantName` varchar(200) NOT NULL,
  `merchantId` varchar(100) NOT NULL,
  `merchantEmail` varchar(150) NOT NULL,
  `usePriceRange` bit(1) NOT NULL,
  `subscription` bit(1) NOT NULL,
  `unlimitedVoucher` bit(1) NOT NULL,
  `voucher%Discount` decimal(18,2) NOT NULL COMMENT 'percent discount value to apply',
  `voucherFor` varchar(300) NOT NULL,
  `agents_allowed` int(9) NOT NULL,
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`sn`, `merchantName`, `merchantId`, `merchantEmail`, `usePriceRange`, `subscription`, `unlimitedVoucher`, `voucher%Discount`, `voucherFor`, `agents_allowed`) VALUES
(1, 'Accenture Nigeria', '2015', 'ajolaoso@avante-cs.com', b'1', b'0', b'1', '10.00', 'Bay Lounge', 0),
(2, 'bty', '2346', 'ol@jdk.com', b'0', b'0', b'0', '0.00', '', 0),
(3, 'hjdk', '2342', 'jj@jdjd.com', b'1', b'0', b'0', '0.00', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `subscription`
--

CREATE TABLE IF NOT EXISTS `subscription` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(100) NOT NULL,
  `merchantId` varchar(150) NOT NULL,
  `serialNo` varchar(150) DEFAULT NULL,
  `dateCreated` date DEFAULT NULL,
  `lastSubscriptionDate` date NOT NULL,
  `expiryDate` date DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `comment` text,
  `locked` bit(1) DEFAULT NULL,
  `deativate` bit(1) DEFAULT NULL,
  `reasons` varchar(700) DEFAULT NULL,
  PRIMARY KEY (`sn`),
  UNIQUE KEY `serialNo` (`serialNo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `subscription`
--

INSERT INTO `subscription` (`sn`, `userId`, `merchantId`, `serialNo`, `dateCreated`, `lastSubscriptionDate`, `expiryDate`, `status`, `comment`, `locked`, `deativate`, `reasons`) VALUES
(1, '08026855344', '2015', '201500000004', '2015-06-11', '2015-06-11', '2015-06-11', 'P', '=N=300.00 applied to transaction worth 5689\n of item  today 6/11/2015\n by Emmanuel Avante', NULL, NULL, NULL),
(2, '08160361734', '2015', '201500000001', '2015-06-17', '2015-06-17', '2015-06-17', 'P', '=N=0 applied to transaction worth 500\n of item  today 17/06/2015\n by Emmanuel Avante', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ticketing`
--

CREATE TABLE IF NOT EXISTS `ticketing` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(100) NOT NULL,
  `agentId` varchar(150) NOT NULL,
  `serialNo` varchar(150) NOT NULL,
  `transAmount` decimal(18,2) DEFAULT NULL,
  `transType` varchar(50) DEFAULT NULL,
  `points` int(10) DEFAULT NULL,
  `priceTag` decimal(18,2) DEFAULT NULL,
  `comment` varchar(700) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL,
  `transDate` datetime DEFAULT NULL,
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ticketpointsetup`
--

CREATE TABLE IF NOT EXISTS `ticketpointsetup` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `point` int(3) NOT NULL,
  `rate` decimal(10,0) NOT NULL,
  `createdBy` varchar(40) NOT NULL,
  `date` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ticketpointsetup`
--

INSERT INTO `ticketpointsetup` (`id`, `point`, `rate`, `createdBy`, `date`) VALUES
(1, 1, '33', '2015', '2015-08-04');

-- --------------------------------------------------------

--
-- Table structure for table `ticketroute`
--

CREATE TABLE IF NOT EXISTS `ticketroute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `routeNo` varchar(50) NOT NULL,
  `zone` int(11) NOT NULL,
  `areacovered` text NOT NULL,
  `from` varchar(30) NOT NULL,
  `to` varchar(30) NOT NULL,
  `oneway` bit(1) NOT NULL,
  `return` bit(1) NOT NULL,
  `duration` int(5) NOT NULL,
  `pointscharged` int(11) NOT NULL,
  `status` varchar(10) NOT NULL,
  `createdby` varchar(40) NOT NULL,
  `date` varchar(20) NOT NULL,
  `time` varchar(20) NOT NULL,
  `ip` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `ticketroute`
--

INSERT INTO `ticketroute` (`id`, `routeNo`, `zone`, `areacovered`, `from`, `to`, `oneway`, `return`, `duration`, `pointscharged`, `status`, `createdby`, `date`, `time`, `ip`) VALUES
(1, 'LagIbd001', 0, '', 'Lagos', 'Ibadan', b'1', b'0', 0, 20, '', '', '2015-07-31', '10:55:13 am', '127.0.0.1'),
(2, 'LekVic234', 1, 'lekki, eko hotels, bar beach', 'Lekki', 'Victoria Island', b'1', b'0', 0, 5, 'Active', 'Accenture Nigeria', '2015-07-31', '11:39:00 am', '127.0.0.1'),
(3, 'LekVic', 2, 'lekki, eko hotels, bar beach', 'Lekki', 'Victoria Island', b'0', b'0', 60, 5, 'Active', 'Accenture Nigeria', '2015-07-31', '11:43:56 am', '127.0.0.1'),
(4, 'LekVic268', 3, 'lekki, eko hotels, bar beach', 'Lekki2', 'Victoria Island', b'0', b'1', 0, 10, 'Active', 'Accenture Nigeria', '2015-07-31', '11:58:17 am', '127.0.0.1'),
(5, 'LekVic19338', 5, 'lekki, eko hotels, bar beach', 'Lekki', 'Victoria Island', b'0', b'1', 0, 5, 'Active', 'Accenture Nigeria', '2015-07-31', '12:00:54 pm', '127.0.0.1'),
(6, '$r', 0, '$areacovered', '$from', '$to', b'1', b'1', 0, 0, 'Active', '$mmerchantName', '$createdDate', '$time', '$ip'),
(7, '', 0, '', '', '', b'0', b'0', 0, 0, 'Active', 'Accenture Nigeria', '', '10:21:28 am', '127.0.0.1'),
(8, 'Ldkdks', 0, '', 'ldkj', 'dks', b'1', b'0', 0, 4, 'Active', 'Accenture Nigeria', '2015-09-02', '10:25:45 am', '127.0.0.1');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_transaction`
--

CREATE TABLE IF NOT EXISTS `ticket_transaction` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `routeno` varchar(11) NOT NULL COMMENT 'mapped to promo''s sn fiels',
  `triptype` varchar(20) NOT NULL,
  `userId` varchar(100) NOT NULL,
  `agentId` varchar(150) NOT NULL,
  `serialNo` varchar(150) NOT NULL,
  `transAmount` decimal(18,2) DEFAULT NULL,
  `transType` varchar(50) DEFAULT NULL,
  `points` int(10) DEFAULT NULL,
  `discount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `priceTag` decimal(18,2) DEFAULT '0.00' COMMENT 'represent discount field',
  `comment` varchar(700) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL,
  `transDate` datetime DEFAULT NULL,
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `ticket_transaction`
--

INSERT INTO `ticket_transaction` (`sn`, `routeno`, `triptype`, `userId`, `agentId`, `serialNo`, `transAmount`, `transType`, `points`, `discount`, `priceTag`, `comment`, `status`, `createdDate`, `transDate`) VALUES
(1, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-02 10:20:15', '2015-09-02 10:20:15'),
(3, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-02 10:20:15', '2015-09-02 10:20:15'),
(4, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-02 10:31:00', '2015-09-02 10:31:00'),
(5, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-02 10:31:01', '2015-09-02 10:31:01'),
(6, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-02 11:00:54', '2015-09-02 11:00:54'),
(7, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-02 11:00:54', '2015-09-02 11:00:54'),
(8, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-02 14:15:07', '2015-09-02 14:15:07'),
(9, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-02 14:15:07', '2015-09-02 14:15:07'),
(10, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-03 09:19:55', '2015-09-03 09:19:55'),
(11, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-03 09:19:56', '2015-09-03 09:19:56'),
(12, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-03 09:51:19', '2015-09-03 09:51:19'),
(13, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-03 09:51:19', '2015-09-03 09:51:19'),
(14, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-03 15:27:00', '2015-09-03 15:27:00'),
(15, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-03 15:27:00', '2015-09-03 15:27:00'),
(16, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-10 23:46:47', '2015-09-10 23:46:47'),
(17, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-10 23:46:48', '2015-09-10 23:46:48'),
(18, 'LekVic234', '', '', '', '', '165.00', 'T', 1, '0.00', '0.00', '', 'A', '2015-09-10 23:46:48', '2015-09-10 23:46:48');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE IF NOT EXISTS `transaction` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) NOT NULL COMMENT 'mapped to promo''s sn fiels',
  `userId` varchar(100) NOT NULL,
  `agentId` varchar(150) NOT NULL,
  `serialNo` varchar(150) NOT NULL,
  `transAmount` decimal(18,2) DEFAULT NULL,
  `transType` varchar(50) DEFAULT NULL,
  `points` int(10) DEFAULT NULL,
  `discount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `priceTag` decimal(18,2) DEFAULT '0.00' COMMENT 'represent discount field',
  `comment` varchar(700) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL,
  `transDate` datetime DEFAULT NULL,
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=143 ;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`sn`, `productId`, `userId`, `agentId`, `serialNo`, `transAmount`, `transType`, `points`, `discount`, `priceTag`, `comment`, `status`, `createdDate`, `transDate`) VALUES
(1, 0, '08026855344', '08184507023', '201500000004', '5689.00', 'A', 0, '0.00', '300.00', '=N=300.00 applied to transaction worth 5689\n of item  today 6/11/2015\n by Emmanuel Avante', 'A', '2015-06-11 13:30:07', '2015-08-05 13:03:11'),
(2, 0, '08026855344', '08184507023', '201500000004', '20000.00', 'A', 0, '0.00', '300.00', '=N=300.00 applied to transaction worth 20000\n of item  today 11/06/2015\n by Emmanuel Avante', 'A', '2015-06-11 14:59:16', '2015-08-05 13:03:20'),
(3, 0, '08026855344', '08184507023', '201500000004', '1810.00', 'A', 0, '0.00', '100.00', '=N=100.00 applied to transaction worth 1810\n of item  today 11/06/2015\n by Emmanuel Avante', 'A', '2015-06-11 16:14:30', '2015-08-05 14:22:35'),
(4, 0, '08160361734', '08184507023', '201500000001', '500.00', 'A', 0, '0.00', '0.00', '=N=0 applied to transaction worth 500\n of item  today 17/06/2015\n by Emmanuel Avante', 'A', '2015-06-17 13:32:40', '2015-06-17 22:16:21'),
(5, 0, '08160361734', '08184507023', '201500000001', '5000.00', 'R', 0, '0.00', '0.00', 'undefined from ID:4 was redeemed for a transaction worth 5000\n today 17/06/2015\n by Emmanuel Avante', 'A', '2015-06-17 22:16:21', '2015-06-17 22:16:21'),
(6, 0, '08160361734', '08184507023', '201500000001', '5000.00', 'A', 0, '0.00', '300.00', '=N=300.00 applied to transaction worth 5000\n of item  today 17/06/2015\n by Emmanuel Avante', 'A', '2015-06-17 22:17:12', '2015-06-17 15:47:24'),
(7, 0, '08160361734', '07064393927', '201500000001', '0.00', 'V', 0, '10.00', '0.00', '10.00% Voucher redeemed today: 2015-06-24 16:43:09 by agent: 07064393927', 'A', '2015-06-05 16:47:18', '2015-06-24 16:43:09'),
(8, 0, '08160361734', '07064393927', '201500000001', '1000.00', 'A', 0, '0.00', '100.00', '=N=100.00 applied to transaction worth 1000\n of item  today 25/06/2015\n by Abisoye Obadare', 'A', '2015-06-25 15:40:52', '2015-06-25 15:47:19'),
(9, 0, '08160361734', '07064393927', '201500000001', '2000.00', 'R', 0, '0.00', '100.00', '100 from ID:8 was redeemed for a transaction worth 2000\n today 25/06/2015\n by Abisoye Obadare', 'A', '2015-06-25 15:47:19', '2015-06-25 15:47:19'),
(10, 0, '08160361734', '07064393927', '201500000001', '1900.00', 'R', 0, '0.00', '300.00', '300 from ID:6 was redeemed for a transaction worth 1900\n today 25/06/2015\n by Abisoye Obadare', 'A', '2015-06-25 15:47:24', '2015-06-25 15:47:24'),
(11, 0, '08160361734', '07064393927', '201500000001', '0.00', 'V', 0, '10.00', '0.00', '10.00% Voucher redeemed today: 2015-06-25 16:01:24 by agent: 07064393927', 'A', '2015-06-05 16:47:18', '2015-06-25 16:01:24'),
(12, 0, '08026855344', '08051125927', '201500000004', '500.00', 'R', 0, '0.00', '300.00', '300 from ID:1 was redeemed for a transaction worth 500\n today 8/5/2015\n by lummy glo', 'A', '2015-08-05 13:03:11', '2015-08-05 13:03:11'),
(13, 0, '08026855344', '08051125927', '201500000004', '200.00', 'R', 0, '0.00', '300.00', '300 from ID:2 was redeemed for a transaction worth 200\n today 8/5/2015\n by lummy glo', 'A', '2015-08-05 13:03:20', '2015-08-05 13:03:20'),
(14, 0, '08026855344', '08051125927', '201500000004', '0.00', 'R', 0, '0.00', '100.00', '=N=100 being the RollOver balance from transaction-ID:2', 'A', '2015-08-05 13:03:20', '2015-08-05 14:39:48'),
(15, 0, '08026855344', '08051125927', '201500000004', '100.00', 'R', 0, '0.00', '100.00', '100 from ID:3 was redeemed for a transaction worth 100\n today 8/5/2015\n by lummy glo', 'A', '2015-08-05 14:22:35', '2015-08-05 14:22:35'),
(16, 0, '08026855344', '08051125927', '201500000004', '3000.00', 'A', 0, '0.00', '200.00', '=N=200.00 applied to transaction worth 3000\n of item  today 8/5/2015\n by lummy glo', 'A', '2015-08-05 14:23:45', '2015-08-05 14:24:46'),
(17, 0, '08026855344', '08051125927', '201500000004', '5000.00', 'A', 0, '0.00', '300.00', '=N=300.00 applied to transaction worth 5000\n of item  today 8/5/2015\n by lummy glo', 'A', '2015-08-05 14:24:10', '2015-08-05 14:43:28'),
(18, 0, '08026855344', '08051125927', '201500000004', '200.00', 'R', 0, '0.00', '200.00', '200 from ID:16 was redeemed for a transaction worth 200\n today 8/5/2015\n by lummy glo', 'A', '2015-08-05 14:24:46', '2015-08-05 14:24:46'),
(19, 0, '08026855344', '08051125927', '201500000004', '100.00', 'R', 0, '0.00', '100.00', '100 from ID:14 was redeemed for a transaction worth 100\n today 8/5/2015\n by lummy glo', 'A', '2015-08-05 14:39:48', '2015-08-05 14:39:48'),
(20, 0, '08026855344', '08051125927', '201500000004', '50000.00', 'A', 0, '0.00', '0.00', '=N=0 applied to transaction worth 50000\n of item  today 8/5/2015\n by lummy glo', 'A', '2015-08-05 14:42:06', '2015-08-09 18:59:00'),
(21, 0, '08026855344', '08051125927', '201500000004', '36769.00', 'A', 0, '0.00', '0.00', '=N=0 applied to transaction worth 36769\n of item  today 8/5/2015\n by lummy glo', 'A', '2015-08-05 14:42:57', '2015-08-09 19:10:49'),
(22, 0, '08026855344', '08051125927', '201500000004', '300.00', 'R', 0, '0.00', '300.00', '300 from ID:17 was redeemed for a transaction worth 300\n today 8/5/2015\n by lummy glo', 'A', '2015-08-05 14:43:28', '2015-08-05 14:43:28'),
(23, 0, '08026855344', '08051125927', '201500000004', '2000.00', 'A', 0, '0.00', '100.00', '=N=100.00 applied to transaction worth 2000\n of item  today 8/5/2015\n by lummy glo', 'A', '2015-08-05 14:45:06', '2015-08-09 19:05:42'),
(24, 0, '08026855344', '08051125927', '201500000004', '4545556.00', 'A', 0, '0.00', '0.00', '=N=0 applied to transaction worth 4545556\n of item  today 8/5/2015\n by lummy glo', 'A', '2015-08-05 14:46:03', '2015-08-09 19:08:08'),
(25, 0, '08026855344', '08051125927', '201500000004', '300.00', 'R', 0, '0.00', '0.00', 'undefined from ID:20 was redeemed for a transaction worth 300\n today 8/9/2015\n by lummy glo', 'A', '2015-08-09 18:59:00', '2015-08-09 18:59:00'),
(26, 0, '08026855344', '08051125927', '201500000004', '100.00', 'R', 0, '0.00', '100.00', '100 from ID:23 was redeemed for a transaction worth 100\n today 8/9/2015\n by lummy glo', 'A', '2015-08-09 19:05:42', '2015-08-09 19:05:42'),
(27, 0, '08026855344', '08051125927', '201500000004', '55.00', 'R', 0, '0.00', '0.00', 'undefined from ID:24 was redeemed for a transaction worth 55\n today 8/9/2015\n by lummy glo', 'A', '2015-08-09 19:08:08', '2015-08-09 19:08:08'),
(28, 0, '08026855344', '08051125927', '201500000004', '34.00', 'R', 0, '0.00', '0.00', 'undefined from ID:21 was redeemed for a transaction worth 34\n today 8/9/2015\n by lummy glo', 'A', '2015-08-09 19:10:49', '2015-08-09 19:10:49'),
(29, 0, '08026855344', '', '201500000004', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-24 21:18:43 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-24 21:18:43'),
(30, 0, '08026855344', '', '201500000004', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-24 21:18:43 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-24 21:18:43'),
(40, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-24 21:25:08 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-24 21:25:08'),
(41, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-24 21:25:08 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-24 21:25:08'),
(42, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-24 21:25:09 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-24 21:25:09'),
(43, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:09:07 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:09:07'),
(44, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:09:08 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:09:08'),
(45, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:09:09 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:09:09'),
(46, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:09:46 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:09:46'),
(47, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:09:46 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:09:46'),
(48, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:09:46 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:09:46'),
(49, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:15:06 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:15:06'),
(50, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:15:06 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:15:06'),
(51, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:15:06 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:15:06'),
(52, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:16:11 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:16:11'),
(53, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:16:11 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:16:11'),
(54, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:16:42 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:16:42'),
(55, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:16:42 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:16:42'),
(56, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:18:04 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:18:04'),
(57, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:18:04 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:18:04'),
(58, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:18:05 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:18:05'),
(59, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:18:30 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:18:30'),
(60, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:18:30 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:18:30'),
(61, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:18:31 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:18:31'),
(62, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:18:40 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:18:40'),
(63, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:18:40 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:18:40'),
(64, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:19:03 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:19:03'),
(65, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:19:03 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:19:03'),
(66, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:19:06 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:19:06'),
(67, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:21:00 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:21:00'),
(68, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:21:00 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:21:00'),
(69, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:21:00 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:21:00'),
(70, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:21:40 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:21:40'),
(71, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:21:40 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:21:40'),
(72, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:23:29 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:23:29'),
(73, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:23:29 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:23:29'),
(74, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 14:23:36 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 14:23:36'),
(75, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 19:58:55 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 19:58:55'),
(76, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 19:58:55 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 19:58:55'),
(77, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 19:59:04 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 19:59:04'),
(78, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 19:59:04 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 19:59:04'),
(79, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 19:59:50 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 19:59:50'),
(80, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 19:59:51 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 19:59:51'),
(81, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 19:59:52 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 19:59:52'),
(82, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 19:59:59 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 19:59:59'),
(83, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 19:59:59 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 19:59:59'),
(84, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:01:16 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:01:16'),
(85, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:01:16 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:01:16'),
(86, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:20 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:20'),
(87, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:21 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:21'),
(88, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:30 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:30'),
(89, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:32 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:32'),
(90, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:34 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:34'),
(91, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:36 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:36'),
(92, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:37 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:37'),
(93, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:38 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:38'),
(94, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:39 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:39'),
(95, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:41 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:41'),
(96, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:43 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:43'),
(97, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:43 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:43'),
(98, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:44 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:44'),
(99, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:45 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:45'),
(100, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:48 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:48'),
(101, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:52 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:52'),
(102, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:53 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:53'),
(103, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:37:54 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:37:54'),
(104, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:38:14 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:38:14'),
(105, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:38:14 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:38:14'),
(106, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:38:44 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:38:44'),
(107, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:38:44 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:38:44'),
(108, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:38:49 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:38:49'),
(109, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:38:49 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:38:49'),
(110, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:40:59 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:40:59'),
(111, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:40:59 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:40:59'),
(112, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:41:00 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:41:00'),
(113, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:41:07 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:41:07'),
(114, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:41:08 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:41:08'),
(115, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:41:29 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:41:29'),
(116, 0, '08160361734', '', '201500000001', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:41:29 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:41:29'),
(117, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:50:33 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:50:33'),
(118, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:50:34 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:50:34'),
(119, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:50:34 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:50:34'),
(120, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:54:12 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:54:12'),
(121, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:54:12 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:54:12'),
(122, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:59:38 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:59:38'),
(123, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 20:59:38 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 20:59:38'),
(124, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 21:03:07 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:03:07'),
(125, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 21:03:07 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:03:07'),
(126, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 21:03:07 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:03:07'),
(127, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 21:03:37 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:03:37'),
(128, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 21:11:10 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:11:10'),
(129, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 21:11:11 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:11:11'),
(130, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3.00% Voucher redeemed on transaction Amount  today: 2015-09-28 21:11:11 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:11:11'),
(131, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:14:01 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:14:01'),
(132, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:14:01 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:14:01'),
(133, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:14:01 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:14:01'),
(134, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:14:19 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:14:19'),
(135, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:14:19 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:14:19'),
(136, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:14:23 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:14:23'),
(137, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:14:23 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:14:23'),
(138, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:18:55 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:18:55'),
(139, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:18:55 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:18:55'),
(140, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:18:56 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:18:56'),
(141, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:19:04 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:19:04'),
(142, 0, '08093167077', '', '201500000008', '0.00', 'V', 0, '3.00', '0.00', '3% Voucher redeemed on transaction Amount  today: 2015-09-28 21:19:04 by agent: ', 'A', '2015-09-25 00:00:00', '2015-09-28 21:19:04');

-- --------------------------------------------------------

--
-- Table structure for table `voucher`
--

CREATE TABLE IF NOT EXISTS `voucher` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `merchantId` varchar(100) NOT NULL,
  `submerchantId` int(9) NOT NULL,
  `serialNo` varchar(150) NOT NULL,
  `percentageDiscount` decimal(18,2) DEFAULT NULL,
  `NoOfTimesUsed` int(10) DEFAULT NULL,
  `maxTimesUsage` int(9) NOT NULL,
  `useFromDate` date NOT NULL,
  `useToDate` date NOT NULL,
  `vouchertype` int(3) NOT NULL,
  `voucherFor` varchar(40) NOT NULL,
  `comment` varchar(700) DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `activationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `voucher`
--

INSERT INTO `voucher` (`sn`, `merchantId`, `submerchantId`, `serialNo`, `percentageDiscount`, `NoOfTimesUsed`, `maxTimesUsage`, `useFromDate`, `useToDate`, `vouchertype`, `voucherFor`, `comment`, `createdDate`, `expiryDate`, `activationDate`) VALUES
(1, '2015', 0, '201500000004', '3.00', 11, 5, '0000-00-00', '0000-00-00', 3, '', 'voucher generated today 2015-09-24 08:08:27', '2015-09-25 00:00:00', '2015-09-30 00:00:00', '2015-09-24 21:18:43'),
(2, '2015', 0, '201500000001', '3.00', 77, 5, '0000-00-00', '0000-00-00', 3, '', 'voucher generated today 2015-09-24 08:08:27', '2015-09-25 00:00:00', '2015-09-30 00:00:00', '2015-09-24 21:25:08'),
(3, '2015', 0, '201500000008', '3.00', 20, 5, '2015-09-25', '2015-09-30', 3, '', 'voucher generated today 2015-09-24 08:08:27', '2015-09-25 00:00:00', '2015-09-30 00:00:00', '2015-09-28 20:54:12'),
(5, '2015', 1, '201500000004', '6.00', 11, 2, '0000-00-00', '0000-00-00', 3, 'Genesis Cinema', 'voucher generated today 2015-09-24 08:42:09', '2015-09-24 00:00:00', '2015-11-26 00:00:00', '2015-09-24 21:18:43'),
(6, '2015', 1, '201500000001', '6.00', 70, 2, '0000-00-00', '0000-00-00', 3, 'Genesis Cinema', 'voucher generated today 2015-09-24 08:42:09', '2015-09-24 00:00:00', '2015-11-26 00:00:00', '2015-09-24 21:25:08'),
(7, '2015', 1, '201500000008', '6.00', 20, 2, '0000-00-00', '0000-00-00', 3, 'Genesis Cinema', 'voucher generated today 2015-09-24 08:42:09', '2015-09-24 00:00:00', '2015-11-26 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wallet`
--

CREATE TABLE IF NOT EXISTS `wallet` (
  `sn` int(11) NOT NULL AUTO_INCREMENT,
  `agentId` varchar(15) NOT NULL,
  `serialNo` varchar(150) NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `transactionDate` datetime NOT NULL,
  `createdby` varchar(200) NOT NULL,
  `comment` varchar(450) NOT NULL,
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `wallet`
--

INSERT INTO `wallet` (`sn`, `agentId`, `serialNo`, `amount`, `transactionDate`, `createdby`, `comment`) VALUES
(1, '08184507023', '201500000004', '8000000.00', '2015-06-11 13:29:47', 'Emmanuel Avante', 'Account credited today 2015-06-11 13:29:47\nwith the sum of  =N=8000000\nprocessed by Emmanuel Avante'),
(2, '08184507023', '201500000004', '-5689.00', '2015-06-11 13:30:07', '08184507023', 'autopost'),
(3, '08184507023', '201500000004', '587499.00', '2015-06-11 13:31:19', 'Emmanuel Avante', 'Account credited today 2015-06-11 13:31:19\nwith the sum of  =N=587499\nprocessed by Emmanuel Avante'),
(4, '08184507023', '201500000004', '-20000.00', '2015-06-11 14:59:16', '08184507023', 'autopost'),
(5, '08184507023', '201500000004', '-1810.00', '2015-06-11 16:14:30', '08184507023', 'autopost'),
(6, '08184507023', '201500000001', '20000.00', '2015-06-13 19:34:20', 'Emmanuel Avante', 'Account credited today 2015-06-13 19:34:20\nwith the sum of  =N=20000\nprocessed by Emmanuel Avante'),
(7, '07064393927', '201500000001', '-1000.00', '2015-06-25 15:40:52', '07064393927', 'autopost'),
(8, '07064393927', '201500000001', '1000.00', '2015-06-25 15:59:27', 'Abisoye Obadare', 'Account credited today 2015-06-25 15:59:27\nwith the sum of  =N=1000\nprocessed by Abisoye Obadare'),
(9, '08051125927', '201500000004', '-3000.00', '2015-08-05 14:23:45', '08051125927', 'autopost');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
