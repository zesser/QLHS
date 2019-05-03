﻿
Create database QL_DSTRUONGHOC
create table HEDAOTAO
(
	MAHE CHAR(5)NOT NULL PRIMARY KEY,
	TENHE NVARCHAR(50),

)
CREATE TABLE KHOI
(
	MAKHOI CHAR(5)NOT NULL PRIMARY KEY,
	TENKHOI NVARCHAR(20),
	MAHE CHAR(5),
)
CREATE TABLE LOP
(
	MALOP CHAR(5)NOT NULL PRIMARY KEY,
	TENLOP NVARCHAR(10),
	SISO INT,
	MAKHOI CHAR(5),
	MAGVCHUNGHIEM CHAR(7),

)
CREATE TABLE KHOAHOC
(
	MAKHOAHOC CHAR(7)NOT NULL PRIMARY KEY,
	NAMBD INT,
	NAMKT INT,
	MAHE CHAR(5),

)
CREATE TABLE HOCSINH
(
	MAHOCSINH CHAR(7)NOT NULL PRIMARY KEY,
	TENHOCSINH NVARCHAR(50),
	MALOP CHAR(5),
	NGAYSINH DATE,
	DIACHI NVARCHAR(50),
	GIOITINH NVARCHAR(10),
	MAKHOAHOC CHAR(7),

)
CREATE TABLE GIAOVIEN
(
	MAGV CHAR(7)NOT NULL PRIMARY KEY,
	TENGIAOVIEN NVARCHAR(50),
	GIOITINH NVARCHAR(10),
	DIENTHOAI NVARCHAR(10),
	GMAIL NVARCHAR(50),
	MAHE CHAR(5),
	MAGVCHUNGHIEM CHAR(7),

)
CREATE TABLE PHANCONG
(
	MAGV CHAR(7)NOT NULL,
	MAMONHOC CHAR(7)NOT NULL,
	MALOP CHAR(5)NOT NULL,
	MAKHOAHOC CHAR(7)NOT NULL,
	MAHE CHAR(5)NOT NULL,
	CONSTRAINT PK_PHANCONG_MA PRIMARY KEY(MAGV,MAMONHOC,MALOP,MAKHOAHOC,MAHE),
)
CREATE TABLE MONHOC
(
	MAMONHOC CHAR(7)NOT NULL PRIMARY KEY,
	TENMONHOC NVARCHAR(10),
	MAHE CHAR(5),
)
CREATE TABLE KETQUA
(
	MAHS CHAR(7)NOT NULL,
	MAMONHOC CHAR(7)NOT NULL,
	DIEM FLOAT,
	MAHE CHAR(5)NOT NULL,
	MAKHOAHOC CHAR(7)NOT NULL,
	CONSTRAINT PK_KETQUA_KQ PRIMARY KEY(MAHS,MAMONHOC,MAHE,MAKHOAHOC),
)




ALTER TABLE KHOI
ADD CONSTRAINT FK_KHOI_HEDAOTAO FOREIGN KEY(MAHE) REFERENCES HEDAOTAO(MAHE)
ALTER TABLE LOP
ADD  CONSTRAINT FK_LOP_KHOI FOREIGN KEY(MAKHOI) REFERENCES KHOI(MAKHOI)
ALTER TABLE HOCSINH
ADD  CONSTRAINT FK_HOCSINH_LOP FOREIGN KEY(MALOP) REFERENCES LOP(MALOP)
ALTER TABLE HOCSINH
ADD  CONSTRAINT FK_HOCSINH_KHOAHOC FOREIGN KEY(MAKHOAHOC) REFERENCES KHOAHOC(MAKHOAHOC)
ALTER TABLE KHOAHOC
ADD  CONSTRAINT FK_KHOAHOC_HEDAOTAO FOREIGN KEY(MAHE) REFERENCES HEDAOTAO(MAHE)

ALTER TABLE LOP
ADD  CONSTRAINT FK_LOP_GIAOVIEN FOREIGN KEY(MAGVCHUNGHIEM) REFERENCES GIAOVIEN(MAGV)

ALTER TABLE GIAOVIEN
ADD  CONSTRAINT FK_GIAOVIEN_GIAOVIEN FOREIGN KEY(MAGVCHUNGHIEM) REFERENCES GIAOVIEN(MAGV)
ALTER TABLE GIAOVIEN
ADD  CONSTRAINT FK_GIAOVIEN_HEDAOTAO FOREIGN KEY(MAHE) REFERENCES HEDAOTAO(MAHE)




