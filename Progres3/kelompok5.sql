-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2026 at 05:14 PM
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
-- Database: `kelompok5`
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
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `ID_Invoice` varchar(15) NOT NULL,
  `ID_Jadwal` int(11) NOT NULL,
  `ID_Pelanggan` varchar(10) NOT NULL,
  `Total_Tagihan` decimal(12,2) NOT NULL,
  `Status_Pembayaran` varchar(15) NOT NULL DEFAULT 'Belum Lunas',
  `Tanggal_Jatuh_Tempo` date NOT NULL
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
  `ATA` datetime DEFAULT NULL,
  `ETD` datetime NOT NULL,
  `ATD` datetime DEFAULT NULL,
  `Status_Kapal` varchar(20) NOT NULL DEFAULT 'Waiting'
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
-- Table structure for table `kontainer_kargo`
--

CREATE TABLE `kontainer_kargo` (
  `No_Kontainer` varchar(20) NOT NULL,
  `ID_Jadwal` int(11) NOT NULL,
  `Ukuran_Kontainer` varchar(10) NOT NULL,
  `Jenis_Kargo` varchar(30) NOT NULL,
  `Berat_Kargo` decimal(8,2) NOT NULL,
  `Status_Pabean` varchar(15) NOT NULL DEFAULT 'Hold',
  `Koordinat_Yard` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `ID_Pelanggan` varchar(10) NOT NULL,
  `Nama_Perusahaan` varchar(100) NOT NULL,
  `Kontak` varchar(20) NOT NULL,
  `Alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dermaga`
--
ALTER TABLE `dermaga`
  ADD PRIMARY KEY (`ID_Dermaga`),
  ADD UNIQUE KEY `UQ_Nama_Dermaga` (`Nama_Dermaga`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`ID_Invoice`),
  ADD UNIQUE KEY `UQ_Jadwal_Invoice` (`ID_Jadwal`),
  ADD KEY `ID_Pelanggan` (`ID_Pelanggan`);

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
-- Indexes for table `kontainer_kargo`
--
ALTER TABLE `kontainer_kargo`
  ADD PRIMARY KEY (`No_Kontainer`),
  ADD KEY `ID_Jadwal` (`ID_Jadwal`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`ID_Pelanggan`);

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
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`ID_Jadwal`) REFERENCES `jadwal_tambatan` (`ID_Jadwal`) ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`ID_Pelanggan`) REFERENCES `pelanggan` (`ID_Pelanggan`) ON UPDATE CASCADE;

--
-- Constraints for table `jadwal_tambatan`
--
ALTER TABLE `jadwal_tambatan`
  ADD CONSTRAINT `jadwal_tambatan_ibfk_1` FOREIGN KEY (`ID_Kapal`) REFERENCES `kapal` (`ID_Kapal`) ON UPDATE CASCADE,
  ADD CONSTRAINT `jadwal_tambatan_ibfk_2` FOREIGN KEY (`ID_Dermaga`) REFERENCES `dermaga` (`ID_Dermaga`) ON UPDATE CASCADE;

--
-- Constraints for table `kontainer_kargo`
--
ALTER TABLE `kontainer_kargo`
  ADD CONSTRAINT `kontainer_kargo_ibfk_1` FOREIGN KEY (`ID_Jadwal`) REFERENCES `jadwal_tambatan` (`ID_Jadwal`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
