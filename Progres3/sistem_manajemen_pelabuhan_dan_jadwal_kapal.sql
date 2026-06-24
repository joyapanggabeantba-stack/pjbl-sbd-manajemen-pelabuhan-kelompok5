-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 24 Jun 2026 pada 16.53
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

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
-- Struktur dari tabel `dermaga`
--

CREATE TABLE `dermaga` (
  `ID_Dermaga` varchar(10) NOT NULL,
  `Nama_Dermaga` varchar(50) NOT NULL,
  `Kapasitas_Max` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dermaga`
--

INSERT INTO `dermaga` (`ID_Dermaga`, `Nama_Dermaga`, `Kapasitas_Max`) VALUES
('DMG-01', 'Dermaga Utara 1', 200),
('DMG-02', 'Dermaga Selatan 2', 100);

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal_tambatan`
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

--
-- Dumping data untuk tabel `jadwal_tambatan`
--

INSERT INTO `jadwal_tambatan` (`ID_Jadwal`, `ID_Kapal`, `ID_Dermaga`, `ETA`, `ETD`, `Status_Kapal`, `Total_Tagihan`) VALUES
(1, 'KPL-01', 'DMG-01', '2026-06-25 08:00:00', '2026-06-27 17:00:00', 'Berthed', 25000000.00),
(2, 'KPL-02', 'DMG-02', '2026-06-28 10:00:00', '2026-06-28 15:00:00', 'Waiting', 5000000.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kapal`
--

CREATE TABLE `kapal` (
  `ID_Kapal` varchar(10) NOT NULL,
  `Nama_Kapal` varchar(100) NOT NULL,
  `Tipe_Kapal` varchar(30) NOT NULL,
  `GT_Weight` int(11) NOT NULL,
  `LOA` decimal(5,2) NOT NULL,
  `Bendera_Negara` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kapal`
--

INSERT INTO `kapal` (`ID_Kapal`, `Nama_Kapal`, `Tipe_Kapal`, `GT_Weight`, `LOA`, `Bendera_Negara`) VALUES
('KPL-01', 'Samudera Jaya', 'Kargo', 15000, 145.50, 'Indonesia'),
('KPL-02', 'Nusantara Indah', 'Penumpang', 8000, 95.00, 'Indonesia');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kontainer`
--

CREATE TABLE `kontainer` (
  `No_Kontainer` varchar(20) NOT NULL,
  `ID_Jadwal` int(11) NOT NULL,
  `Ukuran_Kontainer` varchar(10) NOT NULL,
  `Jenis_Barang` varchar(50) NOT NULL,
  `Koordinat_Yard` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kontainer`
--

INSERT INTO `kontainer` (`No_Kontainer`, `ID_Jadwal`, `Ukuran_Kontainer`, `Jenis_Barang`, `Koordinat_Yard`) VALUES
('MSCU1234567', 1, '40 feet', 'Elektronik', 'Blok A-Slot 05'),
('NYKU7654321', 1, '20 feet', 'Bahan Makanan', 'Blok B-Slot 02');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dermaga`
--
ALTER TABLE `dermaga`
  ADD PRIMARY KEY (`ID_Dermaga`);

--
-- Indeks untuk tabel `jadwal_tambatan`
--
ALTER TABLE `jadwal_tambatan`
  ADD PRIMARY KEY (`ID_Jadwal`),
  ADD KEY `ID_Kapal` (`ID_Kapal`),
  ADD KEY `ID_Dermaga` (`ID_Dermaga`);

--
-- Indeks untuk tabel `kapal`
--
ALTER TABLE `kapal`
  ADD PRIMARY KEY (`ID_Kapal`);

--
-- Indeks untuk tabel `kontainer`
--
ALTER TABLE `kontainer`
  ADD PRIMARY KEY (`No_Kontainer`),
  ADD KEY `ID_Jadwal` (`ID_Jadwal`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `jadwal_tambatan`
--
ALTER TABLE `jadwal_tambatan`
  MODIFY `ID_Jadwal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `jadwal_tambatan`
--
ALTER TABLE `jadwal_tambatan`
  ADD CONSTRAINT `jadwal_tambatan_ibfk_1` FOREIGN KEY (`ID_Kapal`) REFERENCES `kapal` (`ID_Kapal`) ON UPDATE CASCADE,
  ADD CONSTRAINT `jadwal_tambatan_ibfk_2` FOREIGN KEY (`ID_Dermaga`) REFERENCES `dermaga` (`ID_Dermaga`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `kontainer`
--
ALTER TABLE `kontainer`
  ADD CONSTRAINT `kontainer_ibfk_1` FOREIGN KEY (`ID_Jadwal`) REFERENCES `jadwal_tambatan` (`ID_Jadwal`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
