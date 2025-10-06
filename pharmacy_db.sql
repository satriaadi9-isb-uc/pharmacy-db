DROP DATABASE IF EXISTS `pharmacy_db`;

CREATE DATABASE `pharmacy_db`;
USE `pharmacy_db`;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier` (
  `id_supplier` varchar(3) NOT NULL COMMENT 'S+2 digit urut',
  `nama_perusahaan` varchar(20) NOT NULL,
  `alamat` varchar(150) DEFAULT NULL,
  `kota` varchar(30) DEFAULT NULL,
  `status_del` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id_supplier`)
);

INSERT INTO `supplier` VALUES ('S01','KONIMEX','JL KAPUAS 3','SURABAYA','F'),('S02','KIMIA FARMA','JL NGAGEL 3','SURABAYA','F'),('S03','GAJAH','JL A YANI 45','SURABAYA','F'),('S04','FORCE','JL SURYA 5','SURABAYA','F');

--
-- Table structure for table `jenis_obat`
--

DROP TABLE IF EXISTS `jenis_obat`;

CREATE TABLE `jenis_obat` (
  `id_jenis` varchar(3) NOT NULL COMMENT '''J''+2 digit urut',
  `nama_jenis` varchar(20) NOT NULL,
  `status_del` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id_jenis`)
);

INSERT INTO `jenis_obat` VALUES ('J01','obat luar','F'),('J02','obat gosok','F'),('J03','kapsul','F'),('J04','tablet','F');

--
-- Table structure for table `obat`
--

DROP TABLE IF EXISTS `obat`;

CREATE TABLE `obat` (
  `id_obat` varchar(5) NOT NULL COMMENT '''B''+4 digit urut',
  `nama_obat` varchar(20) NOT NULL,
  `harga_beli` int unsigned DEFAULT NULL,
  `harga_jual` int unsigned NOT NULL DEFAULT '0',
  `stock_obat` int unsigned NOT NULL DEFAULT '0',
  `id_jenis` varchar(3) NOT NULL,
  `status_del` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id_obat`),
  KEY `fk0_obat_jenis` (`id_jenis`),
  CONSTRAINT `fk0_obat_jenis` FOREIGN KEY (`id_jenis`) REFERENCES `jenis_obat` (`id_jenis`)
);

INSERT INTO `obat` VALUES ('B0001','ANALSIK',5000,6000,10,'J04','F'),('B0002','OSKADON',4000,5000,20,'J04','F'),('B0003','SARIDON',3000,4000,30,'J04','F'),('B0004','REMASIL',2000,3000,40,'J03','F'),('B0005','REMASAL',1000,2000,50,'J03','F'),('B0006','OSKADRIL',2000,3000,60,'J04','F'),('B0007','DECOLSIN',3000,4000,70,'J04','F'),('B0008','DECOLGEN',4000,5000,80,'J04','F'),('B0009','RIVANOL',4000,5000,30,'J01','F'),('B0010','ALKOHOL',4000,5000,40,'J01','F'),('B0011','SALONPAS',4000,5000,30,'J01','F'),('B0012','HANDYPLAST',500,700,40,'J01','F'),('B0013','MKPUTIH',9000,10000,50,'J02','F');

--
-- Table structure for table `suply_obat`
--

DROP TABLE IF EXISTS `suply_obat`;

CREATE TABLE `suply_obat` (
  `id_supplier` varchar(3) NOT NULL,
  `id_obat` varchar(5) NOT NULL,
  `harga_beli` int NOT NULL,
  `status_del` varchar(1) NOT NULL DEFAULT 'F',
  KEY `fk0_supply_obat` (`id_supplier`),
  KEY `fk1_supply_obat` (`id_obat`),
  CONSTRAINT `fk0_supply_obat` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`id_supplier`),
  CONSTRAINT `fk1_supply_obat` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id_obat`)
);

INSERT INTO `suply_obat` VALUES ('S01','B0001',5000,'F'),('S02','B0001',5500,'F'),('S03','B0001',5750,'F'),('S01','B0002',4000,'F'),('S02','B0001',4400,'F'),('S01','B0003',3000,'F'),('S01','B0004',2000,'F'),('S01','B0005',1000,'F'),('S01','B0006',2000,'F'),('S01','B0007',3000,'F'),('S01','B0008',4000,'F');

--
-- Table structure for table `spesialis`
--

DROP TABLE IF EXISTS `spesialis`;

