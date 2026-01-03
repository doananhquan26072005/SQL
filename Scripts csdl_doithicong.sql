create database csdl_doithicong;

use csdl_doithicong;

create table HANG(
	HangCN			int					not null,
	HeSoLuong		decimal(3,1)		not null,
	CONSTRAINT PK_HANG
	    PRIMARY KEY (HangCN)
);

create table CONGNHAN(
	MaCN			int					not null,
	Ho				varchar(30)			not null,
	Ten				varchar(15)			not null,
	NgaySinh		date,
	GioiTinh		char				CHECK (gioitinh in ('F', 'f', 'M', 'm')),
	HangCN			int					not null,
	NgayTuyenDung	date,
	MaDoi			int					not null,
	CONSTRAINT PK_CONGNHAN
	    PRIMARY KEY (MaCN)
);

create table DOITHICONG(
	MaDoi			int					not null,
	DoiTruong		int,
	ThuocDonVi		int					not null,
	CONSTRAINT PK_DOITHICONG
	    PRIMARY KEY (MaDoi)
);

create table CONGTRINH(
	MaCT			int					not null,
	TenCT			varchar(50)			not null,
	DiaDiem			varchar(50),
	DonViChinh		int					not null,
	CONSTRAINT PK_CONGTRINH
	    PRIMARY KEY (MaCT)
);

create table CHAMCONG(
	MaCT			int					not null,
	MaDoi			int					not null,
	MaCN			int					not null,
	NgayLamViec		date				not null,
	SoGio			float				not null,
	CONSTRAINT PK_CHAMCONG
	    PRIMARY KEY (MaCT , MaDoi , MaCN , NgayLamViec)
);

ALTER TABLE CONGNHAN 
    ADD CONSTRAINT FK_CONGNHAN_HANG 
        FOREIGN KEY (HangCN) REFERENCES HANG (HangCN);

ALTER TABLE CONGNHAN 
    ADD CONSTRAINT FK_CONGNHAN_DOITHICONG
        FOREIGN KEY (MaDoi) REFERENCES DOITHICONG (MaDoi);

ALTER TABLE DOITHICONG
    ADD CONSTRAINT FK_DOITHICONG_CONGNHAN 
        FOREIGN KEY (DoiTruong) REFERENCES CONGNHAN (MaCN);

ALTER TABLE CHAMCONG
    ADD CONSTRAINT FK_CHAMCONG_CONGTRINH
        FOREIGN KEY (MaCT) REFERENCES CONGTRINH (MaCT);

ALTER TABLE CHAMCONG
    ADD CONSTRAINT FK_CHAMCONG_DOITHICONG
        FOREIGN KEY (MaDoi) REFERENCES DOITHICONG (MaDoi);

ALTER TABLE CHAMCONG
    ADD CONSTRAINT FK_CHAMCONG_CONGNHAN
        FOREIGN KEY (MaCN) REFERENCES CONGNHAN (MaCN);

INSERT INTO DOITHICONG 
VALUES (1,null,10),
	   (2,null,20);

INSERT INTO HANG
VALUES (1,3.0),
	   (2,3.5),
	   (3,4.0),
	   (4,4.5),
	   (5,5.0);

INSERT INTO CONGNHAN
VALUES (118 , 'Tran Van' , 'Hung' , '2000-08-15' , 'M' , 1 , '2023-11-01' , 1),
	   (138 , 'Nguyen' , 'Khanh' , '1995-04-23' , 'M' , 3 , '2021-03-01' , 2);

INSERT INTO CONGTRINH
VALUES (11 , 'Nha o Tran Thai Binh' , 'Quan 3' , 10),
	   (12 , 'Van phong HBC' , 'Quan 7' , 20);

INSERT INTO CHAMCONG
VALUES (11 , 1 , 118 , '2024-03-11' , 8.0),
	   (12 , 2 , 138 , '2024-04-05' , 8.0);