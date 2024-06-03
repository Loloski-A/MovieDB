-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 02, 2024 at 07:19 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `moviedatabase`
--

-- --------------------------------------------------------

--
-- Table structure for table `cast`
--

CREATE TABLE `cast` (
  `castid` int(11) NOT NULL,
  `castname` varchar(50) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `biography` varchar(255) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `gender` varchar(20) DEFAULT 'male',
  `socialmedialinks` varchar(255) DEFAULT NULL,
  `datejoined` datetime DEFAULT NULL,
  `isadmin` tinyint(1) DEFAULT 0,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `profileimageurl` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE `director` (
  `directorid` int(11) NOT NULL,
  `directorname` varchar(50) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `biography` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `socialmedialinks` varchar(100) DEFAULT NULL,
  `datejoined` datetime DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `profileimageurl` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `genreid` int(11) NOT NULL,
  `genrename` varchar(50) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE `language` (
  `languageid` int(11) NOT NULL,
  `languagename` varchar(50) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `mediaid` int(11) NOT NULL,
  `mediatype` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `movieid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `releasedate` date NOT NULL,
  `synopsis` text NOT NULL,
  `duration` time NOT NULL,
  `posterurl` varchar(255) DEFAULT NULL,
  `trailerurl` varchar(255) DEFAULT NULL,
  `dateadded` datetime NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `deletedby` int(11) NOT NULL,
  `datedeleted` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `moviecast`
--

CREATE TABLE `moviecast` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `castid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `moviedirector`
--

CREATE TABLE `moviedirector` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `directorid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `moviegenre`
--

CREATE TABLE `moviegenre` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `genreid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `movielanguage`
--

CREATE TABLE `movielanguage` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `languageid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `moviemedia`
--

CREATE TABLE `moviemedia` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `mediaid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `movieproductioncompany`
--

CREATE TABLE `movieproductioncompany` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `companyid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `movieratings`
--

CREATE TABLE `movieratings` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `ratingid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `movieresolution`
--

CREATE TABLE `movieresolution` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `resolutionid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `privileges`
--

CREATE TABLE `privileges` (
  `privilegeid` int(11) NOT NULL,
  `privilegename` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `productioncompany`
--

CREATE TABLE `productioncompany` (
  `companyid` int(11) NOT NULL,
  `companyname` varchar(50) DEFAULT NULL,
  `headquarters` varchar(100) DEFAULT NULL,
  `logourl` varchar(100) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `ratingid` int(11) NOT NULL,
  `ratingvalue` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resolution`
--

CREATE TABLE `resolution` (
  `resolutionid` int(11) NOT NULL,
  `resolutiontype` varchar(50) DEFAULT NULL,
  `resolutionquality` varchar(25) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `roleid` int(11) NOT NULL,
  `roletype` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userid` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `datejoined` datetime NOT NULL,
  `isadmin` tinyint(1) DEFAULT NULL,
  `dateadded` datetime NOT NULL,
  `addedby` int(11) NOT NULL,
  `profileimageurl` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userprivilege`
--

CREATE TABLE `userprivilege` (
  `id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `privilegeid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cast`
--
ALTER TABLE `cast`
  ADD PRIMARY KEY (`castid`),
  ADD KEY `addedby` (`addedby`),
  ADD KEY `roleid` (`roleid`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`directorid`),
  ADD KEY `addedby` (`addedby`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`genreid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`languageid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`mediaid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`movieid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `moviecast`
--
ALTER TABLE `moviecast`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `castid` (`castid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `moviedirector`
--
ALTER TABLE `moviedirector`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `directorid` (`directorid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `moviegenre`
--
ALTER TABLE `moviegenre`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `genreid` (`genreid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `movielanguage`
--
ALTER TABLE `movielanguage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `languageid` (`languageid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `moviemedia`
--
ALTER TABLE `moviemedia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `mediaid` (`mediaid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `movieproductioncompany`
--
ALTER TABLE `movieproductioncompany`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `companyid` (`companyid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `movieratings`
--
ALTER TABLE `movieratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `ratingid` (`ratingid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `movieresolution`
--
ALTER TABLE `movieresolution`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `resolutionid` (`resolutionid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `privileges`
--
ALTER TABLE `privileges`
  ADD PRIMARY KEY (`privilegeid`);

--
-- Indexes for table `productioncompany`
--
ALTER TABLE `productioncompany`
  ADD PRIMARY KEY (`companyid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`ratingid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `resolution`
--
ALTER TABLE `resolution`
  ADD KEY `resolutionid` (`resolutionid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`roleid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userid`),
  ADD KEY `addedby` (`addedby`);

--
-- Indexes for table `userprivilege`
--
ALTER TABLE `userprivilege`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `privilegeid` (`privilegeid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cast`
--
ALTER TABLE `cast`
  MODIFY `castid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `director`
--
ALTER TABLE `director`
  MODIFY `directorid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genre`
--
ALTER TABLE `genre`
  MODIFY `genreid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
  MODIFY `languageid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `mediaid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `movie`
--
ALTER TABLE `movie`
  MODIFY `movieid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `moviecast`
--
ALTER TABLE `moviecast`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `moviedirector`
--
ALTER TABLE `moviedirector`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `moviemedia`
--
ALTER TABLE `moviemedia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `movieproductioncompany`
--
ALTER TABLE `movieproductioncompany`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `movieratings`
--
ALTER TABLE `movieratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `movieresolution`
--
ALTER TABLE `movieresolution`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `privileges`
--
ALTER TABLE `privileges`
  MODIFY `privilegeid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `productioncompany`
--
ALTER TABLE `productioncompany`
  MODIFY `companyid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `ratingid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resolution`
--
ALTER TABLE `resolution`
  MODIFY `resolutionid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `roleid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userprivilege`
--
ALTER TABLE `userprivilege`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cast`
--
ALTER TABLE `cast`
  ADD CONSTRAINT `cast_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `cast_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`),
  ADD CONSTRAINT `cast_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`);

--
-- Constraints for table `director`
--
ALTER TABLE `director`
  ADD CONSTRAINT `director_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `director_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`);

--
-- Constraints for table `genre`
--
ALTER TABLE `genre`
  ADD CONSTRAINT `genre_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `genre_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `language`
--
ALTER TABLE `language`
  ADD CONSTRAINT `language_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `language_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `media_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `media_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `movie`
--
ALTER TABLE `movie`
  ADD CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `movie_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `moviecast`
--
ALTER TABLE `moviecast`
  ADD CONSTRAINT `moviecast_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `moviecast_ibfk_2` FOREIGN KEY (`castid`) REFERENCES `cast` (`castid`),
  ADD CONSTRAINT `moviecast_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `moviecast_ibfk_4` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `moviedirector`
--
ALTER TABLE `moviedirector`
  ADD CONSTRAINT `moviedirector_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `moviedirector_ibfk_2` FOREIGN KEY (`directorid`) REFERENCES `director` (`directorid`),
  ADD CONSTRAINT `moviedirector_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `moviedirector_ibfk_4` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `moviegenre`
--
ALTER TABLE `moviegenre`
  ADD CONSTRAINT `moviegenre_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `moviegenre_ibfk_2` FOREIGN KEY (`genreid`) REFERENCES `genre` (`genreid`),
  ADD CONSTRAINT `moviegenre_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `moviegenre_ibfk_4` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `movielanguage`
--
ALTER TABLE `movielanguage`
  ADD CONSTRAINT `movielanguage_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `movielanguage_ibfk_2` FOREIGN KEY (`languageid`) REFERENCES `language` (`languageid`),
  ADD CONSTRAINT `movielanguage_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `movielanguage_ibfk_4` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `moviemedia`
--
ALTER TABLE `moviemedia`
  ADD CONSTRAINT `moviemedia_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `moviemedia_ibfk_2` FOREIGN KEY (`mediaid`) REFERENCES `media` (`mediaid`),
  ADD CONSTRAINT `moviemedia_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `moviemedia_ibfk_4` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `movieproductioncompany`
--
ALTER TABLE `movieproductioncompany`
  ADD CONSTRAINT `movieproductioncompany_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `movieproductioncompany_ibfk_2` FOREIGN KEY (`companyid`) REFERENCES `productioncompany` (`companyid`),
  ADD CONSTRAINT `movieproductioncompany_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `movieproductioncompany_ibfk_4` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `movieratings`
--
ALTER TABLE `movieratings`
  ADD CONSTRAINT `movieratings_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `movieratings_ibfk_2` FOREIGN KEY (`ratingid`) REFERENCES `ratings` (`ratingid`),
  ADD CONSTRAINT `movieratings_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `movieratings_ibfk_4` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `movieresolution`
--
ALTER TABLE `movieresolution`
  ADD CONSTRAINT `movieresolution_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `movieresolution_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `movieresolution_ibfk_3` FOREIGN KEY (`resolutionid`) REFERENCES `resolution` (`resolutionid`),
  ADD CONSTRAINT `movieresolution_ibfk_4` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `productioncompany`
--
ALTER TABLE `productioncompany`
  ADD CONSTRAINT `productioncompany_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `productioncompany_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `resolution`
--
ALTER TABLE `resolution`
  ADD CONSTRAINT `resolution_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `resolution_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `userprivilege`
--
ALTER TABLE `userprivilege`
  ADD CONSTRAINT `userprivilege_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `userprivilege_ibfk_2` FOREIGN KEY (`privilegeid`) REFERENCES `privileges` (`privilegeid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
