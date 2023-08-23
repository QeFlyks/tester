-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Авг 18 2020 г., 19:58
-- Версия сервера: 5.5.65-MariaDB
-- Версия PHP: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `bd.sql`
--

-- --------------------------------------------------------

--
-- Структура таблицы `AD_ADMINS`
--

CREATE TABLE IF NOT EXISTS `AD_ADMINS` (
  `login` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `ip` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `AD_ADMINS`
--

INSERT INTO `AD_ADMINS` (`login`, `password`, `ip`) VALUES
('universalstudio', 'test', '');

-- --------------------------------------------------------

--
-- Структура таблицы `AD_BUYERS`
--

CREATE TABLE IF NOT EXISTS `AD_BUYERS` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `good` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `exp_time` int(11) NOT NULL,
  `cost` int(11) NOT NULL,
  `server` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `AD_CATEGORIES`
--

CREATE TABLE IF NOT EXISTS `AD_CATEGORIES` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `priority` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `AD_CATEGORIES`
--

INSERT INTO `AD_CATEGORIES` (`id`, `title`, `priority`) VALUES
(4, 'Привилегии', 3),
(5, 'Кейсы', 2),
(6, 'Прочее', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `AD_CUPONS`
--

CREATE TABLE IF NOT EXISTS `AD_CUPONS` (
  `name` varchar(50) DEFAULT NULL,
  `summ` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `AD_CUPONS`
--

INSERT INTO `AD_CUPONS` (`name`, `summ`, `count`) VALUES
('u4gm388t', 5, 1),
('uwk2e0sa', 5, 1),
('na7bm3h5', 40, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `AD_GOODS`
--

CREATE TABLE IF NOT EXISTS `AD_GOODS` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL DEFAULT '0',
  `cost` int(11) NOT NULL DEFAULT '0',
  `cupon` int(11) NOT NULL DEFAULT '0',
  `count` varchar(30) NOT NULL DEFAULT '-',
  `server` varchar(3) NOT NULL DEFAULT '*',
  `commands` text NOT NULL,
  `cat` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `dobuy` tinyint(1) DEFAULT '0',
  `pex_group` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `AD_GOODS`
--

INSERT INTO `AD_GOODS` (`id`, `name`, `cost`, `cupon`, `count`, `server`, `commands`, `cat`, `priority`, `dobuy`, `pex_group`) VALUES
(1, '[Vip]', 19, 0, '-', '0', '["bigvip {user}","groups group {user} vip"]', 4, 15, 1, 'vip'),
(2, '[Premium]', 29, 0, '-', '0', '["bigpremium {user}","groups group {user} premium"]', 4, 14, 1, 'premium'),
(3, '[Creative]', 49, 0, '-', '0', '["bigcreative {user}","groups group {user} creative"]', 4, 13, 1, 'creative'),
(4, '[Admin]', 99, 0, '-', '0', '["bigadmin {user}","groups group {user} admin"]', 4, 12, 1, 'admin'),
(5, '[Lord]', 149, 0, '-', '0', '["biglord {user}","groups group {user} lord"]', 4, 11, 1, 'lord'),
(6, '[Lord+]', 199, 0, '-', '0', '["biglord+ {user}","groups group {user} lord+"]', 4, 10, 1, 'lord+'),
(7, '[Oper]', 299, 0, '-', '0', '["bigoper {user}","groups group {user} oper"]', 4, 9, 1, 'oper'),
(9, '[Developer]', 499, 0, '-', '0', '["bigdeveloper {user}","groups group {user} developer"]', 4, 7, 1, 'developer'),
(10, '[GlAdmin]', 699, 0, '-', '0', '["biggladmin {user}","groups group {user} gladmin"]', 4, 6, 1, 'gladmin'),
(11, '[Sponsor]', 899, 0, '-', '0', '["bigsponsor {user}","groups group {user} sponsor"]', 4, 5, 1, 'sponsor'),
(12, '[Создатель]', 1499, 0, '-', '0', '["bigcreator {user}","groups group {user} creator"]', 4, 4, 1, 'creator'),
(13, '[Основатель]', 2499, 0, '-', '0', '["bigvlas {user}","groups group {user} osnov"]', 4, 3, 1, 'osnov'),
(14, '[Владелец]', 2999, 0, '-', '0', '["bigvladel {user}","groups group {user} vladel"]', 4, 2, 1, 'vladel'),
(16, '[Кейс с донатом]', 99, 0, '-', '0', '["cases add {user} 1","bigcases {user}"]', 5, 4, 0, NULL),
(17, '[Кейс с донатом 3 шт]', 249, 0, '-', '0', '["cases add {user} 3","bigcases3 {user}"]', 5, 3, 0, NULL),
(18, '[Кейс с донатом 5 шт]', 349, 0, '-', '0', '["cases add {user} 5","bigcases5 {user}"]', 5, 2, 0, NULL),
(19, '[Кейс с донатом 10 шт]', 499, 0, '-', '0', '["cases add {user} 10","bigcases10 {user}"]', 5, 1, 0, NULL),
(20, '[Разбан ника и IP]', 100, 0, '-', '0', '["unban {user}"]', 6, 1, 0, NULL),
(21, '[Купить сервер]', 5000, 0, '-', '0', '["123"]', 4, 1, 0, NULL),
(0, '123', 123, 0, '-', '1', '["2323523"]', 3, 1, 0, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `AD_PAYMENTS`
--

CREATE TABLE IF NOT EXISTS `AD_PAYMENTS` (
  `id` int(11) NOT NULL COMMENT 'ID платежа',
  `username` varchar(50) NOT NULL COMMENT 'Логин игрока',
  `data` varchar(256) NOT NULL COMMENT 'Информация',
  `time` int(11) NOT NULL COMMENT 'Время создания',
  `status` int(11) NOT NULL COMMENT 'Статус',
  `stime` int(11) DEFAULT NULL COMMENT 'Время принятия платежа',
  `server` int(11) NOT NULL,
  `log` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `bigauth`
--

CREATE TABLE IF NOT EXISTS `bigauth` (
  `secretq` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `secreta` varchar(255) CHARACTER SET utf32 DEFAULT NULL,
  `username` varchar(50) CHARACTER SET utf32 NOT NULL,
  `vk` bigint(20) unsigned DEFAULT NULL,
  `vka` bit(1) NOT NULL DEFAULT b'0',
  `sessionIP` varchar(15) DEFAULT NULL,
  `sessionUntil` timestamp NULL DEFAULT NULL,
  `lastActivity` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `AD_ADMINS`
--
ALTER TABLE `AD_ADMINS`
  ADD UNIQUE KEY `login` (`login`);

--
-- Индексы таблицы `AD_BUYERS`
--
ALTER TABLE `AD_BUYERS`
  ADD KEY `id` (`id`);

--
-- Индексы таблицы `AD_CUPONS`
--
ALTER TABLE `AD_CUPONS`
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `AD_PAYMENTS`
--
ALTER TABLE `AD_PAYMENTS`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `bigauth`
--
ALTER TABLE `bigauth`
  ADD PRIMARY KEY (`username`),
  ADD KEY `vka` (`vka`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `AD_BUYERS`
--
ALTER TABLE `AD_BUYERS`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `AD_PAYMENTS`
--
ALTER TABLE `AD_PAYMENTS`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID платежа';
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