ALTER TABLE PHANCONG
ADD CONSTRAINT FK_PHANCONG_GIAOVIEN FOREIGN KEY(MAGV) REFERENCES GIAOVIEN(MAGV)
ALTER TABLE PHANCONG
ADD CONSTRAINT FK_PHANCONG_MONHOC FOREIGN KEY(MAMONHOC) REFERENCES MONHOC(MAMONHOC)
ALTER TABLE PHANCONG
ADD CONSTRAINT FK_PHANCONG_KHOAHOC FOREIGN KEY(MAKHOAHOC) REFERENCES KHOAHOC(MAKHOAHOC)
ALTER TABLE PHANCONG
ADD CONSTRAINT FK_PHANCONG_HEDAOTAO FOREIGN KEY(MAHE) REFERENCES HEDAOTAO(MAHE)

ALTER TABLE MONHOC
ADD CONSTRAINT FK_MONHHOC_HEDAOTAO FOREIGN KEY(MAHE) REFERENCES HEDAOTAO(MAHE)

ALTER TABLE KETQUA
ADD CONSTRAINT FK_KETQUA_HOCSINH FOREIGN KEY(MAHS) REFERENCES HOCSINH(MAHOCSINH)
ALTER TABLE KETQUA
ADD CONSTRAINT FK_KETQUA_HEDAOTAO FOREIGN KEY(MAHE) REFERENCES HEDAOTAO(MAHE)
ALTER TABLE KETQUA
ADD CONSTRAINT FK_KETQUA_MONHOC FOREIGN KEY(MAMONHOC) REFERENCES MONHOC(MAMONHOC)
ALTER TABLE KETQUA
ADD CONSTRAINT FK_KETQUA_KHOAHOC FOREIGN KEY(MAKHOAHOC) REFERENCES KHOAHOC(MAKHOAHOC)
CREATE TRIGGER DF_NIENKHOA1 ON KHOAHOC
FOR INSERT, UPDATE
AS
	DECLARE @MA INT
	IF((SELECT MAHE FROM INSERTED) = 'THCS' OR (((SELECT NAMKT FROM INSERTED)- (SELECT MAHE FROM INSERTED) != 4)) )
		BEGIN
			PRINT 'NHAP LOI'
			ROLLBACK TRAN
		END
	ELSE IF((SELECT MAHE FROM INSERTED) = 'THPT' OR (((SELECT NAMKT FROM INSERTED)- (SELECT MAHE FROM INSERTED) != 3)) )
		BEGIN
			PRINT 'NHAP LOI'
			ROLLBACK TRAN
		END
GO
INSERT INTO HEDAOTAO
VALUES 
('HDT01','THCS'),
('HDT02','THPT')
INSERT INTO KHOI
VALUES
('MK006',N'KHỐI 6','HDT01'),
('MK007',N'KHỐI 7','HDT01'),
('MK008',N'KHỐI 8','HDT01'),
('MK009',N'KHỐI 9','HDT01'),
('MK010',N'KHỐI 10','HDT02'),
('MK011',N'KHỐI 11','HDT02'),
('MK012',N'KHỐI 12','HDT02')
INSERT INTO GIAOVIEN
VALUES 
('GVCS001',N'NGUYỄN ANH KHOA',N'NAM','0123456789',N'KHOA@GMAIL.COM','HDT01','GVCS001'),
('GVCS002',N'NGUYỄN ANH TÚ',N'NAM','0123456782',N'TU@GMAIL.COM','HDT01','GVCS002'),
('GVCS003',N'NGUYỄN ANH TÀI',N'NAM','0123456783',N'TAI@GMAIL.COM','HDT01','GVCS003'),
('GVCS004',N'NGUYỄN THỊ LUYẾN',N'NỮ','0123456784',N'LUYEN@GMAIL.COM','HDT01','GVCS004'),
('GVCS005',N'TRẦN ANH KHOA',N'NAM','0123456789',N'KHOA1@GMAIL.COM','HDT01','GVCS005'),
('GVCS006',N'TRẦN ANH TÚ',N'NAM','0223456789',N'TU1@GMAIL.COM','HDT01','GVCS006'),
('GVCS007',N'TRẦN ANH TÀI',N'NAM','0323456789',N'TAI1GMAIL.COM','HDT01','GVCS007'),
('GVCS008',N'TRẦN ANH LUYẾN',N'NỮ','0423456789',N'LUYEN1@GMAIL.COM','HDT01','GVCS008'),
('GVCS009',N'HỒ ANH KHOA',N'NAM','0123456719',N'KHOA2@GMAIL.COM','HDT01','GVCS009'),
('GVCS010',N'HỒ ANH TÚ',N'NAM','0123456729',N'TU2@GMAIL.COM','HDT01','GVCS010'),
('GVCS011',N'HỒ ANH TÀI',N'NAM','0123456739',N'TAI2@GMAIL.COM','HDT01','GVCS011'),
('GVCS012',N'HỒ ANH LUYẾN',N'NỮ','0123456749',N'LUYEN2@GMAIL.COM','HDT01','GVCS012'),
('GVCS013',N'PHẠM ANH KHOA',N'NAM','0143456789',N'KHOA3@GMAIL.COM','HDT01','GVCS013'),
('GVCS014',N'PHẠM ANH TÚ',N'NAM','0125456789',N'TU3@GMAIL.COM','HDT01','GVCS014'),
('GVCS015',N'PHẠM ANH TÀI',N'NAM','0126456789',N'TAI3@GMAIL.COM','HDT01','GVCS015'),
('GVCS016',N'PHẠM ANH LUYẾN',N'NỮ','0127456789',N'LUYEN3@GMAIL.COM','HDT01','GVCS016'),

