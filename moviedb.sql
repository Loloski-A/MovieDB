-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 07, 2024 at 11:10 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `moviedb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkcast` (`$castid` INT, `$castname` VARCHAR(50))   BEGIN
             select * 
             from `cast`
             where `castid` != $castid and `castname` = $castname;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkdirector` (`$directorid` INT, `$directorname` VARCHAR(55))   BEGIN
              select * 
              from `director`
              where `directorid` != $directorid and `directorname` = $directorname;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkgenre` (`$genreid` INT, `$genrename` VARCHAR(50))   BEGIN
              select * from `genre`
              where `genreid` != $genreid and `genrename` = $genrename
              and `deleted` = 0;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deletecast` (`$castid` INT, `$deletedby` INT)   BEGIN
            update `cast`
            set `deleted` = 1, `datedeleted` = now(), `deletedby` = $deletedby
            where `cast` = $castid;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deletedirector` (`$directorid` INT, `$deletedby` INT)   BEGIN
             update `director`
             set `deleted` = 1, `datedeleted` = now(), `deletedby` = $deletedby
             where `directorid` = $directorid;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deletegenre` (`$genreid` INT, `$userid` INT)   BEGIN
               update `genre`
               set `deleted` = 1, `datedeleted` = now(), `deletedby` = $userid
               where `genreid` = $genreid;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcast` ()   BEGIN
              select c.* , nationalityname , roletype, concat(`firstname`,' ',`lastname`) addedbyname
              from `cast` c
              join `user` u on u.userid = c.addedby
              join `nationality` n on n.nationalityid = c.nationality
              join `role` r on r.roleid = c.roleid
              where c.deleted = 0
              order by `castname`;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcastdetails` (`$castid` INT)   BEGIN
           select *
           from `cast`
           where `castid` = $castid;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getdirector` ()   BEGIN
            select d.* , nationalityname , concat(`firstname`,' ',`lastname`)addedbyname
            from `director` d
            join `user` u on u.userid = d.addedby
            join `nationality` n on n.nationalityid = d.nationality
            where d.deleted = 0
            order by `directorname`;            
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getdirectordetails` (`$directorid` INT)   BEGIN
           select * from`director`
           where `directorid` = $directorid;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getgenre` ()   BEGIN
           select g.*, concat(`firstname`,' ',`lastname`) addedby
           from `genre` g
           join `user` s on s.`userid` = g.`addedby`
           where `deleted` = 0
           order by `genrename`;
           
        /* SELECT g.*, CONCAT('firstname',' ','lastname') addedby
           FROM `genrename` g , `user` s
           where s.`userid` = g.`addedby` */
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getgenredetails` (`$genreid` INT)   BEGIN
            select * from `genre`
            where `genreid` = $genreid;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecast` (`$castid` INT, `$castname` VARCHAR(50), `$dob` DATE, `$biography` VARCHAR(255), `$roleid` INT, `$nationality` INT, `$gender` VARCHAR(20), `$socialmedialinks` VARCHAR(255), `$addedby` INT, `$profileimageurl` VARCHAR(255))   BEGIN
            if $castid = 0 then
                insert into `cast` (`castname`, `dob`, `nationality`, `biography`, `roleid`, `gender`,
                 `socialmedialinks`, `dateadded`, `addedby`, `profileimageurl`)
                values ($castname, $dob, $nationality, $biography, $roleid, $gender, 
                $socialmedialinks, NOW(), $addedby, $profileimageurl);          
            else
                update `cast` 
                set `castname` = $castname, `dob` = $dob, `nationality` = $nationality,
                `biography` = $biography, `gender` = $gender, `roleid` = $roleid,
                `socialmedialinks` = $socialmedialinks
                where `castid` = $castid;
            end if;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savedirector` (`$directorid` INT, `$directorname` VARCHAR(55), `$dob` DATE, `$biography` VARCHAR(255), `$nationality` INT, `$gender` VARCHAR(50), `$socialmedialinks` VARCHAR(100), `$addedby` INT, `$profileimageurl` VARCHAR(100))   BEGIN
             if $directorid = 0 then 
                   insert into `director` (`directorname`, `dob`, `biography`, `nationality`, `gender`, `socialmedialinks`, 
                   `dateadded`, `addedby`, `profileimageurl`)
                   values($directorname, $dob, $biography, $nationality, $gender, $socialmedialinks, 
                   now(), $addedby, $profileimageurl);
             else 
                    update `director`
                    set `directorname` = $directorname, `dob` = $dob, `biography` = $biography,
                    `nationality` = $nationality, `gender` = $gender
                    where `directorid` = $directorid;
             end if;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savegenre` (`$genreid` INT, `$genrename` VARCHAR(50), `$description` VARCHAR(200), `$addedby` INT)   BEGIN
              if $genreid = 0 then 
                   insert into `genre`(`genrename`,`description`,`dateadded`,`addedby`)
                   value ($genrename,$description,now(),$addedby);
              else
                   update `genre`
                   set `genrename` = $genrename, `description` = $description
                   where `genreid` = $genreid;
              end if;
	END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cast`
--

CREATE TABLE `cast` (
  `castid` int(11) NOT NULL,
  `castname` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `nationality` int(11) DEFAULT NULL,
  `biography` varchar(255) DEFAULT NULL,
  `gender` varchar(20) DEFAULT 'male',
  `roleid` int(11) DEFAULT NULL,
  `socialmedialinks` varchar(255) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `profileimageurl` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ;

--
-- Dumping data for table `cast`
--

INSERT INTO `cast` (`castid`, `castname`, `dob`, `nationality`, `biography`, `gender`, `roleid`, `socialmedialinks`, `dateadded`, `addedby`, `profileimageurl`, `deleted`, `datedeleted`, `deletedby`) VALUES
(1, 'Russell Crowe', '1964-04-07', 2, 'Russell Crowe, born in Wellington, New Zealand, gained acting experience early in life.', 'Male', 1, 'Russel@gmail.com', '2024-07-24 00:00:00', 1, 'russel.png', 0, NULL, NULL),
(2, 'Jet Li', '1963-04-26', 1, 'is a Chinese-born Singaporean martial artist and actor.', 'male', 1, 'Jetli@gmail.com', '2024-07-31 12:57:41', 3, 'Jetli.png', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE `director` (
  `directorid` int(11) NOT NULL,
  `directorname` varchar(55) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `biography` varchar(255) DEFAULT NULL,
  `nationality` int(11) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `socialmedialinks` varchar(100) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `profileimageurl` varchar(100) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ;

--
-- Dumping data for table `director`
--

INSERT INTO `director` (`directorid`, `directorname`, `dob`, `biography`, `nationality`, `gender`, `socialmedialinks`, `dateadded`, `addedby`, `profileimageurl`, `deleted`, `datedeleted`, `deletedby`) VALUES
(1, 'Ridley Scott', '1937-11-30', 'was born on November 30, 1937 in South Shields, Tyne and Wear. ', 1, 'Male', 'Ridley@gmail.com', '2024-07-24 00:00:00', 1, 'ridley.png', 0, NULL, NULL),
(2, 'Charles Nerwith', '1955-08-22', 'is an American film director', 1, 'male', 'Charles@gmail.com', '2024-07-31 13:03:24', 2, 'charles.png', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `genreid` int(11) NOT NULL,
  `genrename` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`genreid`, `genrename`, `description`, `dateadded`, `addedby`, `deleted`, `datedeleted`, `deletedby`) VALUES
(1, 'Action', 'genre that predominantly features chase sequences, fights, shootouts, explosions, and stunt work.', '2024-07-25 08:30:26', 1, 0, NULL, NULL),
(2, 'Science-fiction(SCI-FI)', ' is a film genre that uses speculative, fictional science-based depictions of phenomena that are not fully accepted by mainstream science', '2024-07-31 13:05:12', 2, 0, NULL, NULL),
(3, 'Thriller', 'motion pictures with suspense', '2024-07-31 22:39:20', 1, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE `language` (
  `languageid` int(11) NOT NULL,
  `languagename` varchar(50) DEFAULT NULL,
  `languagecode` varchar(10) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `deletedby` int(11) DEFAULT NULL,
  `datedeleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`languageid`, `languagename`, `languagecode`, `dateadded`, `addedby`, `deleted`, `deletedby`, `datedeleted`) VALUES
