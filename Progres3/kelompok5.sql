-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 24 Jun 2026 pada 17.29
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
-- Database: `kelompok5`
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
('DMG-A1', 'Dermaga Internasional A1', 200),
('DMG-B1', 'Dermaga Domestik B1', 120);

-- --------------------------------------------------------

--
-- Struktur dari tabel `invoice`
--

CREATE TABLE `invoice` (
  `ID_Invoice` varchar(15) NOT NULL,
  `ID_Jadwal` int(11) NOT NULL,
  `ID_Pelanggan` varchar(10) NOT NULL,
  `Total_Tagihan` decimal(12,2) NOT NULL,
  `Status_Pembayaran` varchar(15) NOT NULL DEFAULT 'Belum Lunas',
  `Tanggal_Jatuh_Tempo` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `invoice`
--

INSERT INTO `invoice` (`ID_Invoice`, `ID_Jadwal`, `ID_Pelanggan`, `Total_Tagihan`, `Status_Pembayaran`, `Tanggal_Jatuh_Tempo`) VALUES
('INV-2026-0001', 1, 'PLG-01', 45000000.00, 'Lunas', '2026-07-20'),
('INV-2026-0002', 2, 'PLG-02', 75500000.00, 'Belum Lunas', '2026-07-24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal_tambatan`
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

--
-- Dumping data untuk tabel `jadwal_tambatan`
--

INSERT INTO `jadwal_tambatan` (`ID_Jadwal`, `ID_Kapal`, `ID_Dermaga`, `ETA`, `ATA`, `ETD`, `ATD`, `Status_Kapal`) VALUES
(1, 'KPL-001', 'DMG-A1', '2026-06-20 08:00:00', '2026-06-20 08:30:00', '2026-06-22 17:00:00', '2026-06-22 17:45:00', 'Departed'),
(2, 'KPL-002', 'DMG-A1', '2026-06-24 10:00:00', '2026-06-24 10:15:00', '2026-06-26 22:00:00', NULL, 'Unloading'),
(3, 'KPL-003', 'DMG-B1', '2026-06-25 06:00:00', NULL, '2026-06-25 12:00:00', NULL, 'Waiting');

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
('KPL-001', 'Samudera Jaya', 'Kargo', 15000, 145.50, 'Indonesia'),
('KPL-002', 'Pacific Crown', 'Tanker', 25000, 180.20, 'Panama'),
('KPL-003', 'Nusantara Indah', 'Penumpang', 8000, 95.00, 'Indonesia');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kontainer_kargo`
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

--
-- Dumping data untuk tabel `kontainer_kargo`
--

INSERT INTO `kontainer_kargo` (`No_Kontainer`, `ID_Jadwal`, `Ukuran_Kontainer`, `Jenis_Kargo`, `Berat_Kargo`, `Status_Pabean`, `Koordinat_Yard`) VALUES
('MSCU1234567', 1, '40 feet', 'Dry', 24.50, 'Clear', 'YARD-A-01-02'),
('NYKU7654321', 1, '20 feet', 'Reefer', 18.20, 'Clear', 'YARD-B-04-01'),
('OOLU1122334', 2, '40 feet', 'Hazardous', 28.00, 'Hold', 'YARD-DG-01');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `ID_Pelanggan` varchar(10) NOT NULL,
  `Nama_Perusahaan` varchar(100) NOT NULL,
  `Kontak` varchar(20) NOT NULL,
  `Alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`ID_Pelanggan`, `Nama_Perusahaan`, `Kontak`, `Alamat`) VALUES
('PLG-01', 'PT Logistics Maju Bersama', '021-5551234', 'Jl. Pelabuhan No. 10, Jakarta'),
('PLG-02', 'Global Shipping Corp', '+1-415-555098', 'Wall Street No. 4, New York');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dermaga`
--
ALTER TABLE `dermaga`
  ADD PRIMARY KEY (`ID_Dermaga`),
  ADD UNIQUE KEY `UQ_Nama_Dermaga` (`Nama_Dermaga`);

--
-- Indeks untuk tabel `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`ID_Invoice`),
  ADD UNIQUE KEY `UQ_Jadwal_Invoice` (`ID_Jadwal`),
  ADD KEY `ID_Pelanggan` (`ID_Pelanggan`);

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
-- Indeks untuk tabel `kontainer_kargo`
--
ALTER TABLE `kontainer_kargo`
  ADD PRIMARY KEY (`No_Kontainer`),
  ADD KEY `ID_Jadwal` (`ID_Jadwal`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`ID_Pelanggan`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `jadwal_tambatan`
--
ALTER TABLE `jadwal_tambatan`
  MODIFY `ID_Jadwal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`ID_Jadwal`) REFERENCES `jadwal_tambatan` (`ID_Jadwal`) ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`ID_Pelanggan`) REFERENCES `pelanggan` (`ID_Pelanggan`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `jadwal_tambatan`
--
ALTER TABLE `jadwal_tambatan`
  ADD CONSTRAINT `jadwal_tambatan_ibfk_1` FOREIGN KEY (`ID_Kapal`) REFERENCES `kapal` (`ID_Kapal`) ON UPDATE CASCADE,
  ADD CONSTRAINT `jadwal_tambatan_ibfk_2` FOREIGN KEY (`ID_Dermaga`) REFERENCES `dermaga` (`ID_Dermaga`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `kontainer_kargo`
--
ALTER TABLE `kontainer_kargo`
  ADD CONSTRAINT `kontainer_kargo_ibfk_1` FOREIGN KEY (`ID_Jadwal`) REFERENCES `jadwal_tambatan` (`ID_Jadwal`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