('GVPT001',N'NGUYỄN ANH KHOA',N'NAM','0123156789',N'KHOA4@GMAIL.COM','HDT02','GVPT001'),
('GVPT002',N'NGUYỄN ANH TÚ',N'NAM','0123256782',N'TU4@GMAIL.COM','HDT02','GVPT002'),
('GVPT003',N'NGUYỄN ANH TÀI',N'NAM','0123356783',N'TAI4@GMAIL.COM','HDT02','GVPT003'),
('GVPT004',N'NGUYỄN THỊ LUYẾN',N'NỮ','0123556784',N'LUYEN4@GMAIL.COM','HDT02','GVPT004'),
('GVPT005',N'TRẦN ANH KHOA',N'NAM','0123656789',N'KHOA11@GMAIL.COM','HDT02','GVPT005'),
('GVPT006',N'TRẦN ANH TÚ',N'NAM','0223756789',N'TU11@GMAIL.COM','HDT02','GVPT006'),
('GVPT007',N'TRẦN ANH TÀI',N'NAM','0323856789',N'TAI11GMAIL.COM','HDT02','GVPT007'),
('GVPT008',N'TRẦN ANH LUYẾN',N'NỮ','0423956789',N'LUYEN11@GMAIL.COM','HDT02','GVPT008'),
('GVPT009',N'HỒ ANH KHOA',N'NAM','0123456119',N'KHOA22@GMAIL.COM','HDT02','GVPT009'),
('GVPT010',N'HỒ ANH TÚ',N'NAM','0123456229',N'TU22@GMAIL.COM','HDT02','GVPT010'),
('GVPT011',N'HỒ ANH TÀI',N'NAM','0123456339',N'TAI22@GMAIL.COM','HDT02','GVPT011'),
('GVPT012',N'HỒ ANH LUYẾN',N'NỮ','0123456449',N'LUYEN22@GMAIL.COM','HDT02','GVPT012'),
('GVPT013',N'PHẠM ANH KHOA',N'NAM','0143456589',N'KHOA33@GMAIL.COM','HDT02','GVPT013'),
('GVPT014',N'PHẠM ANH TÚ',N'NAM','0125456689',N'TU33@GMAIL.COM','HDT02','GVPT014'),
('GVPT015',N'PHẠM ANH TÀI',N'NAM','0126456889',N'TAI33@GMAIL.COM','HDT02','GVPT015'),
('GVPT016',N'PHẠM ANH LUYẾN',N'NỮ','0127456989',N'LUYEN33@GMAIL.COM','HDT02','GVPT016'),
('GVPT017',N'HỒ ANH KHOA',N'NAM','0123451119',N'KHOA122@GMAIL.COM','HDT02','GVPT017'),
('GVPT018',N'HỒ ANH TÚ',N'NAM','0123452229',N'TU122@GMAIL.COM','HDT02','GVPT018'),
('GVPT019',N'HỒ ANH TÀI',N'NAM','0123453339',N'TAI122@GMAIL.COM','HDT02','GVPT019'),
('GVPT020',N'HỒ ANH LUYẾN',N'NỮ','0123454449',N'LUYEN122@GMAIL.COM','HDT02','GVPT020'),
('GVPT021',N'PHẠM ANH KHOA',N'NAM','0143455589',N'KHOA133@GMAIL.COM','HDT02','GVPT021'),
('GVPT022',N'PHẠM ANH TÚ',N'NAM','0125457689',N'TU133@GMAIL.COM','HDT02','GVPT022'),
('GVPT023',N'PHẠM ANH TÀI',N'NAM','0126458889',N'TAI133@GMAIL.COM','HDT02','GVPT023'),
('GVPT024',N'PHẠM ANH LUYẾN',N'NỮ','0127459989',N'LUYEN133@GMAIL.COM','HDT02','GVPT024')



