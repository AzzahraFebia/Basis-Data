-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 22 Feb 2025 pada 12.25
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
-- Database: `akademik`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

CREATE TABLE `dosen` (
  `NIDN` char(10) NOT NULL,
  `Nama` varchar(50) NOT NULL,
  `Alamat` varchar(100) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Gelar_Akademik` varchar(15) NOT NULL,
  `No_Telepon` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `Nama` varchar(50) NOT NULL,
  `NPM` varchar(10) NOT NULL,
  `Tempat_Lahir` varchar(20) NOT NULL,
  `Tanggal_Lahir` date NOT NULL,
  `Email` varchar(50) NOT NULL,
  `No_Hp` varchar(15) NOT NULL,
  `Alamat` varchar(100) NOT NULL,
  `Jenis_Kelamin` enum('L','P') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `Kode_MK` varchar(10) NOT NULL,
  `Nama_Mata_Kuliah` varchar(20) NOT NULL,
  `SKS` int(11) DEFAULT NULL,
  `Hari` varchar(15) NOT NULL,
  `Nama_Dosen` varchar(50) NOT NULL,
  `SEMESTER` int(11) DEFAULT NULL,
  `Waktu_Mulai` time NOT NULL,
  `Waktu_Selesai` time NOT NULL,
  `Deskripsi_Mata_Kuliah` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`NIDN`);

--
-- Indeks untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`NPM`);

--
-- Indeks untuk tabel `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`Kode_MK`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