CREATE TABLE `spesialis` (
  `id_spes` varchar(4) NOT NULL COMMENT '''S''+3 digit urut',
  `nama_spesialis` varchar(15) NOT NULL,
  `status_del` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id_spes`)
);

INSERT INTO `spesialis` VALUES ('S000','Saraf','F'),('S001','THT','F'),('S002','Internis','F'),('S003','Anak','F');

--
-- Table structure for table `dokter`
--

DROP TABLE IF EXISTS `dokter`;

CREATE TABLE `dokter` (
  `id_dokter` varchar(3) NOT NULL COMMENT '''D''+2 digit urut',
  `nama_dokter` varchar(20) NOT NULL,
  `alamat` varchar(500) DEFAULT NULL,
  `telpon` varchar(13) DEFAULT NULL,
  `jenis_dokter` int unsigned NOT NULL DEFAULT '0' COMMENT '2=spesialis; 1=umum; 0=muda',
  `id_spes` varchar(4) DEFAULT NULL,
  `status_del` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id_dokter`),
  KEY `fk0_dokter_spes` (`id_spes`),
  CONSTRAINT `fk0_dokter_spes` FOREIGN KEY (`id_spes`) REFERENCES `spesialis` (`id_spes`)
);

INSERT INTO `dokter` VALUES ('D01','dr. Mulyanto, Sp.S.','Jl Raya I/5',NULL,2,'S000','F'),('D02','dr. Surya, Sp.S.','Jl Gubeng 5','031-3778899',2,'S000','F'),('D03','dr. Tirta, Sp.THT.','Jl Ngagel 2','031-5921234',2,'S001','F'),('D04','dr. Mandala, Sp.PD.','Jl Pucang 25',NULL,2,'S002','F'),('D05','dr. Sri, Sp.S.','Jl Raya 22',NULL,2,'S000','F'),('D06','dr. Ani','Jl Mulyosari II/2',NULL,1,NULL,'F'),('D07','dr. Budiman','Jl Kalisari III/3',NULL,0,NULL,'F'),('D08','dr. Sondar','Jl Manyar 55',NULL,1,NULL,'F'),('D09','dr. Halim','Jl Perak 8',NULL,0,NULL,'F'),('D10','dr. Sumantri, Sp.PD.','Jl Kapasan 11',NULL,2,'S002','F'),('D11','dr. Mahendra, Sp.A.','Jl Semut Indah I/3',NULL,2,'S003','F');

--
-- Table structure for table `h_jual`
--

DROP TABLE IF EXISTS `h_jual`;

CREATE TABLE `h_jual` (
  `id_jual` varchar(15) NOT NULL COMMENT 'TJ+DDMMYYYY+5 digit urut',
  `tgl_trans` date NOT NULL,
  `nama_pembeli` varchar(20) DEFAULT '-',
  `alamat_pembeli` varchar(100) DEFAULT '-',
  `id_dokter` varchar(3) DEFAULT NULL,
  `status_del` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id_jual`) USING BTREE,
  KEY `fk0_hjual_dokter` (`id_dokter`) USING BTREE,
  CONSTRAINT `fk0_hjual_dokter` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`)
);

INSERT INTO `h_jual` VALUES ('TJ1507202100001','2021-07-15','Mickey','Jl Ngagel Timur 3','D01','F'),('TJ1707202100001','2021-07-17','Minnie','Jl Pucang Anom 5','D01','F'),('TJ1707202100002','2021-07-17','Guffy','Jl Raya 234','D02','F'),('TJ1907202100001','2021-07-19','Pluto','Jl Ngagel Selatan 123','D02','F'),('TJ1907202100002','2021-07-19','Mars','Jl Gubeng 2','D03','F'),('TJ2507202100001','2021-07-25','Kitty','Jl Kertajaya 45','D04','F'),('TJ2507202100002','2021-07-25','Hello','Jl MainMain','D05','F'),('TJ2507202100003','2021-07-25','Hello','Jl MainMain','D09','F'),('TJ2507202100004','2021-07-25','Kitty','Jl Kertajaya 45','D09','F'),('TJ2507202100005','2021-07-25','-','-',NULL,'F');

--
-- Table structure for table `d_jual`
--

DROP TABLE IF EXISTS `d_jual`;

CREATE TABLE `d_jual` (
  `id_jual` varchar(15) NOT NULL,
  `id_obat` varchar(5) NOT NULL,
  `jumlah` int unsigned NOT NULL,
  `harga` int unsigned NOT NULL,
  `status_del` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id_jual`,`id_obat`) USING BTREE,
  KEY `fk1_djual_obat` (`id_obat`) USING BTREE,
  KEY `fk0_djual_id` (`id_jual`) USING BTREE,
  CONSTRAINT `fk0_djual_id` FOREIGN KEY (`id_jual`) REFERENCES `h_jual` (`id_jual`),
  CONSTRAINT `fk1_djual_obat` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id_obat`)
);


INSERT INTO `d_jual` VALUES ('TJ1507202100001','B0001',5,6000,'F'),('TJ1507202100001','B0002',5,5000,'F'),('TJ1707202100001','B0001',10,6000,'F'),('TJ1707202100001','B0003',5,4000,'F'),('TJ1707202100002','B0001',8,6000,'F'),('TJ1707202100002','B0002',5,5000,'F'),('TJ1707202100002','B0003',4,4000,'F'),('TJ1907202100001','B0001',5,6000,'F'),('TJ1907202100001','B0003',7,4000,'F'),('TJ1907202100001','B0006',20,3000,'F'),('TJ1907202100002','B0001',5,6000,'F'),('TJ1907202100002','B0005',2,2000,'F'),('TJ1907202100002','B0006',3,3000,'F'),('TJ1907202100002','B0007',4,4000,'F'),('TJ2507202100001','B0001',5,6000,'F'),('TJ2507202100001','B0003',8,4000,'F'),('TJ2507202100001','B0006',5,3000,'F'),('TJ2507202100001','B0007',7,4000,'F'),('TJ2507202100002','B0001',5,6000,'F'),('TJ2507202100003','B0006',5,3000,'F'),('TJ2507202100003','B0007',5,4000,'F'),('TJ2507202100004','B0001',6,6000,'F'),('TJ2507202100004','B0003',6,4000,'F'),('TJ2507202100004','B0007',6,4000,'F'),('TJ2507202100005','B0001',5,6000,'F'),('TJ2507202100005','B0003',8,4000,'F'),('TJ2507202100005','B0007',7,4000,'F');

--
-- Table structure for table `h_beli`
--

DROP TABLE IF EXISTS `h_beli`;

CREATE TABLE `h_beli` (
  `id_beli` varchar(15) NOT NULL COMMENT 'TB+DDMMYYYY+5 digit urut',
  `tgl_beli` date NOT NULL,
  `id_supplier` varchar(5) NOT NULL,
  `status_bayar` int unsigned NOT NULL COMMENT '1=hutang; 2=cek (bayar giro); 3=tunai',
  `status_del` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id_beli`),
  KEY `fk0_hbeli_supplier` (`id_supplier`),
  CONSTRAINT `fk0_hbeli_supplier` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`id_supplier`)
);