INSERT INTO LOP
VALUES 
('ML06A','6A',40,'MK006','GVCS001'),
('ML06B','6B',42,'MK006','GVCS002'),
('ML06C','6C',44,'MK006','GVCS003'),
('ML06D','6D',45,'MK006','GVCS004'),

('ML07A','7A',46,'MK007','GVCS005'),
('ML07B','7B',39,'MK007','GVCS006'),
('ML07C','7C',47,'MK007','GVCS007'),
('ML07D','7D',45,'MK007','GVCS008'),
('ML08A','8A',40,'MK008','GVCS009'),
('ML08B','8B',41,'MK008','GVCS010'),
('ML08C','8C',38,'MK008','GVCS011'),
('ML08D','8D',44,'MK008','GVCS012'),
('ML09A','9A',42,'MK009','GVCS013'),
('ML09B','9B',46,'MK009','GVCS014'),
('ML09D','9C',43,'MK009','GVCS015'),
('ML09C','9D',43,'MK009','GVCS016'),

('ML10A','10A',40,'MK010','GVPT001'),
('ML10B','10B',41,'MK010','GVPT002'),
('ML10C','10C',42,'MK010','GVPT003'),
('ML10D','10D',43,'MK010','GVPT004'),
('ML10E','10E',44,'MK010','GVPT005'),
('ML10F','10F',45,'MK010','GVPT006'),
('ML10I','10I',46,'MK010','GVPT007'),
('ML10K','10K',43,'MK010','GVPT008'),

('ML11A','11A',40,'MK011','GVPT009'),
('ML11B','11B',41,'MK011','GVPT010'),
('ML11C','11C',42,'MK011','GVPT011'),
('ML11D','11D',43,'MK011','GVPT012'),
('ML11E','11E',44,'MK011','GVPT013'),
('ML11F','11F',45,'MK011','GVPT014'),
('ML11I','11I',46,'MK011','GVPT015'),
('ML11K','11K',43,'MK011','GVPT016'),

('ML12A','12A',40,'MK012','GVPT017'),
('ML12B','12B',41,'MK012','GVPT018'),
('ML12C','12C',42,'MK012','GVPT019'),
('ML12D','12D',43,'MK012','GVPT020'),
('ML12E','12E',44,'MK012','GVPT021'),
('ML12F','12F',45,'MK012','GVPT022'),
('ML12I','12I',46,'MK012','GVPT023'),
('ML12K','12K',43,'MK012','GVPT024')
INSERT INTO KHOAHOC
VALUES 
('MKHCS01',2000,2004,'HDT01'),
('MKHCS02',2001,2005,'HDT01'),
('MKHCS03',2002,2006,'HDT01'),
('MKHCS04',2003,2007,'HDT01'),
('MKHCS05',2004,2008,'HDT01'),
('MKHCS06',2005,2009,'HDT01'),
('MKHCS07',2006,2010,'HDT01'),
('MKHCS08',2007,2011,'HDT01'),
('MKHCS09',2008,2012,'HDT01'),
('MKHCS10',2009,2013,'HDT01'),
('MKHCS11',2010,2014,'HDT01'),
('MKHCS12',2011,2015,'HDT01'),
('MKHCS13',2012,2016,'HDT01'),
('MKHCS14',2013,2017,'HDT01'),
('MKHCS15',2014,2018,'HDT01'),
('MKHCS16',2015,2019,'HDT01'),
('MKHCS17',2016,2020,'HDT01'),
('MKHCS18',2017,2021,'HDT01'),
('MKHCS19',2018,2022,'HDT01'),
('MKHCS20',2019,2023,'HDT01'),