(1, 'English', 'en', '2024-07-25 08:36:03', 1, 0, NULL, NULL),
(2, 'Chinese', 'ch', '2024-07-31 13:05:49', 2, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `mediaid` int(11) NOT NULL,
  `mediatype` varchar(50) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `filepath` varchar(255) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `deletedby` int(11) DEFAULT NULL,
  `datedeleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`mediaid`, `mediatype`, `title`, `description`, `filepath`, `dateadded`, `addedby`, `deleted`, `deletedby`, `datedeleted`) VALUES
(1, 'video', 'movie trailer', 'Official trailer for the movie ', 'https://example.com/media/movie_trailer.mp4', '2024-07-25 08:39:52', 1, 0, NULL, NULL),
(2, 'Audio', 'movie music', 'Background music for the movie ', 'https://example.com/media/movie_trailer.mp3', NULL, 2, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `movieid` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `releasedate` datetime DEFAULT NULL,
  `synopsis` varchar(255) DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `posterurl` varchar(255) DEFAULT NULL,
  `trailerurl` varchar(255) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `deletedby` int(11) DEFAULT NULL,
  `datedeleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`movieid`, `userid`, `title`, `releasedate`, `synopsis`, `duration`, `posterurl`, `trailerurl`, `dateadded`, `deleted`, `deletedby`, `datedeleted`) VALUES
