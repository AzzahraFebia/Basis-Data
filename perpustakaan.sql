-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 30 Mar 2025 pada 06.06
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
-- Database: `perpustakaan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggota`
--

CREATE TABLE `anggota` (
  `id_anggota` varchar(10) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `jurusan` varchar(20) DEFAULT 'Umum',
  `tgl_daftar` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `anggota`
--

INSERT INTO `anggota` (`id_anggota`, `nama`, `jurusan`, `tgl_daftar`) VALUES
('GO1', 'Arnelia Bunga', 'Psikologi', '2022-06-16'),
('GO2', 'Danuarta Sandy Andito', 'Teknik Sipil', '2020-05-20'),
('GO3', 'Namora Dian Puspita', 'Pariwisata', '2024-06-13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggota2nf`
--

CREATE TABLE `anggota2nf` (
  `id_anggota` int(11) NOT NULL,
  `nama_anggota` varchar(100) NOT NULL,
  `jurusan_anggota` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggota3nf`
--

CREATE TABLE `anggota3nf` (
  `id_anggota` int(11) NOT NULL,
  `nama_anggota` varchar(100) NOT NULL,
  `jurusan_anggota` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id_buku` varchar(10) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `penerbit` varchar(50) DEFAULT NULL,
  `tahun_terbit` int(11) DEFAULT NULL CHECK (`tahun_terbit` between 1900 and 2025),
  `id_penerbit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id_buku`, `judul`, `penerbit`, `tahun_terbit`, `id_penerbit`) VALUES
('BK1', 'Di Balik Sosok Gelap', 'Gramedia', 2019, 1),
('BK2', 'Angkasa dan 56 Hari', 'Akad', 2021, 2),
('BK3', 'Mariposa', 'Coconut Book', 2018, 3),
('BK4', 'Besali', 'Laksana', 2019, 4),
('BK5', 'Malaikat Berhati Gelap', 'Gramedia', 2018, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku2nf`
--

CREATE TABLE `buku2nf` (
  `id_buku` int(11) NOT NULL,
  `judul_buku` varchar(150) NOT NULL,
  `penerbit_buku` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku3nf`
--

CREATE TABLE `buku3nf` (
  `id_buku` int(11) NOT NULL,
  `judul_buku` varchar(100) NOT NULL,
  `id_penerbit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_anggota` varchar(10) DEFAULT NULL,
  `id_buku` varchar(10) DEFAULT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date DEFAULT NULL,
  `denda` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_anggota`, `id_buku`, `tgl_pinjam`, `tgl_kembali`, `denda`) VALUES
(1, 'GO1', 'BK4', '2021-03-02', '2021-03-09', 0),
(2, 'GO2', 'BK1', '2024-01-18', '2024-01-25', 0),
(3, 'GO3', 'BK2', '2023-04-12', '2023-04-21', 5000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `penerbit`
--

CREATE TABLE `penerbit` (
  `id_penerbit` int(11) NOT NULL,
  `nama_penerbit` varchar(100) NOT NULL,
  `alamat` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penerbit`
--

INSERT INTO `penerbit` (`id_penerbit`, `nama_penerbit`, `alamat`) VALUES
(1, 'Gramedia', 'Jakarta'),
(2, 'Akad', 'Bandung'),
(3, 'Coconut Book', 'Surabaya'),
(4, 'Laksana', 'Yogyakarta');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penerbit3nf`
--

CREATE TABLE `penerbit3nf` (
  `id_penerbit` int(11) NOT NULL,
  `nama_penerbit` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksipeminjaman`
--

CREATE TABLE `transaksipeminjaman` (
  `id_transaksi` int(11) DEFAULT NULL,
  `nama_anggota` varchar(100) DEFAULT NULL,
  `jurusan_anggota` varchar(20) DEFAULT NULL,
  `judul_buku` varchar(150) DEFAULT NULL,
  `penerbit_buku` varchar(100) DEFAULT NULL,
  `tgl_pinjam` date DEFAULT NULL,
  `tgl_kembali` date DEFAULT NULL,
  `denda` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksipeminjaman_1nf`
--

CREATE TABLE `transaksipeminjaman_1nf` (
  `id_transaksi` int(11) NOT NULL,
  `nama_anggota` varchar(100) NOT NULL,
  `jurusan_anggota` varchar(20) NOT NULL,
  `judul_buku` varchar(150) NOT NULL,
  `penerbit_buku` varchar(100) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `denda` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksipeminjaman_2nf`
--

CREATE TABLE `transaksipeminjaman_2nf` (
  `id_transaksi` int(11) NOT NULL,
  `id_anggota` int(11) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `denda` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksipeminjaman_3nf`
--

CREATE TABLE `transaksipeminjaman_3nf` (
  `id_transaksi` int(11) NOT NULL,
  `id_anggota` int(11) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `denda` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `anggota`
--
ALTER TABLE `anggota`
  ADD PRIMARY KEY (`id_anggota`);

--
-- Indeks untuk tabel `anggota2nf`
--
ALTER TABLE `anggota2nf`
  ADD PRIMARY KEY (`id_anggota`);

--
-- Indeks untuk tabel `anggota3nf`
--
ALTER TABLE `anggota3nf`
  ADD PRIMARY KEY (`id_anggota`);

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`),
  ADD KEY `fk_penerbit` (`id_penerbit`);

--
-- Indeks untuk tabel `buku2nf`
--
ALTER TABLE `buku2nf`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indeks untuk tabel `buku3nf`
--
ALTER TABLE `buku3nf`
  ADD PRIMARY KEY (`id_buku`),
  ADD KEY `id_penerbit` (`id_penerbit`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_buku` (`id_buku`);

--
-- Indeks untuk tabel `penerbit`
--
ALTER TABLE `penerbit`
  ADD PRIMARY KEY (`id_penerbit`);

--
-- Indeks untuk tabel `penerbit3nf`
--
ALTER TABLE `penerbit3nf`
  ADD PRIMARY KEY (`id_penerbit`);

--
-- Indeks untuk tabel `transaksipeminjaman_1nf`
--
ALTER TABLE `transaksipeminjaman_1nf`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indeks untuk tabel `transaksipeminjaman_2nf`
--
ALTER TABLE `transaksipeminjaman_2nf`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_buku` (`id_buku`);

--
-- Indeks untuk tabel `transaksipeminjaman_3nf`
--
ALTER TABLE `transaksipeminjaman_3nf`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_buku` (`id_buku`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `penerbit`
--
ALTER TABLE `penerbit`
  MODIFY `id_penerbit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD CONSTRAINT `fk_penerbit` FOREIGN KEY (`id_penerbit`) REFERENCES `penerbit` (`id_penerbit`);

--
-- Ketidakleluasaan untuk tabel `buku3nf`
--
ALTER TABLE `buku3nf`
  ADD CONSTRAINT `buku3nf_ibfk_1` FOREIGN KEY (`id_penerbit`) REFERENCES `penerbit3nf` (`id_penerbit`);

--
-- Ketidakleluasaan untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`),
  ADD CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`);

--
-- Ketidakleluasaan untuk tabel `transaksipeminjaman_2nf`
--
ALTER TABLE `transaksipeminjaman_2nf`
  ADD CONSTRAINT `transaksipeminjaman_2nf_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `anggota2nf` (`id_anggota`),
  ADD CONSTRAINT `transaksipeminjaman_2nf_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku2nf` (`id_buku`);

--
-- Ketidakleluasaan untuk tabel `transaksipeminjaman_3nf`
--
ALTER TABLE `transaksipeminjaman_3nf`
  ADD CONSTRAINT `transaksipeminjaman_3nf_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `anggota3nf` (`id_anggota`),
  ADD CONSTRAINT `transaksipeminjaman_3nf_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku3nf` (`id_buku`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