('MKHPT01',2000,2003,'HDT02'),
('MKHPT02',2001,2004,'HDT02'),
('MKHPT03',2002,2005,'HDT02'),
('MKHPT04',2003,2006,'HDT02'),
('MKHPT05',2004,2007,'HDT02'),
('MKHPT06',2005,2008,'HDT02'),
('MKHPT07',2006,2019,'HDT02'),
('MKHPT08',2007,2010,'HDT02'),
('MKHPT09',2008,2011,'HDT02'),
('MKHPT10',2009,2012,'HDT02'),
('MKHPT11',2010,2013,'HDT02'),
('MKHPT12',2011,2014,'HDT02'),
('MKHPT13',2012,2015,'HDT02'),
('MKHPT14',2013,2016,'HDT02'),
('MKHPT15',2014,2017,'HDT02'),
('MKHPT16',2015,2018,'HDT02'),
('MKHPT17',2016,2019,'HDT02'),
('MKHPT18',2017,2020,'HDT02'),
('MKHPT19',2018,2021,'HDT02'),
('MKHPT20',2019,2022,'HDT02')
INSERT INTO HOCSINH
VALUES
('MHSCS01',N'NGUYỄN HẢI TIẾN','ML06A','2/2/2007',N'TÂN PHÚ,HCM',N'NAM','MKHCS16'),
('MHSCS02',N'NGUYỄN HẢI HIỀN','ML06B','2/3/2007',N'TÂN BÌNH,HCM',N'NỮ','MKHCS16'),
('MHSCS03',N'TRẦN TRUNG PHÚC','ML06C','2/4/2007',N'BÌNH THẠNH,HCM',N'NAM','MKHCS16'),
('MHSCS04',N'NGUYỄN HẢI YẾN','ML06D','2/5/2007',N'QUẬN CAM,HCM',N'NỮ','MKHCS16'),

('MHSCS05',N'LÊ VĂN ĐẠT'           ,'ML07A','3/4/2006',N'TÂN PHÚ,HCM',N'NAM','MKHCS15'),
('MHSCS06',N'LÊ PHÚ HƯNG'          ,'ML07B','3/5/2006',N'QUẬN 2,HCM',N'NAM','MKHCS15'),
('MHSCS07',N'NGUYỄN THỊ NGỌC TRÂM','ML07C','3/6/2006',N'PHÚ NHUẬN,HCM',N'NỮ','MKHCS15'),
('MHSCS08',N'NGUYỄN CẨM TIÊN',     'ML07D','3/7/2006',N'TÂN PHÚ,HCM',N'NỮ','MKHCS15'),

('MHSCS09',N'NGUYỄN VĂN LA','ML08A','4/2/2005',N'TÂN PHÚ,HCM',N'NAM','MKHCS14'),
('MHSCS10',N'NGUYỄN TRUNG HÙNG','ML08B','4/7/2005',N'TÂN PHÚ,HCM',N'NAM','MKHCS14'),
('MHSCS11',N'NGUYỄN THỊ MỘNG MƠ','ML08C','4/9/2005',N'TÂN PHÚ,HCM',N'NỮ','MKHCS14'),
('MHSCS12',N'NGUYỄN THỊ HẠNH','ML08D','4/10/2005',N'TÂN PHÚ,HCM',N'NỮ','MKHCS14'),

('MHSCS13',N'HỒ VĂN NAM','ML09A','4/2/2004',N'TÂN PHÚ,HCM',N'NAM','MKHCS13'),
('MHSCS14',N'HỒ NGUYỆN','ML09B','4/7/2004',N'TÂN PHÚ,HCM',N'NAM','MKHCS13'),
('MHSCS15',N'ĐỊNH THỊ NGỌC','ML09D','4/9/2004',N'TÂN PHÚ,HCM',N'NỮ','MKHCS13'),
('MHSCS16',N'NGUYỄN QUANG HUY','ML09C','4/10/2004',N'TÂN PHÚ,HCM',N'NAM','MKHCS13'),




