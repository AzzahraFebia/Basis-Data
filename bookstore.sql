-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 19 Jun 2025 pada 16.04
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
-- Database: `bookstore`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_transaksi` (IN `p_id_pelanggan` INT, IN `p_id_buku` INT, IN `p_jumlah` INT)   BEGIN
    DECLARE v_harga_buku DECIMAL(10,2);
    DECLARE v_total_harga DECIMAL(10,2);
    DECLARE v_stok INT;

    -- Mengambil harga dan stok buku
    SELECT harga, stok INTO v_harga_buku, v_stok
    FROM buku
    WHERE id_buku = p_id_buku;

    -- Validasi apakah stok cukup
    IF v_stok < p_jumlah THEN
        -- Menampilkan pesan error
        SELECT CONCAT('Maaf, stok tidak mencukupi. Stok: ', v_stok);
    ELSE
        -- Menghitung total harga
        SET v_total_harga = v_harga_buku * p_jumlah;

        -- Mengurangi stok buku
        UPDATE buku
        SET stok = stok - p_jumlah
        WHERE id_buku = p_id_buku;

        -- Menambahkan data ke tabel transaksi
        INSERT INTO transaksi(id_pelanggan, id_buku, jumlah, total_harga, tanggal_transaksi)
        VALUES (p_id_pelanggan, p_id_buku, p_jumlah, v_total_harga, CURDATE());

        -- Menambahkan total_harga ke total_belanja pelanggan
        UPDATE pelanggan
        SET total_belanja = total_belanja + v_total_harga
        WHERE id_pelanggan = p_id_pelanggan;

        -- Menampilkan pesan
        SELECT 'Transaksi berhasil' AS pesan;
    END IF;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `hitung_diskon` (`total_belanja` DECIMAL(10,2)) RETURNS DECIMAL(5,2) DETERMINISTIC BEGIN
	DECLARE diskon DECIMAL(5,2);
    IF total_belanja < 1000000 THEN
    	SET diskon = 0.00;
    ELSEIF total_belanja < 5000000 THEN
    	SET diskon = 0.05;
    ELSE
    	SET diskon = 0.10;
    END IF;
    
    RETURN diskon;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `judul` varchar(100) DEFAULT NULL,
  `penulis` varchar(100) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id_buku`, `judul`, `penulis`, `harga`, `stok`) VALUES
(1, 'Malaikat Berhati Gelap', 'Lexie Xu', 61000.00, 3),
(2, 'Besali', 'Shabrina Ws', 68000.00, 0),
(3, 'Di Balik Sosok Gelap', 'Lexie Xu', 100000.00, 7),
(4, 'Mariposa', 'Luluk H.F', 150000.00, 11),
(5, 'Angkasa Dan 56 Hari', 'Ravinkyu', 99000.00, 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `total_belanja` decimal(10,2) DEFAULT 0.00,
  `status_member` enum('reguler','gold','platinum') DEFAULT 'reguler'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama`, `total_belanja`, `status_member`) VALUES
(1, 'Kayi Naradeems', 695000.00, 'platinum'),
(2, 'Joana Deyananda', 199000.00, 'gold'),
(3, 'Arsenio Gestara', 200000.00, 'gold'),
(4, 'Jeevan Arnelio', 3000000.00, 'gold'),
(5, 'Kajesa Annaralia', 7000000.00, 'platinum');

--
-- Trigger `pelanggan`
--
DELIMITER $$
CREATE TRIGGER `UpdateStatusMemberOtomatis` BEFORE UPDATE ON `pelanggan` FOR EACH ROW BEGIN
    IF NEW.total_belanja >= 5000000 THEN
        SET NEW.status_member = 'PLATINUM';
    ELSEIF NEW.total_belanja >= 1000000 THEN
        SET NEW.status_member = 'GOLD';
    ELSE
        SET NEW.status_member = 'REGULER';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `total_harga` decimal(10,2) DEFAULT NULL,
  `tanggal_transaksi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_pelanggan`, `id_buku`, `jumlah`, `total_harga`, `tanggal_transaksi`) VALUES
(1, 1, 3, 2, 200000.00, '2025-05-17'),
(2, 2, 3, 1, 100000.00, '2025-03-18'),
(3, 3, 3, 2, 200000.00, '2025-04-07'),
(4, 4, 3, 1, 100000.00, '2025-05-04'),
(5, 5, 4, 2, 300000.00, '2025-01-10'),
(6, 1, 2, 1, 68000.00, '2025-05-17'),
(7, 2, 5, 1, 99000.00, '2025-03-18'),
(8, 5, 1, 1, 61000.00, '2025-01-10'),
(9, 1, 1, 7, 427000.00, '2025-06-19');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `id_buku` (`id_buku`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
