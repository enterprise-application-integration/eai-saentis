-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 04. Jun 2019 um 19:39
-- Server-Version: 10.1.38-MariaDB
-- PHP-Version: 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `saentis`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(255) NOT NULL,
  `customer_LastName` varchar(50) NOT NULL,
  `customer_FirstName` varchar(50) NOT NULL,
  `customer_Adress` varchar(50) NOT NULL,
  `customer_City` varchar(50) NOT NULL,
  `customer_Email` varchar(50) NOT NULL,
  `customer_CreditCardNumber` varchar(16) NOT NULL,
  `customer_Balance` double NOT NULL,
  `customer_LoyaltyPoints` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_LastName`, `customer_FirstName`, `customer_Adress`, `customer_City`, `customer_Email`, `customer_CreditCardNumber`, `customer_Balance`, `customer_LoyaltyPoints`) VALUES
(1234, 'Mustermann', 'Max', 'Babastreet 12', 'Basel', 'eaiproject.saentis@gmail.com', '987654321987', 86, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `maxorder`
--

CREATE TABLE `maxorder` (
  `customer_id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_quantity` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `order_sum` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `maxorder`
--

INSERT INTO `maxorder` (`customer_id`, `product_name`, `product_quantity`, `order_id`, `order_sum`) VALUES
(1234, 'eggs', 4, 34, 4);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_Id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_quantity` int(11) NOT NULL,
  `order_sum` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `orders`
--

INSERT INTO `orders` (`order_id`, `customer_Id`, `product_name`, `product_quantity`, `order_sum`) VALUES
(1, 1234, 'cheese', 2, NULL),
(2, 1234, 'cheese', 2, NULL),
(3, 1234, 'cheese', 2, NULL),
(4, 1234, 'cheese', 2, NULL),
(5, 1234, 'cheese', 2, NULL),
(6, 1234, 'cheese', 2, NULL),
(7, 1234, 'cheese', 2, NULL),
(8, 1234, 'cheese', 2, NULL),
(9, 1234, 'cheese', 2, NULL),
(10, 1234, 'cheese', 2, NULL),
(11, 1234, 'cheese', 2, NULL),
(12, 1234, 'cheese', 2, NULL),
(13, 1234, 'cheese', 2, NULL),
(14, 1234, 'cheese', 2, NULL),
(15, 1234, 'cheese', 2, 5),
(16, 1234, 'cheese', 2, 5),
(17, 1234, 'cheese', 2, 5),
(18, 1234, 'cheese', 2, 5),
(19, 1234, 'cheese', 2, NULL),
(20, 1234, 'cheese', 2, 5),
(21, 1234, 'cheese', 2, 5),
(22, 1234, 'cheese', 2, 5),
(23, 1234, 'cheese', 2, 5),
(24, 1234, 'cheese', 2, 5),
(25, 1234, 'cheese', 2, 5),
(26, 1234, 'milk', 5, 6.25),
(27, 1234, 'milk', 5, 6.25),
(28, 1234, 'milk', 5, 6.25),
(29, 1234, 'eggs', 12, 12),
(30, 1234, 'eggs', 12, 12),
(31, 1234, 'eggs', 12, 12),
(32, 1234, 'eggs', 12, 12),
(33, 1234, 'eggs', 2, 2),
(34, 1234, 'eggs', 4, 4);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_stock` int(255) NOT NULL,
  `product_price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `product_stock`, `product_price`) VALUES
(2, 'cheese', 164, 2.5),
(3, 'milk', 162, 1.25),
(4, 'eggs', 60, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `shipping`
--

CREATE TABLE `shipping` (
  `shipping_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `shipping_TandTNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `shipping`
--

INSERT INTO `shipping` (`shipping_id`, `order_id`, `customer_id`, `shipping_TandTNumber`) VALUES
(1, 25, 1234, 5687564),
(2, 25, 1234, 2724571),
(3, 26, 1234, 6320083),
(4, 27, 1234, 2090724),
(5, 28, 1234, 1890897),
(6, 29, 1234, 828115),
(7, 30, 1234, 275419),
(8, 31, 1234, 2064319),
(9, 32, 1234, 4800454),
(10, 33, 1234, 5590731),
(11, 33, 1234, 772722),
(12, 33, 1234, 8706436),
(13, 33, 1234, 5323340),
(14, 33, 1234, 8396226),
(15, 33, 1234, 2539334),
(16, 34, 1234, 3337012);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indizes für die Tabelle `maxorder`
--
ALTER TABLE `maxorder`
  ADD PRIMARY KEY (`order_id`);

--
-- Indizes für die Tabelle `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indizes für die Tabelle `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indizes für die Tabelle `shipping`
--
ALTER TABLE `shipping`
  ADD PRIMARY KEY (`shipping_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT für Tabelle `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `shipping`
--
ALTER TABLE `shipping`
  MODIFY `shipping_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