('MHSPT01',N'VÕ TRUNG PHÚC ','ML10A','4/2/2002',N'TÂN PHÚ,HCM',N'NAM','MKHPT16'),
('MHSPT02',N'NGUYỄN THỊ TÚ','ML10B','4/7/2002',N'TÂN PHÚ,HCM',N'NỮ','MKHPT16'),
('MHSPT03',N'TRẦN QUỐC HUY','ML10C','4/9/2002',N'TÂN PHÚ,HCM',N'NAM','MKHPT16'),
('MHSPT04',N'NGUYỄN THỊ LOAN','ML10D','4/10/2002',N'TÂN PHÚ,HCM',N'NỮ','MKHPT16'),
('MHSPT05',N'VÕ TRUNG LONG ','ML10E','4/3/2002',N'TÂN PHÚ,HCM',N'NAM','MKHPT16'),
('MHSPT06',N'NGUYỄN THỊ HUỆ','ML10F','4/5/2002',N'TÂN PHÚ,HCM',N'NỮ','MKHPT16'),
('MHSPT07',N'TRẦN QUỐC HUY','ML10I','4/1/2002',N'TÂN PHÚ,HCM',N'NAM','MKHPT16'),
('MHSPT08',N'NGUYỄN CẨM HIỀN','ML10K','5/3/2002',N'TÂN PHÚ,HCM',N'NỮ','MKHPT16'),

('MHSPT09',N'VÕ TRUNG PHÚC ','ML11A','5/2/2001',N'TÂN PHÚ,HCM',N'NAM','MKHPT15'),
('MHSPT10',N'NGUYỄN THỊ TÚ','ML11B','6/7/2001',N'TÂN PHÚ,HCM',N'NỮ','MKHPT15'),
('MHSPT11',N'TRẦN QUỐC HUY','ML11C','2/9/2001',N'TÂN PHÚ,HCM',N'NAM','MKHPT15'),
('MHSPT12',N'NGUYỄN THỊ LOAN','ML11D','1/10/2001',N'TÂN PHÚ,HCM',N'NỮ','MKHPT15'),
('MHSPT13',N'VÕ TRUNG LONG ','ML11E','2/3/2001',N'TÂN PHÚ,HCM',N'NAM','MKHPT15'),
('MHSPT14',N'NGUYỄN THỊ HUỆ','ML11F','4/5/2001',N'TÂN PHÚ,HCM',N'NỮ','MKHPT15'),
('MHSPT15',N'TRẦN QUỐC HUY','ML11I','8/1/2001',N'TÂN PHÚ,HCM',N'NAM','MKHPT15'),
('MHSPT16',N'NGUYỄN CẨM HIỀN','ML11K','4/3/2001',N'TÂN PHÚ,HCM',N'NỮ','MKHPT15'),

('MHSPT17',N'VÕ TRUNG PHÚC ','ML12A','4/2/2000',N'TÂN PHÚ,HCM',N'NAM','MKHPT14'),
('MHSPT18',N'NGUYỄN THỊ TÚ','ML12B','4/3/2000',N'TÂN PHÚ,HCM',N'NỮ','MKHPT14'),
('MHSPT19',N'TRẦN QUỐC HUY','ML12C','4/4/2000',N'TÂN PHÚ,HCM',N'NAM','MKHPT14'),
('MHSPT20',N'NGUYỄN THỊ LOAN','ML12D','4/5/2000',N'TÂN PHÚ,HCM',N'NỮ','MKHPT14'),
('MHSPT21',N'VÕ TRUNG LONG ','ML12E','4/6/2000',N'TÂN PHÚ,HCM',N'NAM','MKHPT14'),
('MHSPT22',N'NGUYỄN THỊ HUỆ','ML12F','4/7/2000',N'TÂN PHÚ,HCM',N'NỮ','MKHPT14'),
('MHSPT23',N'TRẦN QUỐC HUY','ML12I','4/8/2000',N'TÂN PHÚ,HCM',N'NAM','MKHPT14'),
('MHSPT24',N'NGUYỄN CẨM HIỀN','ML12K','5/9/2000',N'TÂN PHÚ,HCM',N'NỮ','MKHPT14')

