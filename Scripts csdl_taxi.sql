create database csdl_taxi;

use csdl_taxi;

create table LAIXE(
	MaLX			int					not null,
	Ho				varchar(15)			not null,
	Dem				varchar(15),
	Ten				varchar(15)			not null,
	NgaySinh		date,
	SoGP			char(12)			not null,
	HanGP			date				not null,
	CONSTRAINT PK_LAIXE
	    PRIMARY KEY (MaLX)
);

create table CALAMVIEC(
	MaCLV			int					not null,
	MaLX			int					not null,
	SoPT			int					not null,
	BatDau			datetime,
	KetThuc			datetime,
	CONSTRAINT PK_CALAMVIEC
	    PRIMARY KEY (MaCLV)
);

create table PHUONGTIEN(
	LoaiPT			int					not null,
	SoPT			int					not null,
	BienSo			char(10) 			not null,
	NamSanXuat		int					not null,
	ChuPT			int,
	TinhTrang		int					not null
										default 1,
	CONSTRAINT PK_PHUONGTIEN
	    PRIMARY KEY (SoPT)
);

create table LOAI_PHUONGTIEN(
	LoaiPT			int					not null,
	TenLoai			varchar(64)			not null,
	CONSTRAINT PK_LOAI_PHUONGTIEN
	    PRIMARY KEY (LoaiPT)
);

ALTER TABLE CALAMVIEC 
    ADD CONSTRAINT FK_CALAMVIEC_LAIXE 
        FOREIGN KEY (MaLX) REFERENCES LAIXE (MaLX);

ALTER TABLE CALAMVIEC 
    ADD CONSTRAINT FK_CALAMVIEC_PHUONGTIEN 
        FOREIGN KEY (SoPT) REFERENCES PHUONGTIEN (SoPT);

ALTER TABLE PHUONGTIEN
    ADD CONSTRAINT FK_PHUONGTIEN_LAIXE 
        FOREIGN KEY (ChuPT) REFERENCES LAIXE (MaLX);

ALTER TABLE PHUONGTIEN
    ADD CONSTRAINT FK_PHUONGTIEN_LOAI_PHUONGTIEN 
        FOREIGN KEY (LoaiPT) REFERENCES LOAI_PHUONGTIEN (LoaiPT);