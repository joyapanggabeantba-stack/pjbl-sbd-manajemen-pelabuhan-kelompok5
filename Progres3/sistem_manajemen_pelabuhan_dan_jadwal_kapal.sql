-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2026 at 04:37 PM
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
-- Database: `sistem_manajemen_pelabuhan_dan_jadwal_kapal`
--

-- --------------------------------------------------------

--
-- Table structure for table `dermaga`
--

CREATE TABLE `dermaga` (
  `ID_Dermaga` varchar(10) NOT NULL,
  `Nama_Dermaga` varchar(50) NOT NULL,
  `Kapasitas_Max` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_tambatan`
--

CREATE TABLE `jadwal_tambatan` (
  `ID_Jadwal` int(11) NOT NULL,
  `ID_Kapal` varchar(10) NOT NULL,
  `ID_Dermaga` varchar(10) NOT NULL,
  `ETA` datetime NOT NULL,
  `ETD` datetime NOT NULL,
  `Status_Kapal` varchar(20) NOT NULL DEFAULT 'Waiting',
  `Total_Tagihan` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kapal`
--

CREATE TABLE `kapal` (
  `ID_Kapal` varchar(10) NOT NULL,
  `Nama_Kapal` varchar(100) NOT NULL,
  `Tipe_Kapal` varchar(30) NOT NULL,
  `GT_Weight` int(11) NOT NULL,
  `LOA` decimal(5,2) NOT NULL,
  `Bendera_Negara` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kontainer`
--

CREATE TABLE `kontainer` (
  `No_Kontainer` varchar(20) NOT NULL,
  `ID_Jadwal` int(11) NOT NULL,
  `Ukuran_Kontainer` varchar(10) NOT NULL,
  `Jenis_Barang` varchar(50) NOT NULL,
  `Koordinat_Yard` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dermaga`
--
ALTER TABLE `dermaga`
  ADD PRIMARY KEY (`ID_Dermaga`);

--
-- Indexes for table `jadwal_tambatan`
--
ALTER TABLE `jadwal_tambatan`
  ADD PRIMARY KEY (`ID_Jadwal`),
  ADD KEY `ID_Kapal` (`ID_Kapal`),
  ADD KEY `ID_Dermaga` (`ID_Dermaga`);

--
-- Indexes for table `kapal`
--
ALTER TABLE `kapal`
  ADD PRIMARY KEY (`ID_Kapal`);

--
-- Indexes for table `kontainer`
--
ALTER TABLE `kontainer`
  ADD PRIMARY KEY (`No_Kontainer`),
  ADD KEY `ID_Jadwal` (`ID_Jadwal`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jadwal_tambatan`
--
ALTER TABLE `jadwal_tambatan`
  MODIFY `ID_Jadwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jadwal_tambatan`
--
ALTER TABLE `jadwal_tambatan`
  ADD CONSTRAINT `jadwal_tambatan_ibfk_1` FOREIGN KEY (`ID_Kapal`) REFERENCES `kapal` (`ID_Kapal`) ON UPDATE CASCADE,
  ADD CONSTRAINT `jadwal_tambatan_ibfk_2` FOREIGN KEY (`ID_Dermaga`) REFERENCES `dermaga` (`ID_Dermaga`) ON UPDATE CASCADE;

--
-- Constraints for table `kontainer`
--
ALTER TABLE `kontainer`
  ADD CONSTRAINT `kontainer_ibfk_1` FOREIGN KEY (`ID_Jadwal`) REFERENCES `jadwal_tambatan` (`ID_Jadwal`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