INSERT INTO MONHOC
VALUES 
('MMHCS01',N'NGỮ VĂN ','HDT01'),
('MMHCS02',N'GIÁO DỤC ','HDT01'),
('MMHCS03',N'ĐẠO ĐỨC ','HDT01'),
('MMHCS04',N'THỂ DỤC ','HDT01'),
('MMHCS05',N'TIẾNG ANH ','HDT01'),
('MMHCS06',N'TOÁN ','HDT01'),
('MMHCS07',N'ĐỊA LÝ','HDT01'),
('MMHCS08',N'SINH HỌC','HDT01'),
('MMHCS09',N'HÓA HỌC','HDT01'),
('MMHCS10',N'LỊCH SỬ','HDT01'),

('MMHPT01',N'VĂN HỌC ','HDT02'),
('MMHPT02',N'ĐẠI SỐ ','HDT02'),
('MMHPT03',N'GIÁO DỤC ','HDT02'),
('MMHPT04',N'THỂ DỤC ','HDT02'),
('MMHPT05',N'TIẾNG ANH ','HDT02'),
('MMHPT06',N'ENGLISH ','HDT02'),
('MMHPT07',N'ĐỊA LÝ','HDT02'),
('MMHPT08',N'SINH HỌC','HDT02'),
('MMHPT09',N'HÓA HỌC','HDT02'),
('MMHPT10',N'LỊCH SỬ','HDT02')

INSERT INTO PHANCONG
VALUES
('GVCS001','MMHCS01','ML06A','MKHCS16','HDT01'),
('GVCS002','MMHCS02','ML06B','MKHCS16','HDT01'),
('GVCS003','MMHCS03','ML06C','MKHCS16','HDT01'),
('GVCS004','MMHCS04','ML06D','MKHCS16','HDT01'),
('GVCS005','MMHCS05','ML07A','MKHCS15','HDT01'),
('GVCS006','MMHCS06','ML07B','MKHCS15','HDT01'),
('GVCS007','MMHCS07','ML07C','MKHCS15','HDT01'),
('GVCS008','MMHCS08','ML07D','MKHCS15','HDT01'),
('GVCS009','MMHCS09','ML08A','MKHCS14','HDT01'),
('GVCS010','MMHCS10','ML08B','MKHCS14','HDT01'),
('GVCS011','MMHCS01','ML08C','MKHCS14','HDT01'),
('GVCS012','MMHCS02','ML08D','MKHCS14','HDT01'),
('GVCS013','MMHCS03','ML09A','MKHCS13','HDT01'),
('GVCS014','MMHCS04','ML09B','MKHCS13','HDT01'),
('GVCS015','MMHCS05','ML09C','MKHCS13','HDT01'),
('GVCS016','MMHCS06','ML09D','MKHCS13','HDT01'),

('GVPT001','MMHPT01','ML10A','MKHPT16','HDT02'),
('GVPT002','MMHPT02','ML10B','MKHPT16','HDT02'),
('GVPT003','MMHPT03','ML10C','MKHPT16','HDT02'),
('GVPT004','MMHPT04','ML10D','MKHPT16','HDT02'),
('GVPT005','MMHPT05','ML10E','MKHPT16','HDT02'),
('GVPT006','MMHPT06','ML10F','MKHPT16','HDT02'),
('GVPT007','MMHPT07','ML10I','MKHPT16','HDT02'),
('GVPT008','MMHPT08','ML10K','MKHPT16','HDT02'),
('GVPT009','MMHPT09','ML11A','MKHPT15','HDT02'),
('GVPT010','MMHPT10','ML11B','MKHPT15','HDT02'),
('GVPT011','MMHPT01','ML11C','MKHPT15','HDT02'),
('GVPT012','MMHPT02','ML11D','MKHPT15','HDT02'),
('GVPT013','MMHPT03','ML11E','MKHPT15','HDT02'),
('GVPT014','MMHPT04','ML11F','MKHPT15','HDT02'),
('GVPT015','MMHPT05','ML11I','MKHPT15','HDT02'),
('GVPT016','MMHPT06','ML11K','MKHPT15','HDT02'),
('GVPT017','MMHPT10','ML12A','MKHPT14','HDT02'),
('GVPT018','MMHPT02','ML12B','MKHPT14','HDT02'),
('GVPT019','MMHPT03','ML12C','MKHPT14','HDT02'),
('GVPT020','MMHPT04','ML12D','MKHPT14','HDT02'),
('GVPT021','MMHPT05','ML12E','MKHPT14','HDT02'),
('GVPT022','MMHPT06','ML12F','MKHPT14','HDT02'),
('GVPT023','MMHPT07','ML12I','MKHPT14','HDT02'),
('GVPT024','MMHPT08','ML12K','MKHPT14','HDT02')
INSERT INTO KETQUA
VALUES
('MHSCS01','MMHCS01',7,'HDT01','MKHCS16'),
('MHSCS02','MMHCS02',6,'HDT01','MKHCS16'),
('MHSCS03','MMHCS03',5,'HDT01','MKHCS16'),
('MHSCS04','MMHCS04',9,'HDT01','MKHCS16'),
('MHSCS05','MMHCS05',3,'HDT01','MKHCS15'),
('MHSCS06','MMHCS06',2,'HDT01','MKHCS15'),
('MHSCS07','MMHCS07',7.5,'HDT01','MKHCS15'),
('MHSCS08','MMHCS08',7.3,'HDT01','MKHCS15'),
('MHSCS09','MMHCS09',9.7,'HDT01','MKHCS14'),
('MHSCS10','MMHCS10',4.7,'HDT01','MKHCS14'),
('MHSCS11','MMHCS01',7.7,'HDT01','MKHCS14'),
('MHSCS12','MMHCS01',7.6,'HDT01','MKHCS14'),
('MHSCS13','MMHCS09',9.7,'HDT01','MKHCS13'),
('MHSCS14','MMHCS10',4.7,'HDT01','MKHCS13'),
('MHSCS15','MMHCS01',7.7,'HDT01','MKHCS13'),
('MHSCS16','MMHCS01',7.6,'HDT01','MKHCS13'),

