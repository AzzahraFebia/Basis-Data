-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 12 Mar 2025 pada 14.57
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
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `NPM` int(11) NOT NULL,
  `Nama` varchar(200) DEFAULT NULL,
  `Jurusan` varchar(100) DEFAULT NULL,
  `Tanggal_Lahir` date DEFAULT NULL,
  `Jenis_Kelamin` enum('L','P') DEFAULT NULL,
  `Email` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`NPM`, `Nama`, `Jurusan`, `Tanggal_Lahir`, `Jenis_Kelamin`, `Email`) VALUES
(3, 'Joan Danuarta', 'Teknik Mesim', '2005-10-01', 'L', 'joanddanu@gmail.com'),
(4, 'Aditya Yanuar', 'Teknik Elektro', '2003-06-10', 'L', 'adityanz@gmail.com'),
(5, 'Rania Amelia', 'Sastra Indonesia', '2006-04-04', 'P', 'raniiamelia2@gmail.com'),
(13, 'Naren Mahardika', 'Matematika', '2005-02-09', 'L', 'mahardika446@gmail.com'),
(15, 'Hanata Arunika', 'Akuntansi', '2006-03-18', 'P', 'nataaaruni@gmaul.com'),
(19, 'Jeana Nareya', 'Ilmu Komunikasi', '2006-03-15', 'P', 'jjjeanarey@gmail.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `matkul`
--

CREATE TABLE `matkul` (
  `ID_Matkul` int(11) NOT NULL,
  `Nama_Matkul` varchar(100) DEFAULT NULL,
  `Kode_Matkul` varchar(20) DEFAULT NULL,
  `Jumlah_SKS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `matkul`
--

INSERT INTO `matkul` (`ID_Matkul`, `Nama_Matkul`, `Kode_Matkul`, `Jumlah_SKS`) VALUES
(1, 'Mekanika Teknik', 'MKI12', 2),
(2, 'Termodinamika', 'TRM14', 3),
(3, 'Elektronika Dasar', 'ED22', 2),
(4, 'Sejarah Sastra', 'STR19', 2),
(5, 'Bahasa Indonesia', 'BIN16', 2),
(6, 'Aljabar Liniear', 'AJL06', 3),
(7, 'Kalkulus', 'KL401', 3),
(8, 'Akuntansi Dasar', 'AKD08', 2),
(9, 'Jurnalistik', 'JLS20', 2),
(10, 'Pengauditan', 'PND011', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `nilai`
--

CREATE TABLE `nilai` (
  `NPM` int(11) NOT NULL,
  `ID_Matkul` int(11) NOT NULL,
  `Nilai` decimal(4,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `nilai`
--

INSERT INTO `nilai` (`NPM`, `ID_Matkul`, `Nilai`) VALUES
(3, 1, 80.00),
(3, 2, 85.00),
(4, 2, 82.00),
(4, 3, 79.00),
(5, 4, 90.00),
(5, 5, 92.00),
(13, 5, 94.00),
(13, 6, 86.00),
(13, 7, 85.00),
(15, 5, 88.00),
(15, 8, 80.00),
(15, 10, 84.00),
(19, 5, 87.00),
(19, 9, 77.00);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`NPM`);

--
-- Indeks untuk tabel `matkul`
--
ALTER TABLE `matkul`
  ADD PRIMARY KEY (`ID_Matkul`);

--
-- Indeks untuk tabel `nilai`
--
ALTER TABLE `nilai`
  ADD PRIMARY KEY (`NPM`,`ID_Matkul`),
  ADD KEY `ID_Matkul` (`ID_Matkul`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `nilai`
--
ALTER TABLE `nilai`
  ADD CONSTRAINT `nilai_ibfk_1` FOREIGN KEY (`NPM`) REFERENCES `mahasiswa` (`NPM`),
  ADD CONSTRAINT `nilai_ibfk_2` FOREIGN KEY (`ID_Matkul`) REFERENCES `matkul` (`ID_Matkul`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