(1, 1, 'Gladiator', '2000-02-08 00:00:00', 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.', '00:00:02', 'gladiator.jpg', 'https://youtube/gladiator.com', '2024-07-24 22:33:46', 0, NULL, NULL),
(2, 3, 'The One', '2001-11-02 16:10:08', 'The film, which deals with the concept of multiverses and interdimensional travel', '00:01:20', 'TheOne.png', 'https://youtube/TheOne.com', '2024-07-26 16:13:14', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `moviecast`
--

CREATE TABLE `moviecast` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `castid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `moviecast`
--

INSERT INTO `moviecast` (`id`, `movieid`, `castid`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `moviedirector`
--

CREATE TABLE `moviedirector` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `directorid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `moviedirector`
--

INSERT INTO `moviedirector` (`id`, `movieid`, `directorid`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `moviegenre`
--

CREATE TABLE `moviegenre` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `genreid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `moviegenre`
--

INSERT INTO `moviegenre` (`id`, `movieid`, `genreid`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `movielanguage`
--

CREATE TABLE `movielanguage` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `languageid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movielanguage`
--

INSERT INTO `movielanguage` (`id`, `movieid`, `languageid`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `moviemedia`
--

CREATE TABLE `moviemedia` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `mediaid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `moviemedia`
--

INSERT INTO `moviemedia` (`id`, `movieid`, `mediaid`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `movieproductioncompany`
--

CREATE TABLE `movieproductioncompany` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `companyid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movieproductioncompany`
--

INSERT INTO `movieproductioncompany` (`id`, `movieid`, `companyid`) VALUES
(1, 1, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `movieratings`
--

CREATE TABLE `movieratings` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `ratingid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movieratings`
--

INSERT INTO `movieratings` (`id`, `movieid`, `ratingid`) VALUES
(1, 1, 1),
(2, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `movieresolution`
--

CREATE TABLE `movieresolution` (
  `id` int(11) NOT NULL,
  `movieid` int(11) DEFAULT NULL,
  `resolutionid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movieresolution`
--

INSERT INTO `movieresolution` (`id`, `movieid`, `resolutionid`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `nationality`
--

CREATE TABLE `nationality` (
  `nationalityid` int(11) NOT NULL,
  `nationalityname` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `nationality`
--

INSERT INTO `nationality` (`nationalityid`, `nationalityname`) VALUES
(1, 'Chinese'),
(2, 'USA');

-- --------------------------------------------------------

--
-- Table structure for table `privileges`
--

CREATE TABLE `privileges` (
  `privilegeid` int(11) NOT NULL,
  `privilegename` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `privileges`
--

INSERT INTO `privileges` (`privilegeid`, `privilegename`, `description`) VALUES
(1, 'Admin', 'Has full access to all features and settings.'),
(2, 'User_Support', ' the right of a user account to perform a particular system-related operation');

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
  `addedby` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `productioncompany`
--

INSERT INTO `productioncompany` (`companyid`, `companyname`, `headquarters`, `logourl`, `website`, `description`, `dateadded`, `addedby`, `deleted`, `datedeleted`, `deletedby`) VALUES
(1, 'DreamWorks Pictures', 'California', 'https://en.wikipedia.org/wiki/File:DreamWorks_Pictures.svg', 'https://www.dreamworks.com', 'is an American film studio and distribution label of Amblin Partners', '2024-07-25 08:07:02', 1, 0, NULL, NULL),
(2, 'Columbia Pictures', 'Calirfonia', 'https://en.wikipedia.org/wiki/File:Columbia_Pictures.svg', 'https://www.ColumbiaPictures.com', ' is an American film production and distribution company that is a member of the Sony Pictures Motion Picture Group', '2024-07-31 13:32:10', 2, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `ratingid` int(11) NOT NULL,
  `ratingvalue` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`ratingid`, `ratingvalue`, `dateadded`, `addedby`, `deleted`, `datedeleted`, `deletedby`) VALUES
(1, 5, '2024-07-25 08:10:34', 3, 0, NULL, NULL),
(2, 4, '2024-07-31 13:33:31', 2, 0, NULL, NULL),
(3, NULL, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `resolution`
--

CREATE TABLE `resolution` (
  `resolutionid` int(11) NOT NULL,
  `resolutiontype` varchar(50) DEFAULT NULL,
  `resolutionquality` varchar(25) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `resolution`
--

INSERT INTO `resolution` (`resolutionid`, `resolutiontype`, `resolutionquality`, `dateadded`, `addedby`, `deleted`, `datedeleted`, `deletedby`) VALUES
(1, '480p', 'Standard Defination(SD)', '2024-07-25 08:57:55', 1, 0, NULL, NULL),
(2, '720p', 'High Standard Defination', '2024-07-31 13:34:19', 2, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `roleid` int(11) NOT NULL,
  `roletype` varchar(50) DEFAULT NULL,
  `roledescription` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`roleid`, `roletype`, `roledescription`) VALUES
(1, 'lead', 'portrays the primary character in a the film');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userid` int(11) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `datejoined` datetime DEFAULT NULL,
  `isadmin` tinyint(1) DEFAULT NULL,
  `profileimageurl` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userid`, `firstname`, `lastname`, `email`, `password`, `datejoined`, `isadmin`, `profileimageurl`) VALUES
(1, 'System ', 'Admin', 'Admin1@gmail.com', '123456', '2024-06-01 00:00:00', 1, 'Loloski.png'),
(2, 'System', 'Admin', 'Admin2@gmail.com', '654321', '2024-07-01 22:19:12', 1, 'admin2.png'),
(3, 'User ', 'Support', 'user1@gmail.com', '235233', '2024-07-25 08:09:57', 0, 'user1.png');

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
-- Dumping data for table `userprivilege`
--

INSERT INTO `userprivilege` (`id`, `userid`, `privilegeid`) VALUES
(1, 1, 1);

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
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`directorid`),
  ADD KEY `addedby` (`addedby`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`genreid`),
  ADD KEY `userid` (`addedby`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`languageid`),
  ADD KEY `addedby` (`addedby`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`mediaid`),
  ADD KEY `addedby` (`addedby`),
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
  ADD KEY `castid` (`castid`);

--
-- Indexes for table `moviedirector`
--
ALTER TABLE `moviedirector`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `directorid` (`directorid`);

--
-- Indexes for table `moviegenre`
--
ALTER TABLE `moviegenre`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `genreid` (`genreid`);

--
-- Indexes for table `movielanguage`
--
ALTER TABLE `movielanguage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `languageid` (`languageid`);

--
-- Indexes for table `moviemedia`
--
ALTER TABLE `moviemedia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `mediaid` (`mediaid`);

--
-- Indexes for table `movieproductioncompany`
--
ALTER TABLE `movieproductioncompany`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `companyid` (`companyid`);

--
-- Indexes for table `movieratings`
--
ALTER TABLE `movieratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `ratingid` (`ratingid`);

--
-- Indexes for table `movieresolution`
--
ALTER TABLE `movieresolution`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movieid` (`movieid`),
  ADD KEY `resolutionid` (`resolutionid`);

--
-- Indexes for table `nationality`
--
ALTER TABLE `nationality`
  ADD PRIMARY KEY (`nationalityid`);

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
  ADD KEY `userid` (`addedby`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`ratingid`),
  ADD KEY `userid` (`addedby`),
  ADD KEY `deletedby` (`deletedby`);

--
-- Indexes for table `resolution`
--
ALTER TABLE `resolution`
  ADD KEY `resolutionid` (`resolutionid`),
  ADD KEY `userid` (`addedby`),
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
  ADD PRIMARY KEY (`userid`);

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
  MODIFY `genreid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
  MODIFY `languageid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `mediaid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `movie`
--
ALTER TABLE `movie`
  MODIFY `movieid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `moviecast`
--
ALTER TABLE `moviecast`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `moviedirector`
--
ALTER TABLE `moviedirector`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `moviegenre`
--
ALTER TABLE `moviegenre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `movielanguage`
--
ALTER TABLE `movielanguage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `moviemedia`
--
ALTER TABLE `moviemedia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `movieproductioncompany`
--
ALTER TABLE `movieproductioncompany`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `movieratings`
--
ALTER TABLE `movieratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `movieresolution`
--
ALTER TABLE `movieresolution`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `nationality`
--
ALTER TABLE `nationality`
  MODIFY `nationalityid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `privileges`
--
ALTER TABLE `privileges`
  MODIFY `privilegeid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `productioncompany`
--
ALTER TABLE `productioncompany`
  MODIFY `companyid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `ratingid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `resolution`
--
ALTER TABLE `resolution`
  MODIFY `resolutionid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `roleid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `userprivilege`
--
ALTER TABLE `userprivilege`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cast`
--
ALTER TABLE `cast`
  ADD CONSTRAINT `cast_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `cast_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`),
  ADD CONSTRAINT `cast_ibfk_3` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `director`
--
ALTER TABLE `director`
  ADD CONSTRAINT `director_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `director_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `genre`
--
ALTER TABLE `genre`
  ADD CONSTRAINT `genre_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `genre_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `language`
--
ALTER TABLE `language`
  ADD CONSTRAINT `language_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `language_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `media_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `user` (`userid`),
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
  ADD CONSTRAINT `moviecast_ibfk_2` FOREIGN KEY (`castid`) REFERENCES `cast` (`castid`);

--
-- Constraints for table `moviedirector`
--
ALTER TABLE `moviedirector`
  ADD CONSTRAINT `moviedirector_ibfk_3` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `moviedirector_ibfk_4` FOREIGN KEY (`directorid`) REFERENCES `director` (`directorid`);

--
-- Constraints for table `moviegenre`
--
ALTER TABLE `moviegenre`
  ADD CONSTRAINT `moviegenre_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `moviegenre_ibfk_2` FOREIGN KEY (`genreid`) REFERENCES `genre` (`genreid`);

--
-- Constraints for table `movielanguage`
--
ALTER TABLE `movielanguage`
  ADD CONSTRAINT `movielanguage_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `movielanguage_ibfk_2` FOREIGN KEY (`languageid`) REFERENCES `language` (`languageid`);

--
-- Constraints for table `moviemedia`
--
ALTER TABLE `moviemedia`
  ADD CONSTRAINT `moviemedia_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `moviemedia_ibfk_2` FOREIGN KEY (`mediaid`) REFERENCES `media` (`mediaid`);

--
-- Constraints for table `movieproductioncompany`
--
ALTER TABLE `movieproductioncompany`
  ADD CONSTRAINT `movieproductioncompany_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `movieproductioncompany_ibfk_2` FOREIGN KEY (`companyid`) REFERENCES `productioncompany` (`companyid`);

--
-- Constraints for table `movieratings`
--
ALTER TABLE `movieratings`
  ADD CONSTRAINT `movieratings_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `movieratings_ibfk_2` FOREIGN KEY (`ratingid`) REFERENCES `ratings` (`ratingid`);

--
-- Constraints for table `movieresolution`
--
ALTER TABLE `movieresolution`
  ADD CONSTRAINT `movieresolution_ibfk_1` FOREIGN KEY (`movieid`) REFERENCES `movie` (`movieid`),
  ADD CONSTRAINT `movieresolution_ibfk_3` FOREIGN KEY (`resolutionid`) REFERENCES `resolution` (`resolutionid`);

--
-- Constraints for table `nationality`
--
ALTER TABLE `nationality`
  ADD CONSTRAINT `nationality_ibfk_1` FOREIGN KEY (`nationalityid`) REFERENCES `cast` (`castid`),
  ADD CONSTRAINT `nationality_ibfk_2` FOREIGN KEY (`nationalityid`) REFERENCES `director` (`directorid`);

--
-- Constraints for table `productioncompany`
--
ALTER TABLE `productioncompany`
  ADD CONSTRAINT `productioncompany_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `productioncompany_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

--
-- Constraints for table `resolution`
--
ALTER TABLE `resolution`
  ADD CONSTRAINT `resolution_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `resolution_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `user` (`userid`);

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