('MHSPT01','MMHPT01',7,'HDT02','MKHPT16'),
('MHSPT02','MMHPT02',7.2,'HDT02','MKHPT16'),
('MHSPT03','MMHPT03',7.4,'HDT02','MKHPT16'),
('MHSPT04','MMHPT04',7.6,'HDT02','MKHPT16'),
('MHSPT05','MMHPT05',7.7,'HDT02','MKHPT16'),
('MHSPT06','MMHPT06',7.9,'HDT02','MKHPT16'),
('MHSPT07','MMHPT07',6.7,'HDT02','MKHPT16'),
('MHSPT08','MMHPT08',6.7,'HDT02','MKHPT16'),
('MHSPT09','MMHPT09',7.7,'HDT02','MKHPT15'),
('MHSPT10','MMHPT10',9.7,'HDT02','MKHPT15'),
('MHSPT11','MMHPT01',3.7,'HDT02','MKHPT15'),
('MHSPT12','MMHPT02',7,'HDT02','MKHPT15'),
('MHSPT13','MMHPT03',7,'HDT02','MKHPT15'),
('MHSPT14','MMHPT04',7,'HDT02','MKHPT15'),
('MHSPT15','MMHPT05',7,'HDT02','MKHPT15'),
('MHSPT16','MMHPT06',7,'HDT02','MKHPT15'),
('MHSPT17','MMHPT07',7,'HDT02','MKHPT14'),
('MHSPT18','MMHPT01',7,'HDT02','MKHPT14'),
('MHSPT19','MMHPT02',7,'HDT02','MKHPT14'),
('MHSPT20','MMHPT04',7,'HDT02','MKHPT14'),
('MHSPT21','MMHPT05',7,'HDT02','MKHPT14'),
('MHSPT22','MMHPT06',7,'HDT02','MKHPT14'),
('MHSPT23','MMHPT08',7,'HDT02','MKHPT14'),
('MHSPT24','MMHPT10',7,'HDT02','MKHPT14')


ALTER TABLE HEDAOTAO
ADD CONSTRAINT CHECK_TEN_HE CHECK ((TENHE = 'THCS' ) OR (TENHE = 'THPT'));
ALTER TABLE HOCSINH
ADD CONSTRAINT CHECK_GIOI_TINH CHECK ((GIOITINH=N'NAM') OR (GIOITINH =N'NỮ'));
ALTER TABLE KHOAHOC
ADD CONSTRAINT CHECK_NAMBD_NAMKT CHECK (NAMBD < NAMKT);
ALTER TABLE LOP
ADD CONSTRAINT CHECK_SI_SO CHECK (SISO > 0);

select TENKHOI FROM KHOI, HEDAOTAO where KHOI.MAHE = HEDAOTAO.MAHE AND TENHE ='THPT'