INSERT INTO `h_beli` VALUES ('TB0507202100001','2021-07-05','S03',1,'F'),('TB0507202100002','2021-07-05','S03',2,'F'),('TB1507202100001','2021-07-15','S02',3,'F'),('TB1507202100002','2021-07-15','S01',2,'F'),('TB2506202100001','2021-06-25','S01',3,'F'),('TB2906202100001','2021-06-29','S02',1,'F'),('TB2906202100002','2021-06-29','S01',2,'F');

--
-- Table structure for table `d_beli`
--

DROP TABLE IF EXISTS `d_beli`;

CREATE TABLE `d_beli` (
  `id_beli` varchar(15) NOT NULL,
  `id_obat` varchar(5) NOT NULL,
  `jumlah` int unsigned NOT NULL,
  `harga_beli` int unsigned NOT NULL,
  `status_del` varchar(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`id_beli`,`id_obat`),
  KEY `fk1_dbeli_obat` (`id_obat`),
  KEY `fk0_dbeli_id` (`id_beli`),
  CONSTRAINT `fk0_dbeli_id` FOREIGN KEY (`id_beli`) REFERENCES `h_beli` (`id_beli`),
  CONSTRAINT `fk1_dbeli_obat` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id_obat`)
);

INSERT INTO `d_beli` VALUES ('TB0507202100001','B0001',5,6000,'F'),('TB0507202100001','B0003',7,4000,'F'),('TB0507202100001','B0006',20,3000,'F'),('TB0507202100002','B0001',5,6000,'F'),('TB0507202100002','B0005',2,2000,'F'),('TB0507202100002','B0006',3,3000,'F'),('TB0507202100002','B0007',4,4000,'F'),('TB1507202100001','B0001',5,6000,'F'),('TB1507202100001','B0003',8,4000,'F'),('TB1507202100001','B0006',5,3000,'F'),('TB1507202100001','B0007',7,4000,'F'),('TB1507202100002','B0001',5,6000,'F'),('TB2506202100001','B0001',5,6000,'F'),('TB2506202100001','B0002',5,5000,'F'),('TB2906202100001','B0001',10,6000,'F'),('TB2906202100001','B0003',5,4000,'F'),('TB2906202100002','B0001',8,6000,'F'),('TB2906202100002','B0002',5,5000,'F'),('TB2906202100002','B0003',4,4000,'F');

