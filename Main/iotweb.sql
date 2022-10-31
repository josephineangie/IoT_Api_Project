-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 31, 2022 at 04:22 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iotweb`
--

-- --------------------------------------------------------

--
-- Table structure for table `cardreader`
--

CREATE TABLE `cardreader` (
  `idCardReader` int(11) NOT NULL,
  `idRuangan` int(11) DEFAULT NULL,
  `kodeCardReader` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cardreader`
--

INSERT INTO `cardreader` (`idCardReader`, `idRuangan`, `kodeCardReader`) VALUES
(1, 1, 'CR-Lab-Android');

-- --------------------------------------------------------

--
-- Table structure for table `carduser`
--

CREATE TABLE `carduser` (
  `idcardUser` varchar(20) NOT NULL,
  `namaUser` varchar(50) NOT NULL,
  `emailUser` varchar(50) NOT NULL,
  `prodiAsalUser` varchar(30) NOT NULL,
  `NIKuser` varchar(30) DEFAULT NULL,
  `alamatUser` varchar(50) NOT NULL,
  `noHpUser` varchar(16) DEFAULT NULL,
  `roleUser` enum('dosen','mahasiswa','tamu','penjaga lab') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `carduser`
--

INSERT INTO `carduser` (`idcardUser`, `namaUser`, `emailUser`, `prodiAsalUser`, `NIKuser`, `alamatUser`, `noHpUser`, `roleUser`) VALUES
('mh71200593', 'dedi yanto', 'dedi.yanto@ti.ukdw.ac.id', 'TI', '640592345', 'Sleman City Mall', '852456789', 'mahasiswa'),
('mh71200660', 'Shinra', 'shinra@gmail.com', 'SI', '65122357882', 'Godean', '082212134567', 'mahasiswa'),
('mh71200662', 'Jul Very', 'jul.very@gmail.com', 'TI', '566229123', 'Sleman City Mall', '085612344752', 'mahasiswa'),
('mh72200692', 'Veronica Imelda', 'veronica26@gmail.com', 'SI', '613012344561', 'Condong Catur', '081213567871', 'tamu');

-- --------------------------------------------------------

--
-- Table structure for table `fakultas`
--

CREATE TABLE `fakultas` (
  `idFakultas` varchar(10) NOT NULL,
  `namaFakultas` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fakultas`
--

INSERT INTO `fakultas` (`idFakultas`, `namaFakultas`) VALUES
('FB', 'Fakultas Bisnis'),
('FTI', 'Fakultas Teknik Informatika');

-- --------------------------------------------------------

--
-- Table structure for table `gedung`
--

CREATE TABLE `gedung` (
  `idGedung` varchar(30) NOT NULL,
  `namaGedung` varchar(30) NOT NULL,
  `jumlahLantai` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gedung`
--

INSERT INTO `gedung` (`idGedung`, `namaGedung`, `jumlahLantai`) VALUES
('FTI1', 'Agape', 4);

-- --------------------------------------------------------

--
-- Table structure for table `prodi`
--

CREATE TABLE `prodi` (
  `idProdi` varchar(10) NOT NULL,
  `idFakultas` varchar(10) NOT NULL,
  `namaProdi` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `prodi`
--

INSERT INTO `prodi` (`idProdi`, `idFakultas`, `namaProdi`) VALUES
('SI', 'FTI', 'Sistem Informasi'),
('TI', 'FTI', 'Informatika');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `idRuangan` int(11) NOT NULL,
  `namaRuangan` varchar(30) NOT NULL,
  `kodeRuangan` varchar(30) NOT NULL,
  `deskrispsiRuangan` varchar(200) NOT NULL,
  `lokasiLantai` int(10) NOT NULL,
  `kapasitasRuangan` int(100) NOT NULL,
  `idGedung` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`idRuangan`, `namaRuangan`, `kodeRuangan`, `deskrispsiRuangan`, `lokasiLantai`, `kapasitasRuangan`, `idGedung`) VALUES
(1, 'Lab Android', 'LAB-FTI-4', 'Ruangan android', 4, 30, 'FTI1');

-- --------------------------------------------------------

--
-- Table structure for table `smartcard`
--

CREATE TABLE `smartcard` (
  `idCard` varchar(50) NOT NULL,
  `idUser` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `smartcard`
--

INSERT INTO `smartcard` (`idCard`, `idUser`) VALUES
('AGP01', 'mh71200593'),
('AGP02', 'mh71200660'),
('AGP03', 'mh71200662');

-- --------------------------------------------------------

--
-- Table structure for table `useractivity`
--

CREATE TABLE `useractivity` (
  `idActivity` int(11) NOT NULL,
  `idCardReader` int(11) DEFAULT NULL,
  `idCard` varchar(30) NOT NULL,
  `waktu` datetime NOT NULL,
  `statusAktivitas` enum('Masuk','Keluar') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `useractivity`
--

INSERT INTO `useractivity` (`idActivity`, `idCardReader`, `idCard`, `waktu`, `statusAktivitas`) VALUES
(1, 1, 'AGP01', '2022-10-24 19:31:11', 'Masuk'),
(2, 1, 'AGP01', '2022-10-24 22:32:11', 'Keluar'),
(3, 1, 'AGP01', '2022-11-30 19:11:02', 'Masuk'),
(4, 1, 'AGP01', '2022-11-30 20:11:02', 'Keluar'),
(5, 1, 'AGP02', '2022-10-31 05:51:24', 'Masuk'),
(6, 1, 'AGP02', '2022-10-31 06:52:42', 'Keluar'),
(7, 1, 'AGP02', '2022-10-31 07:42:32', 'Masuk'),
(8, 1, 'AGP02', '2022-10-31 08:42:32', 'Keluar'),
(12, 1, 'AGP03', '2022-11-01 07:59:14', 'Masuk'),
(13, 1, 'AGP03', '2022-11-03 07:59:14', 'Keluar');

-- --------------------------------------------------------

--
-- Table structure for table `userpermission`
--

CREATE TABLE `userpermission` (
  `idCard` varchar(50) NOT NULL,
  `idCardReader` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `userpermission`
--

INSERT INTO `userpermission` (`idCard`, `idCardReader`) VALUES
('AGP01', 1);

-- --------------------------------------------------------

--
-- Table structure for table `webuser`
--

CREATE TABLE `webuser` (
  `Username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `roleWebUser` enum('admin','user') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cardreader`
--
ALTER TABLE `cardreader`
  ADD PRIMARY KEY (`idCardReader`),
  ADD KEY `idRuangan` (`idRuangan`);

--
-- Indexes for table `carduser`
--
ALTER TABLE `carduser`
  ADD PRIMARY KEY (`idcardUser`),
  ADD KEY `prodiAsalUser` (`prodiAsalUser`);

--
-- Indexes for table `fakultas`
--
ALTER TABLE `fakultas`
  ADD PRIMARY KEY (`idFakultas`);

--
-- Indexes for table `gedung`
--
ALTER TABLE `gedung`
  ADD PRIMARY KEY (`idGedung`);

--
-- Indexes for table `prodi`
--
ALTER TABLE `prodi`
  ADD PRIMARY KEY (`idProdi`),
  ADD KEY `idFakultas` (`idFakultas`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`idRuangan`),
  ADD KEY `idGedung` (`idGedung`);

--
-- Indexes for table `smartcard`
--
ALTER TABLE `smartcard`
  ADD PRIMARY KEY (`idCard`),
  ADD KEY `idUser` (`idUser`);

--
-- Indexes for table `useractivity`
--
ALTER TABLE `useractivity`
  ADD PRIMARY KEY (`idActivity`),
  ADD KEY `idCardReader` (`idCardReader`),
  ADD KEY `idCard` (`idCard`);

--
-- Indexes for table `userpermission`
--
ALTER TABLE `userpermission`
  ADD PRIMARY KEY (`idCard`),
  ADD KEY `FK_userpermissionreader` (`idCardReader`);

--
-- Indexes for table `webuser`
--
ALTER TABLE `webuser`
  ADD PRIMARY KEY (`Username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cardreader`
--
ALTER TABLE `cardreader`
  MODIFY `idCardReader` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `idRuangan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `useractivity`
--
ALTER TABLE `useractivity`
  MODIFY `idActivity` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cardreader`
--
ALTER TABLE `cardreader`
  ADD CONSTRAINT `cardreader_ibfk_1` FOREIGN KEY (`idRuangan`) REFERENCES `room` (`idRuangan`);

--
-- Constraints for table `carduser`
--
ALTER TABLE `carduser`
  ADD CONSTRAINT `carduser_ibfk_1` FOREIGN KEY (`prodiAsalUser`) REFERENCES `prodi` (`idProdi`);

--
-- Constraints for table `prodi`
--
ALTER TABLE `prodi`
  ADD CONSTRAINT `prodi_ibfk_1` FOREIGN KEY (`idFakultas`) REFERENCES `fakultas` (`idFakultas`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`idGedung`) REFERENCES `gedung` (`idGedung`);

--
-- Constraints for table `smartcard`
--
ALTER TABLE `smartcard`
  ADD CONSTRAINT `smartcard_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `carduser` (`idcardUser`);

--
-- Constraints for table `useractivity`
--
ALTER TABLE `useractivity`
  ADD CONSTRAINT `useractivity_ibfk_1` FOREIGN KEY (`idCardReader`) REFERENCES `cardreader` (`idCardReader`),
  ADD CONSTRAINT `useractivity_ibfk_2` FOREIGN KEY (`idCard`) REFERENCES `smartcard` (`idCard`);

--
-- Constraints for table `userpermission`
--
ALTER TABLE `userpermission`
  ADD CONSTRAINT `FK_userpermissioncard` FOREIGN KEY (`idCard`) REFERENCES `smartcard` (`idCard`),
  ADD CONSTRAINT `FK_userpermissionreader` FOREIGN KEY (`idCardReader`) REFERENCES `cardreader` (`idCardReader`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
