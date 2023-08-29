CREATE TABLE ChiNhanh(
	MaCN 		varchar(4)		PRIMARY KEY,
    TenCN		varchar(100)	NOT NULL UNIQUE,
    Khuvuc		varchar(50),
    Diachi		varchar(100),
    Email		varchar(50),
    Fax			varchar(15),
    MaNVql		varchar(6)		NOT NULL
);

CREATE TABLE SDT_CN(
	MaCN		varchar(4)		NOT NULL,
    SDT			varchar(10),
    PRIMARY KEY (MaCN,SDT),
    CONSTRAINT  fk_sdt_chinhanh_macn FOREIGN KEY(MaCN)
    REFERENCES	ChiNhanh(MaCN)	ON DELETE CASCADE
);

CREATE TABLE NhanVien(
	MaNV		char(6)		PRIMARY KEY,
    CMND		varchar(12),
    Hoten		varchar(50)		NOT NULL,
    DiaChi		varchar(100),
    Gioitinh	char(1),
    Ngaysinh	DATE,
    LoaiNV		char(1),
    Vitri 		varchar(50),
    MaCNlv		varchar(4)		NOT NULL,
    CONSTRAINT  fk_nhanvien_chinhanh_macnlv	FOREIGN KEY (MaCNlv)
    REFERENCES  ChiNhanh(MaCN),
    CONSTRAINT  ck_manv	CHECK (NhanVien.MaNV LIKE 'VP%' OR NhanVien.MaNV LIKE 'HD%'),
    CONSTRAINT  ck_gioitinh	CHECK (NhanVien.Gioitinh = 'F' OR NhanVien.Gioitinh = 'M'),
    CONSTRAINT  ck_loainv	CHECK (NhanVien.LoaiNV = '1' OR NhanVien.LoaiNV = '2'),
    CONSTRAINT	ck_maNV_num CHECK (substring(NhanVien.MaNV,3) REGEXP '^[0-9]+$')
);

ALTER TABLE ChiNhanh 
ADD CONSTRAINT fk_chinhanh_nhanvien_manvql FOREIGN KEY (MaNVql)
	REFERENCES NhanVien(MaNV);

CREATE TABLE NgoaiNguNV (
	MaNV		char(6)		NOT NULL,
    NgoaiNgu	varchar(20),
    PRIMARY KEY (MaNV, NgoaiNgu),
    CHECK (MaNV LIKE 'HD%'),
    CONSTRAINT fk_ngoaingu_nhanvien_manv FOREIGN KEY(MaNV)
    REFERENCES NhanVien(MaNV) ON DELETE CASCADE
);

CREATE TABLE KyNangNV (
	MaNV		char(6)		NOT NULL,
    KyNang		varchar(20),
    PRIMARY KEY (MaNV, KyNang),
    CHECK (MaNV LIKE 'HD%'),
    CONSTRAINT fk_kynang_nhanvien_manv FOREIGN KEY(MaNV)
    REFERENCES NhanVien(MaNV) ON DELETE CASCADE
);
CREATE TABLE DiemDuLich	(
	Madiem		int 	AUTO_INCREMENT	    PRIMARY KEY,
    Tendiem		varchar(50)		NOT NULL,
    Diachi		varchar(50),
    PhuongXa	varchar(50),
    QuanHuyen	varchar(50),
    TinhThanh	varchar(50),
    Anh1		varchar(1000),
    Anh2		varchar(1000),
    Anh3		varchar(1000),
    Mota		varchar(2000),
    Ghichu		varchar(250)
);

CREATE TABLE DonViCungCapDV	(
	Madonvi		char(6)	PRIMARY KEY,
    Tendonvi	varchar(50)	NOT NULL,
    Email		varchar(50),
    Dienthoai	varchar(10),
    TenNguoidaidien		varchar(50),
    Dienthoainguoidd	varchar(10),
    Diachi		varchar(50),
    PhuongXa	varchar(50),
    QuanHuyen	varchar(50),
    TinhThanh	varchar(50),
    Anh1		varchar(1000),
    Anh2		varchar(1000),
    Anh3		varchar(1000),
    Anh4		varchar(1000),
    Anh5		varchar(1000),
    Loai		char(1),
    Ghichu		varchar(250),
    CONSTRAINT ck_madonvi CHECK (Madonvi LIKE 'DV%'),
    CONSTRAINT ck_loai	CHECK (Loai = '1' OR Loai = '2' OR Loai = '3'),
    CONSTRAINT ck_madonvi_num CHECK (substring(Madonvi,3) REGEXP '^[0-9]+$')
);

CREATE TABLE KhachHang (
	MaKhachHang		char(6)		PRIMARY KEY,
	CMND		varchar(12),
    Hoten		varchar(50)		NOT NULL,
    Email		varchar(50),
    Dienthoai	varchar(10),
    Ngaysinh	DATE,
    Diachi		varchar(50),
    CONSTRAINT ck_makhachhang CHECK (MaKhachHang LIKE 'KH%'),
    CONSTRAINT ck_makhachhang_num CHECK (substring(MaKhachHang,3) REGEXP '^[0-9]+$')
);

CREATE TABLE  KhachDoan	(
	MaDoan		char(6)			PRIMARY KEY,
    Tencoquan	varchar(50)		NOT NULL,
    Email		varchar(50),
    Dienthoai	varchar(10),
	Diachi		varchar(50),
    Madaidien	char(6),
    CONSTRAINT	ck_madoan CHECK (MaDoan LIKE 'KD%'),
    CONSTRAINT  fk_khachdoan_khachhang_daidien	FOREIGN KEY(Madaidien)
    REFERENCES	KhachHang(MaKhachHang),
    CONSTRAINT ck_madoan_num CHECK (substring(MaDoan,3) REGEXP '^[0-9]+$')
);

CREATE TABLE KhachDoanGomKhachLe (
	Madoan	char(6),
    Makhachhang	char(6),
    PRIMARY KEY	(Madoan, Makhachhang),
    CONSTRAINT fk_gom_khachdoan_madoan	FOREIGN KEY	(Madoan)
    REFERENCES	KhachDoan(MaDoan) ON DELETE CASCADE,
    CONSTRAINT fk_gom_khachle_makhach	FOREIGN KEY	(Makhachhang)
    REFERENCES	KhachHang(MaKhachHang) ON DELETE CASCADE
);

CREATE TABLE TOUR (
	Matour		varchar(11)		PRIMARY KEY,
    Tentour		varchar(150)		NOT NULL,
    Anh			varchar(1000),
    Ngaybatdau	DATE,
    Sokhachtourtoithieu  int,
    Sokhachtourtoida	 int,
    Giavelenguoilon		 DECIMAL(10,0),
    Giaveletreem	 	 DECIMAL(10,0),
    Giavedoannguoilon	 DECIMAL(10,0),
    Giavedoantreem	 	 DECIMAL(10,0),
    Sokhachdoantoithieu	 int,
    Sodem				 tinyint   	    NOT NULL,
    Songay				 tinyint		NOT NULL,
    Machinhanh			 varchar(4)		NOT NULL,
    CONSTRAINT fk_tour_chinhanh_machinhanh	FOREIGN KEY(Machinhanh)
    REFERENCES	ChiNhanh(MaCN),
    CHECK (Sodem >= 0 AND Songay > 0),
    CONSTRAINT ck_giave_soluong	CHECK ( Giavedoantreem < Giavedoannguoilon
    AND	 Giaveletreem < Giavelenguoilon AND Giavedoannguoilon < Giavelenguoilon	
    AND  Giavedoantreem < Giaveletreem AND Sokhachtourtoithieu < Sokhachtourtoida)
);



CREATE TABLE Ngaykhoihanhtourdaingay (
	Matour		varchar(11)		NOT NULL,
    Ngay		int,
    CHECK (Ngay >= 1 AND Ngay <= 31),
    PRIMARY KEY (Matour, Ngay),
    CONSTRAINT  fk_ngaykhoihanhtourdaingay_tour_matour	FOREIGN KEY(Matour)
    REFERENCES  TOUR(Matour)  ON DELETE CASCADE
);

CREATE TABLE Lichtrinhtour(
	Matour		varchar(11)		NOT NULL,
    STTngay	    int,
    PRIMARY KEY	(Matour, STTngay),
    CONSTRAINT  fk_lichtrinhtour_tour_matour	FOREIGN KEY(Matour)
    REFERENCES  TOUR(Matour)  ON DELETE CASCADE
);

CREATE TABLE TourGomDDTQ (
	Matour			varchar(11)		NOT NULL,
    STTngay	    	int				NOT NULL,
    Madiemdulich 	int,
	Thoigianbatdau	time,
    Thoigianketthuc time,
    Mota			varchar(1000),
    PRIMARY KEY (Matour, STTngay, Madiemdulich),
    CONSTRAINT	fk_tourgom_lichtrinhtour	FOREIGN KEY (Matour, STTngay)
    REFERENCES	Lichtrinhtour(Matour, STTngay) ON DELETE CASCADE,
    CONSTRAINT fk_tourgom_diemdulich_madiemdulich	FOREIGN KEY(Madiemdulich)
    REFERENCES	DiemDuLich(Madiem) ON DELETE CASCADE
);

CREATE TABLE HanhDongLichtrinhtour (
	Matour			varchar(11)		NOT NULL,
    STTngay	    	int				NOT NULL,
    Loaihanhdong 	char(1),
    Giobatdau		time,
    Gioketthuc		time,
    Mota			varchar(1000),
    PRIMARY KEY (Matour, STTngay, Loaihanhdong),
    CHECK (Loaihanhdong = '1' OR Loaihanhdong = '2' OR Loaihanhdong = '3' 
    OR Loaihanhdong = '4' OR Loaihanhdong = '5' OR Loaihanhdong = '6' OR Loaihanhdong = '7'),
    CONSTRAINT	fk_hanhdong_lichtrinhtour	FOREIGN KEY (Matour, STTngay)
    REFERENCES	Lichtrinhtour(Matour, STTngay) ON DELETE CASCADE
);

CREATE TABLE ChuyenDi (
	Matour			varchar(11) 	NOT NULL,
    Ngaykhoihanh	date,
    Ngayketthuc		date,
    Tonggia			decimal(10,0),
    PRIMARY KEY (Matour, Ngaykhoihanh),
    CONSTRAINT fk_chuyendi_tour_matour	FOREIGN KEY (Matour)
    REFERENCES TOUR(Matour) ON DELETE CASCADE
);

CREATE TABLE HDVDanChuyenDi (
	Matour			varchar(11) 	NOT NULL,
    Ngaykhoihanh	date			NOT NULL,
    MaHDV			varchar(6)		NOT NULL,
    PRIMARY KEY (Matour, Ngaykhoihanh, MaHDV),
    CHECK (MaHDV LIKE 'HD%'),
    CONSTRAINT fk_hdvdanchuyendi_chuyendi	FOREIGN KEY(Matour, Ngaykhoihanh)
    REFERENCES	ChuyenDi(Matour, Ngaykhoihanh) ON DELETE CASCADE,
    CONSTRAINT fk_hdvdanchuyendi_mahdv	FOREIGN KEY(MaHDV)
    REFERENCES	NhanVien(MaNV)	ON DELETE CASCADE
);

CREATE TABLE LichTrinhChuyen (
	Matour			varchar(11) 	NOT NULL,
    Ngaykhoihanh	date			NOT NULL,
    STTngay			int,
    PRIMARY KEY (Matour, Ngaykhoihanh, STTngay),
    CONSTRAINT fk_lichtrinhchuyen_chuyendi FOREIGN KEY(Matour, Ngaykhoihanh)
    REFERENCES	ChuyenDi(Matour, Ngaykhoihanh) ON DELETE CASCADE
);

CREATE TABLE DVCCDVChuyen (
	Matour			varchar(11) 	NOT NULL,
    Ngaykhoihanh	date			NOT NULL,
    STTngay			int				NOT NULL,
    Loai			char(1),
    Madonvi			char(6),
    PRIMARY KEY (Matour, Ngaykhoihanh, STTngay, Loai, Madonvi),
    CHECK (Loai = '1' OR Loai = '2' OR Loai= '3' OR Loai = '4' OR Loai = '5' 
    OR Loai = '6' OR Loai = '7' OR Loai = '8'),
    CONSTRAINT fk_DVCCDVChuyen_lichtrinhchuyen FOREIGN KEY(Matour, Ngaykhoihanh, STTngay)
    REFERENCES	LichTrinhChuyen(Matour, Ngaykhoihanh, STTngay) ON DELETE CASCADE,
    CONSTRAINT fk_DVCCDVChuyen_DonViCungCapDV  FOREIGN KEY(Madonvi)
	REFERENCES DonViCungCapDV(Madonvi) ON DELETE CASCADE	
);

CREATE TABLE PhieuDangky (
	Maphieu			varchar(17)		PRIMARY KEY,
    Ngaydangky		DATE			NOT NULL,
    Ghichu			varchar(250),
    MaNV			char(6)		NOT NULL,
    Makhachle		char(6),
    Makhachdoan		char(6),
    Matour			varchar(11)		NOT NULL,
    Ngaykhoihanh	DATE			NOT NULL,
    CHECK (MaNV LIKE 'VP%'),
    CONSTRAINT fk_phieudangky_nhanvien_manv	FOREIGN KEY(MaNV)
    REFERENCES	NhanVien(MaNV)	ON DELETE CASCADE,
    CONSTRAINT fk_phieudangky_khachhang_makhachle FOREIGN KEY(Makhachle)
    REFERENCES  KhachHang(MaKhachHang) ON DELETE CASCADE,
    CONSTRAINT fk_phieudangky_khachdoan_madoan FOREIGN KEY (Makhachdoan)
    REFERENCES	KhachDoan(MaDoan)  ON DELETE CASCADE,
    CONSTRAINT fk_phieudangky_chuyendi	FOREIGN KEY (Matour, Ngaykhoihanh)
    REFERENCES	ChuyenDi(Matour, Ngaykhoihanh) ON DELETE CASCADE
);

CREATE TABLE DonViCungCapDVlienquan (
	Matour		varchar(11)		NOT NULL,
    Madiem		int				NOT NULL,
    Madonvi		char(6)		NOT NULL,
    PRIMARY KEY (Matour, Madiem, Madonvi),
    CONSTRAINT fk_DVCCDVlienquan_tour	FOREIGN KEY(Matour)
    REFERENCES	TOUR(Matour) ON DELETE CASCADE,
    CONSTRAINT fk_DVCCDVlienquan_diem	FOREIGN KEY(Madiem)
    REFERENCES DiemDuLich(Madiem) ON DELETE CASCADE,
    CONSTRAINT fk_DVCCDVlienquan_donvi	FOREIGN KEY(Madonvi)
    REFERENCES 	DonViCungCapDV(Madonvi) ON DELETE CASCADE
);


-- Insert into table ChiNhanh
CREATE TABLE ChiNhanh_index (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DELIMITER //
CREATE TRIGGER tg_ChiNhanh_insert
BEFORE INSERT ON ChiNhanh FOR EACH ROW
BEGIN
	INSERT INTO ChiNhanh_index VALUES (NULL);
	SET NEW.MaCN = CONCAT('CN', LAST_INSERT_ID());
END;//
DELIMITER ;


-- Insert into table TOUR
CREATE TABLE TOUR_index (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);
DELIMITER //
CREATE TRIGGER tg_TOUR_insert
BEFORE INSERT ON TOUR FOR EACH ROW
BEGIN
	INSERT INTO TOUR_index VALUES (NULL);
	SET NEW.Matour = CONCAT(NEW.Machinhanh,'-', LPAD(LAST_INSERT_ID(), 6, '0'));
END;//
DELIMITER ;



-- Insert into table PhieuDangky
CREATE TABLE PDK_index (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);
DELIMITER //
CREATE TRIGGER tg_PhieuDangky_insert
BEFORE INSERT ON PhieuDangky FOR EACH ROW
BEGIN 
INSERT INTO PDK_index VALUES (NULL);
SET NEW.Maphieu = CONCAT(DATE_FORMAT(NEW.NgayDangKy,"%d%m%Y"), LPAD(LAST_INSERT_ID(), 9, '0'));
END;//
DELIMITER ;


set global log_bin_trust_function_creators = 1;
-- Phan 2
-- a
DELIMITER //
CREATE FUNCTION SoLuongKhach (matour varchar(11), ngaykhoihanh date)
RETURNS INT
BEGIN
	DECLARE TongSoKhachLe INT;
    DECLARE TongSoKhachDoan INT;
    
    SELECT COUNT(*) INTO TongSoKhachLe FROM PhieuDangky P WHERE P.Matour = matour AND P.Ngaykhoihanh = ngaykhoihanh AND (P.Makhachle != '' or P.Makhachle != null);
    SELECT COUNT(*) INTO TongSoKhachDoan FROM khachdoangomkhachle K, PhieuDangky P WHERE K.Madoan = P.Makhachdoan AND P.Matour = matour AND P.Ngaykhoihanh = ngaykhoihanh;

    RETURN TongSoKhachLe + TongSoKhachDoan;
END;
// DELIMITER ;


-- 2
DELIMITER //
CREATE FUNCTION MotaHD (loai char(1))
RETURNS varchar(100)
BEGIN
	DECLARE result varchar(100);
    if loai = '1' then
		set result = 'Khởi hành tour';
	elseif loai = '2' then
		set result = 'Kết thúc tour';
	elseif loai = '3' then
		set result = 'Ăn sáng';
	elseif loai = '4' then
		set result = 'Ăn trưa';
	elseif loai = '5' then
		set result = 'Ăn tối';
	elseif loai = '6' then
		set result = 'Check in';
	elseif loai = '7' then
		set result = 'Check out';
	elseif loai = '8' then
		set result = 'Vận chuyển';
	else 
		set result = '';
	end if;
    RETURN result;
END;
// DELIMITER ;

DELIMITER //

CREATE procedure InLichTrinhChuyenDi (matour varchar(11), ngaykhoihanh date)
BEGIN
	create view temp as select L.*, D.Loai, D.Madonvi
    from LichTrinhChuyen L
    left outer join DVCCDVChuyen D 
    on L.Matour = D.Matour and L.Ngaykhoihanh = D.Ngaykhoihanh and L.STTngay = D.STTngay;

    
    create view temp2 as select temp.*, Giobatdau, Gioketthuc from temp left outer join HanhDongLichtrinhtour 
    on temp.Loai = HanhDongLichtrinhtour.Loaihanhdong and temp.Matour = HanhDongLichtrinhtour.Matour 
	and temp.STTngay = HanhDongLichtrinhtour.STTngay;
	
    create view temp3 as select temp2.Matour, temp2.Ngaykhoihanh, temp2.STTngay, temp2.Giobatdau, temp2.Gioketthuc, concat(MotaHD(temp2.Loai),' tại ', if(temp2.Loai = '1' or temp2.Loai = '2',TOUR.Machinhanh, Tendonvi)) Mota 
    from temp2, DonViCungCapDV, TOUR where temp2.Madonvi = DonViCungCapDV.Madonvi and temp2.Matour = TOUR.Matour;
	
    create view temp4 as select LichTrinhChuyen.*, Thoigianbatdau as Giobatdau, Thoigianketthuc as Gioketthuc, concat('Tham quan tại ',DiemDuLich.Tendiem) Mota 
    from TourGomDDTQ, LichTrinhChuyen, DiemDuLich,TOUR 
    where TourGomDDTQ.Matour = LichTrinhChuyen.Matour 
    and TourGomDDTQ.STTngay = LichTrinhChuyen.STTngay and TourGomDDTQ.Madiemdulich = DiemDuLich.Madiem
    union select * from temp3;
    select * from temp4 where matour = temp4.Matour and temp4.Ngaykhoihanh = ngaykhoihanh order by STTngay, Giobatdau;
    drop view temp;
    drop view temp2;
    drop view temp3;
    drop view temp4;
END;
// DELIMITER ;

-- 3

DELIMITER //
 CREATE PROCEDURE ThongKeDoanhThu (nam YEAR)
 BEGIN 
	DECLARE x INT DEFAULT 0;
    DECLARE tongtien DECIMAL(10,0);
    SET x = 1;
    
    CREATE TABLE Thongke (Thang int NOT NULL, TongDoanhThu DECIMAL(10,0));
    
    WHILE x <= 12 DO
          SET tongtien = (SELECT SUM(Tonggia) FROM ChuyenDi WHERE YEAR(Ngaykhoihanh) = nam AND MONTH(Ngaykhoihanh) = x);
          INSERT INTO Thongke VALUES (x, tongtien);
          SET x = x + 1;
	END WHILE;
    SELECT * FROM Thongke;
    DROP TABLE Thongke;
 END;
 // DELIMITER ;
 


-- trigger
	-- Viết trigger cập nhật giá trị cho thuộc tính dẫn xuất tổng giá (tổng doanh thu) của bảng 16 khi insert hoặc delete một phiếu đăng ký. (1đ)
DELIMITER //
CREATE TRIGGER UpdateTonggia_insert
AFTER INSERT ON PhieuDangky
FOR EACH ROW
BEGIN
	DECLARE tonggia decimal(10,0);
    
    SET tonggia = (SELECT C.Tonggia FROM ChuyenDi C WHERE C.Matour = NEW.Matour AND C.Ngaykhoihanh = NEW.Ngaykhoihanh); 
    
    IF NEW.Makhachle != '' THEN
		IF YEAR(curdate()) - Year((SELECT K.Ngaysinh FROM KhachHang K WHERE K.MaKhachHang = NEW.Makhachle )) > 10 THEN
			SET tonggia = tonggia +  (SELECT T.Giavelenguoilon  FROM TOUR T WHERE T.Matour = New.Matour);
		ELSE 
			SET tonggia = tonggia + (SELECT T.Giaveletreem   FROM TOUR T WHERE T.Matour = New.Matour);
		END IF ;
	ELSE
		SET tonggia =  tonggia +  (SELECT T.Giavedoannguoilon FROM TOUR T WHERE T.Matour = New.Matour)*(SELECT COUNT(*) FROM KhachDoanGomKhachLe KG, KhachHang KH WHERE KG.Madoan = NEW.Makhachdoan AND KG.Makhachhang = KH.MaKhachHang AND YEAR(now()) - Year(KH.Ngaysinh) > 10)
                      + (SELECT T.Giavedoantreem FROM TOUR T WHERE T.Matour = New.Matour)*(SELECT COUNT(*) FROM KhachDoanGomKhachLe KG, KhachHang KH WHERE KG.Madoan = NEW.Makhachdoan AND KG.Makhachhang = KH.MaKhachHang AND YEAR(now()) - Year(KH.Ngaysinh) <= 10) ;
	END IF;
    
    UPDATE ChuyenDi C SET C.Tonggia = tonggia WHERE C.Matour = New.Matour AND C.Ngaykhoihanh = New.Ngaykhoihanh;
END ;

// DELIMITER ;
	

DELIMITER //
CREATE TRIGGER UpdateTonggia_delete 
AFTER DELETE ON PhieuDangky
FOR EACH ROW
BEGIN
	DECLARE tonggia decimal(10,0);
    
    SET tonggia = (SELECT C.Tonggia FROM ChuyenDi C WHERE C.Matour = OLD.Matour AND C.Ngaykhoihanh = OLD.Ngaykhoihanh); 
    IF OLD.Ngaykhoihanh > curdate() THEN
		IF OLD.Makhachle != '' THEN
			IF YEAR(curdate()) - Year((SELECT K.Ngaysinh FROM KhachHang K WHERE K.MaKhachHang = OLD.Makhachle )) > 10 THEN
				SET tonggia = tonggia -  (SELECT T.Giavelenguoilon  FROM TOUR T WHERE T.Matour = OLD.Matour);
			ELSE 
				SET tonggia = tonggia - (SELECT T.Giaveletreem FROM TOUR T WHERE T.Matour = OLD.Matour);
			END IF ;
		ELSE
			SET tonggia =  tonggia -  (SELECT T.Giavedoannguoilon FROM TOUR T WHERE T.Matour = OLD.Matour)*(SELECT COUNT(*) FROM KhachDoanGomKhachLe KG, KhachHang KH WHERE KG.Madoan = OLD.Makhachdoan AND KG.Makhachhang = KH.MaKhachHang AND YEAR(now()) - Year(KH.Ngaysinh) > 10)
						  - (SELECT T.Giavedoantreem FROM TOUR T WHERE T.Matour = OLD.Matour)*(SELECT COUNT(*) FROM KhachDoanGomKhachLe KG, KhachHang KH WHERE KG.Madoan = OLD.Makhachdoan AND KG.Makhachhang = KH.MaKhachHang AND YEAR(now()) - Year(KH.Ngaysinh) <= 10) ;
		END IF;
	END IF ;
    
    UPDATE ChuyenDi C SET C.Tonggia = tonggia WHERE C.Matour = OLD.Matour AND C.Ngaykhoihanh = OLD.Ngaykhoihanh;
END ;

// DELIMITER ;






	-- Khi thêm một lịch trình chuyến (bảng 18), phải tồn tại lịch trình này trong tour (bảng 13). Ví dụ: thêm một lịch trình chuyến (CN1-000001, 01/01/2023, 2), thì tour CN1-000001 phải có lịch trình cho ngày 2.
DELIMITER //
CREATE TRIGGER CheckInsertLichTrinhChuyen
BEFORE INSERT ON LichTrinhChuyen
FOR EACH ROW
BEGIN
	if not exists (select * from Lichtrinhtour where NEW.Matour = Lichtrinhtour.Matour) then
		SIGNAL SQLSTATE '45000'   
        SET MESSAGE_TEXT = 'Lịch trình chuyến bạn đã thêm vào có mã tour không tìm thấy.';
	elseif not exists (select * from Lichtrinhtour where NEW.Matour = Lichtrinhtour.Matour and NEW.STTngay = Lichtrinhtour.STTngay) then
		SIGNAL SQLSTATE '45001'   
        SET MESSAGE_TEXT = 'Lịch trình chuyến bạn thêm vào có STT Ngày không đúng với Lịch trình tour.';
	end if;
END ;

// DELIMITER ;

	-- Khi thêm một đơn vị cung cấp vận chuyển cho chuyến đi (bảng 19), phải tồn tại loại hoạt động này trong lịch trình tour (bảng 15), ngoại trừ loại hình vận chuyển
DELIMITER //
CREATE TRIGGER CheckInsertDVCCDVChuyen
BEFORE INSERT ON DVCCDVChuyen
FOR EACH ROW
BEGIN
	if not exists (select * from HanhDongLichtrinhtour where NEW.Matour = HanhDongLichtrinhtour.Matour) then
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'DDCCDVChuyen có mã tour không tìm thấy.';
	elseif not exists (select * from HanhDongLichtrinhtour 
    where NEW.Matour = HanhDongLichtrinhtour.Matour 
    and NEW.STTngay = HanhDongLichtrinhtour.STTngay) then
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'DVCCDVChuyen bạn thêm vào có STT Ngày không đúng với Hành động Lịch trình tour.';
    elseif NEW.Loai != '8' and not exists (select * from HanhDongLichtrinhtour 
    where NEW.Matour = HanhDongLichtrinhtour.Matour 
    and NEW.STTngay = HanhDongLichtrinhtour.STTngay
    and NEW.Loai = HanhDongLichtrinhtour.Loaihanhdong) then
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'DVCCDVChuyen bạn thêm vào có Loại không đúng với Hành động Lịch trình tour.';
	end if;
END ;

// DELIMITER ;



SET foreign_key_checks=0;

-- insert into ChiNhanh
INSERT INTO ChiNhanh values ('','Hùng Vương', 'Miền Nam', '168 Hùng Vương, Quận 5 TP.HCM', 'hungvuongmiennam@tourist.com', '0912543232', 'VP0101'),
							('','Thích Quảng Đức', 'Miền Nam', '48 Thích Quảng Đức, Quận Gò Vấp, TP.HCM', 'thichquangduc@tourist.com', '0911324551', 'VP0251'),
							('','Tạ Quang Bửu', 'Miền Nam', '156A Tạ Quang Bửu, Thủ Đức, TP.HCM', 'tqbmiennam@tourist.com', '0914223434', 'VP0044'),
                            ('','Hai Bà Trưng', 'Miền Bắc', '13 Phố Hai Bà Trưng, Quận Hoàn Kiếm, TP. Hà Nội', 'haibatrung@tourist.com', '0912994564', 'VP0201');

SET foreign_key_checks=1;

-- insert into NhanVien
INSERT INTO NhanVien
VALUES
    ('VP0101', '123456789012', 'Nguyễn Văn An', '21 Hùng Vương, Quận 5, TP.HCM', 'M', '1990-01-01', '1', 'Trưởng phòng quản lý nhân sự', 'CN1'),
    ('HD1012', '123456789013', 'Trần Thị Bích Phụng', 'Quận Cầu Giấy, TP.Hà Nội', 'F', '1991-02-02', '2', 'Hướng dẫn viên di tích', 'CN4'),
    ('VP0201', '123456743314', 'Lê Văn Châu', 'Quận Long Biên, TP.Hà Nội', 'M', '1992-07-03', '1', 'Trưởng phòng kế hoạch', 'CN4'),
    ('VP0251', '123456789015', 'Phạm Thị Diễm Thuý', '13 Lý Thường Kiệt, Quận Tân Bình, TP.HCM ', 'F', '1993-04-17', '1', 'Trưởng phòng quản lý hoạt động', 'CN2'),
    ('VP0044', '123456789016', 'Hoàng Văn Em', 'Khu Phố 6, Linh Trung, Thủ Đức, TP.HCM', 'M', '1994-05-25', '1', 'Trưởng phòng tài chính kế toáns', 'CN3'),
    ('HD0016', '123456789017', 'Ngô Thị Phi Anh', '167A Lý Thường Kiệt, Quận 10, TP.HCM', 'F', '1995-06-13', '2', 'Hướng dẫn viên trưởng', 'CN1'),
    ('HD0077', '123456789018', 'Trương Văn Giang','Trung Kính, Cầu Giấy, TP.Hà Nội','M','1996-07-27','2','Hướng dẫn viên tập sự','CN4'),
    ('VP0108','123456789019','Đỗ Thị Huyền Trân','143A Thích Quảng Đức, Quận Phú Nhuận, TP.HCM','F','1997-08-18','2','Hướng dẫn viên du lịch','CN2'),
    ('VP0119','123456789020','Lý Văn Minh','19A Lê Văn Việt, Quận 9, TP.HCM','M','1998-09-29','1','Nhân viên','CN3'),
    ('HD1011','123456789021','Dương Thị An','112A Đông Hoà, Dĩ An, Bình Dương','F','1999-10-4','2','Hướng dẫn viên du lịch','CN1');


-- insert into SDT_ChiNhanh
INSERT INTO SDT_CN (MaCN, SDT)
VALUES
    ('CN1', '0123456789'),
    ('CN1', '0987654321'),
    ('CN2', '0123456789'),
    ('CN2', '0987654321'),
    ('CN3', '0123456789'),
    ('CN3', '0987654321'),
    ('CN4', '0123456789'),
    ('CN4', '0987654321');
    
-- insert into NgoaiNguNV
INSERT INTO NgoaiNguNV (MaNV, NgoaiNgu)
VALUES
    ('HD0016', 'Tiếng Anh'),
    ('HD0077', 'Tiếng Pháp'),
    ('HD1011', 'Tiếng Trung'),
    ('HD1012', 'Tiếng Nhật'),
    ('HD0016', 'Tiếng Đức'),
    ('HD0077', 'Tiếng Anh'),
    ('HD1011', 'Tiếng Anh'),
    ('HD1012', 'Tiếng Nga');
-- insert into KyNangNV
INSERT INTO KyNangNV (MaNV, KyNang)
VALUES
    ('HD0016', 'Giọng nói hay'),
    ('HD0077', 'Nói lưu loát'),
    ('HD1011', 'Lịch sử'),
    ('HD1012', 'Văn hoá'),
    ('HD1012', 'Nói lưu loát'),
    ('HD1011', 'Địa lý'),
    ('HD1011', 'Quản lý task');


-- insert into DiemDuLich


INSERT INTO DiemDuLich (Tendiem, Diachi, PhuongXa, QuanHuyen, TinhThanh, Anh1, Anh2, Anh3, Mota, Ghichu)
VALUES
    ('Dinh Độc Lập', '135 Nam Kỳ khởi nghĩa', 'Phường Bến Thành', 'Quận 1', 'TP.HCM', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/20190923_Independence_Palace-10.jpg/1280px-20190923_Independence_Palace-10.jpg', 'https://m.baotuyenquang.com.vn/media/images/2020/04/img_20200428091327.jpg', 'https://dinhdoclap.gov.vn/wp-content/uploads/2018/05/dinh-tu-tren-cao.jpg', 'Dinh Độc Lập là một tòa dinh thự tại Thành phố Hồ Chí Minh, từng là nơi ở và làm việc của Tổng thống Việt Nam Cộng hòa trước Sự kiện 30 tháng 4 năm 1975.', ''),
    ('Thác nước Datanla', 'QL20 Đèo Prenn', 'Phường 3', 'Thành phố Đà Lạt', 'Lâm Đồng', 'https://upload.wikimedia.org/wikipedia/commons/0/02/Th%C3%A1c_Datanla.jpg', 'https://dalat-info.gov.vn:444/uploads/20220920084334thac%20datanla.jpg', 'https://2trip.vn/wp-content/uploads/2020/10/khu-du-lich-thac-datanla-da-lat-1.jpg', 'Đatanla hay Datanla là thác ở thành phố Đà Lạt tỉnh Lâm Đồng, Việt Nam. Thác nằm trong khu du lịch Đatanla, cách thác Prenn 8 km và thành phố Đà Lạt 10 km và là điểm tham quan, phiêu lưu mạo hiểm.', ''),
    ('Chợ Đêm Đà Lạt', '6b Đường Nguyễn Thị Minh Khai', 'Phường 1', 'Thành phố Đà Lạt', 'Lâm Đồng', 'https://owa.bestprice.vn/images/articles/uploads/cap-nhat-cho-dem-da-lat-o-duong-nao-co-gi-thu-vi-5f3aafca8812e.jpg', '', '', 'Khu chợ tấp nập các quầy hàng bán đồ gia dụng, đồ khô và món ăn địa phương chế biến sẵn.', ''),
    ('Đảo Phú Quốc', '', '', 'Thành phố Phú Quốc', 'Kiên Giang', null, null, null, 'Không phải ngẫu nhiên mà hòn ngọc Phú Quốc được mệnh danh là thiên đường du lịch. Du lịch Phú Quốc nổi tiếng với những bãi biển đẹp, hoang sơ và các điểm vui chơi hấp dẫn.', ''),
    ('Tháp bà Ponagar', '61 Hai Tháng Tư', 'Vĩnh Phước', 'Nha Trang', 'Khánh Hoà', 'https://statics.vinpearl.com/thap-ba-ponagar-nha-trang-1_1625539421.jpg', null, null, 'Yang Po Inư Nagar hay Yang Pô Ana Gar là ngôi đền Chăm Pa nằm trên đỉnh một ngọn đồi nhỏ cao khoảng 10-12 mét so với mực nước biển, ở cửa sông Cái tại Nha Trang, cách trung tâm thành phố khoảng 2 km về phía bắc, nay thuộc phường Vĩnh Phước.', ''),
    ('Núi Cấm', '', 'xã An Hảo', 'Thị xã Tịnh Biên', 'An Giang', 'https://thamhiemmekong.com/wp-content/uploads/2019/09/nui-cam-5.jpg', null, null, 'Vùng núi yên bình có những con đường đi bộ, hồ nước, tòa bảo tháp cổ và tượng Phật lớn trong chùa.', ''),
	('Hồ Ô Thum', '', 'xã Ô Lâm', 'Huyện Tri Tôn', 'An Giang', 'https://thamhiemmekong.com/wp-content/uploads/2020/06/hoothum-2.jpg', null, null, 'Không chỉ đình đám với cảnh núi non hoang sơ, cao thượng cùng các địa điểm du lịch tâm linh đình đám, vùng đất Bảy Núi – An Giang còn sống sót nhiều hồ nước tuyệt đẹp hấp dẫn rất nhiều du khách du lịch như: Soài So, Soài Chek, Tà Pạ, Ô Thum, Ô Tà Sóc (Tri Tôn), Ô Tức Sa, Thủy Liêm, Thanh Long (Tịnh Biên). Trong đó Hồ Ô Thum với cảnh quan sơn thủy hữu tình là nơi đến chọn lựa lý tưởng cho các ai yêu mến sự yên tĩnh của núi rừng.', ''),
	('Rừng Tràm Trà Sư', 'Ấp Văn Trà', 'xã Văn Giáo', 'Thị xã Tịnh Biên', 'An Giang', 'https://ik.imagekit.io/tvlk/blog/2017/08/dam-chim-trong-khong-gian-xanh-muot-mat-cua-rung-tram-tra-su-1.png?tr=dpr-2,w-675', 'https://statics.vntrip.vn/data-v2/data-guide/img_content/1473910066_rung-tram-tra-su-an-giang-5.jpg', null, 'Đây là rừng ngập nước tiêu biểu cho vùng Tây sông Hậu, là nơi sinh sống của nhiều loài động vật và thực vật thuộc hệ thống rừng đặc dụng Việt Nam', ''),
    ('Đỉnh Lang Biang', '2CWR+M3W', 'Thị trấn Lạc Dương', 'Huyện Lạc Dương', 'Lâm Đồng', 'https://6f3ebe2ff971707.cmccloud.com.vn/tour/wp-content/uploads/2021/12/langbiang.jpg', 'https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2017/09/langbiang-1.jpg', null, 'Núi Langbiang là một cụm núi cao nằm cách thành phố Đà Lạt 12 km thuộc địa phận huyện Lạc Dương. Hai núi cao nhất tại đây là núi Bà cao 2.167 m và núi Ông cao 2.124 m so với mặt nước biển. Ngoài ra trong khu du lịch còn có ngọn đồi Ra-đa cao 1.929 m, ngọn đồi này cũng là một địa điểm quen thuộc đối với du khách.', ''),
    ('Thung Lũng Tình Yêu', '5 - 7 Đường Mai Anh Đào', 'Phường 8', 'Thành phố Đà Lạt', 'Lâm Đồng', 'https://lh3.googleusercontent.com/p/AF1QipODZ9fKbhCkqO5cqMHCudEUObblMlT9xdtv5-C8=s1360-w1360-h1020', null, null, 'Thung Lũng Tình Yêu là một trong những thắng cảnh thơ mộng nhất tại Đà Lạt, cách trung tâm thành phố khoảng 5 km về phía bắc. Đó là nơi đập Đa Thiện quy tụ những dòng suối nhỏ chảy từ đồi núi cao, thành hồ Đa Thiện trong vắt uốn quanh thung lũng rợp bóng thông xanh.', ''),
    ('Thiền Viện Trúc Lâm', 'WC3M+FQ9, Hoa Cẩm Tú Cầu', 'Phường 3', 'Thành phố Đà Lạt', 'Lâm Đồng', 'https://happydaytravel.com/wp-content/uploads/2019/01/thien-vien-truc-lam-da-lat-3.jpg', 'https://luhanhvietnam.com.vn/du-lich/vnt_upload/news/01_2020/thien-vien-truc-lam-da-lat-11.jpg', null, 'Thiền viện Trúc Lâm Đà Lạt là thiền viện thuộc thiền phái Trúc Lâm Yên Tử. Thiền viện cách trung tâm thành phố Đà Lạt 5 km, nằm trên núi Phụng Hoàng, phía trên Hồ Tuyền Lâm. Đây không chỉ là thiền viện lớn nhất Lâm Đồng mà còn là điểm tham quan và chiêm bái của nhiều du khách trong và ngoài nước.', ''),
    ('Bảo Tàng Hải Dương Học', 'Số 1', 'Cầu Đá', 'Nha Trang', 'Khánh Hoà', null, null, null, 'Viện Hải dương học là một viện nghiên cứu đời sống động - thực vật hải dương tại thành phố Nha Trang, tỉnh Khánh Hòa. Viện Hải dương học là một trong những cơ sở nghiên cứu khoa học được ra đời sớm nhất ở Việt Nam và được coi là cơ sở lưu trữ hiện vật và nghiên cứu về biển lớn nhất Đông Nam Á.', ''),
	('Chùa Long Sơn', 'Số 22 Đường 23 Tháng 10', 'Phường Phương Sơn', 'Nha Trang', 'Khánh Hoà', 'https://statics.vinpearl.com/chua-long-son-1_1627636381.png', null, null, 'Chùa Long Sơn được biết tới là ngôi cổ tự lâu đời tại Nha Trang. Nơi đây sở hữu bức tượng Phật Tổ ngoài trời lớn nhất được ghi tên vào sách kỷ lục Guiness Việt Nam. Địa điểm này thu hút rất nhiều khách du lịch ghé thăm trong chuyến du lịch Nha Trang.', ''),
    ('Bán Đảo Sơn Trà', '', 'phường Thọ Quang', 'quận Sơn Trà', 'Tp. Đà Nẵng', 'https://ik.imagekit.io/tvlk/blog/2022/09/ban-dao-son-tra-2-1024x576.png?tr=dpr-2,w-675', NULL, NULL, 'Xưa kia, đây là đảo nổi được hợp thành bởi 3 ngọn núi. Theo thời gian, nước biển mang phù sa bồi đắp tạo thành 1 dải đất nối liền đảo và đất liền và hình thành bán đảo Sơn Trà. Nơi đây có 3 mặt giáp biển, 1 mặt giáp đô thị và chỉ cách trung tâm thành phố khoảng 10km.', NULL),
	('Linh Ứng Tự', 'khu vực Bãi Bụt', 'phường Thọ Quang', 'quận Sơn Trà', 'TP. Đà Nẵng', 'https://greentour.vn/wp-content/uploads/2023/02/str.png', NULL, NULL, 'Chùa Linh Ứng Bãi Bụt Đà Nẵng nằm tựa lưng vào đỉnh núi Sơn Trà. Chùa Linh Ứng Bãi Bụt được xây dựng từ năm 2004 và là công trình kiến trúc mang giá trị văn hóa – nghệ thuật của thành phố biển.', NULL),
	('Phố cổ Hội An', '', '', 'Hội An', 'Quảng Nam', 'https://vcdn1-dulich.vnecdn.net/2022/06/01/Hoi-An-VnExpress-5851-16488048-4863-2250-1654057244.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=Z2ea_f0O7kgGZllKmJF92g', 'https://statics.vinpearl.com/kien-truc-pho-co-hoi-an-2_1665128843.jpg', 'https://sakos.vn/wp-content/uploads/2023/04/znews-photo.zingcdn.me-uploaded-lce_mdlwc-2022_12_28-_14_zing-1.jpg', 'Phố cổ Hội An từng là một thương cảng quốc tế sầm uất, gồm những di sản kiến trúc đã có từ hàng trăm năm trước, được UNESCO công nhận là di sản văn hóa thế giới từ năm 1999.', NULL),
	('Khu du lịch Bà Nà', '', 'Hoà Ninh', 'Hòa Vang', 'Đà Nẵng', 'https://nld.mediacdn.vn/2020/9/20/ba-na-mo-cua-tro-lai-10-16005678342571877068250.jpg', 'https://banahills.sunworld.vn/wp-content/uploads/2020/03/L%C3%A0ng-ph%C3%A1p-6-1024x737.jpg', 'https://sungroupland.vn/upfiles/image/tin-tuc/sun-world-ba-na-hills(1).jpg', 'Bà Nà là khu bảo tồn thiên nhiên đồng thời là quần thể du lịch nghỉ dưỡng toạ lạc tại khu vực thuộc dãy Trường Sơn nằm ở xã Hoà Ninh, Huyện Hòa Vang, cách trung tâm Đà Nẵng khoảng 25km về phía Tây Nam. Toàn bộ quần thể du lịch nghỉ dưỡng nằm trên đỉnh Núi Chúa có độ cao 1487 m so với mực nước biển.', NULL),
	('Chùa Thiên Mụ', 'ngọn đồi Hạ Khuê', 'phường Kim Long', 'TP Huế', 'tỉnh Thừa Thiên Huế', 'https://phuhoi.thuathienhue.gov.vn/UploadFiles/TinTuc/2014/7/12/chuathienmuvietnam3.jpg', 'https://hidicar.com/wp-content/uploads/2019/05/kham-pha-chiec-o-to-dac-biet-o-chua-thien-mu-hue-152155.jpg', NULL, 'Chùa Thiên Mụ hay còn gọi là chùa Linh Mụ là một ngôi chùa cổ nằm trên đồi Hà Khê, tả ngạn sông Hương, cách trung tâm thành phố Huế (Việt Nam) khoảng 5 km về phía tây. Chùa Thiên Mụ chính thức khởi lập năm Tân Sửu (1601), đời chúa Tiên Nguyễn Hoàng - vị chúa Nguyễn đầu tiên ở Đàng Trong.', NULL),
	('Kinh Thành Huế', '', NULL, 'TP Huế', 'Thừa Thiên Huế', 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Ngomon2.jpg/640px-Ngomon2.jpg', 'https://media.vneconomy.vn/images/upload/2022/01/19/photo1553651951883-1553651952289-crop-15536519959541262047072.jpg', NULL, 'Kinh thành Huế là một di sản văn hóa thế giới UNESCO nằm tại Thành phố Huế, tỉnh Thừa Thiên Huế, Việt Nam. Kinh thành là một phần của Hoàng thành Huế, nơi đặt trụ sở của triều đại nhà Nguyễn, từ năm 1802 đến năm 1945. Kinh thành bao gồm các công trình chính như cửa chính, cung điện, đình, đài, đình, điện, hầm... được bảo tồn và phục hồi để giữ gìn giá trị lịch sử và văn hóa của Việt Nam.', NULL),
    ('Động Thiên Đường', '', 'thị trấn Phong Nha', 'huyện Bố Trạch', 'tỉnh Quảng Bình', 'https://phongnhaexplorer.com/wp-content/uploads/Tour-Dong-Thien-Duong.jpg', NULL, NULL, 'Động Thiên Đường là một trong những điểm đến thu hút nhất vào mùa hè. Lý do không chỉ nằm ở vẻ đẹp thần tiên nơi đây cất giữ, mà còn vì hệ sinh thái tươi xanh, mát mẻ. Rất nhiều người coi đây như một “nơi trốn” để tìm về mỗi khi mệt mỏi, muốn tránh xa thị phi, xô bồ nơi phố thị.', NULL),
	('Động Phong Nha', '', 'xã Sơn Trạch', 'huyện Bố Trạch', 'tỉnh Quảng Bình', 'https://statics.vinpearl.com/dong-phong-nha-0_1624024966.jpg', NULL, NULL, 'Động Phong Nha là điểm đến hấp dẫn mà mọi tín đồ đam mê khám phá không nên bỏ lỡ. Tại đây, bạn không chỉ được hòa mình vào thiên nhiên non nước hữu tình, đẹp như tranh vẽ mà còn được tận mắt khám phá bàn tay kỳ diệu của tạo hóa từ thuở xa xưa.', NULL),
	('Lăng Tự Đức', 'thôn Thượng Ba', 'phường Thủy Xuân', 'thành phố Huế', 'tỉnh Thừa Thiên Huế', 'https://khamphahue.com.vn/Portals/0/Medias/Nam2022/T10/Khamphahue_LangTamHue_LangVuaTuDuc-daidien.jpg', NULL, NULL, 'Lăng Tự Đức là công trình lăng tẩm ấn tượng bậc nhất xứ Huế. Nằm yên bình tại vị trí núi non trùng điệp, địa điểm này sẽ mang lại nhiều trải nghiệm thú vị cho du khách.', NULL),
	('Lăng Bác', '2 Hùng Vương', 'Điện Biên', 'Ba Đình', 'Hà Nội', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/L%C4%83ng_B%C3%A1c_-_NKS.jpg/1200px-L%C4%83ng_B%C3%A1c_-_NKS.jpg', 'https://statics.vinpearl.com/lang-chu-tich-ho-chi-minh-1_1685366034.jpg', NULL, 'Lăng Chủ tịch Hồ Chí Minh là nơi lưu giữ di hài của Bác và là điểm đến mà mỗi thế hệ người Việt đều mong mỏi viếng thăm để bày tỏ tình cảm và lòng biết ơn sâu sắc dành cho vị cha già dân tộc.', NULL),
	('Chùa Một Cột', 'phố Chùa Một Cột', 'phường Đội Cấn', 'quận Ba Đình', 'thành phố Hà Nội', 'https://ik.imagekit.io/tvlk/blog/2022/09/chua-mot-cot-1.jpg?tr=dpr-2,w-675', NULL, NULL, 'Chùa Một Cột là một trong những ngôi chùa có kiến trúc độc đáo nhất tại Châu Á, là biểu tượng văn hoá và điểm đến tâm linh ở Thủ đô Hà Nội.', NULL),
	('Văn Miếu Quốc Tử Giám', '58 P. Quốc Tử Giám', 'Văn Miếu', 'Đống Đa', 'Hà Nội', 'https://upload.wikimedia.org/wikipedia/commons/3/39/Hanoi_Temple_of_Literature_%28cropped%29.jpg', 'https://phanvienmiennam.amc.edu.vn/upload/images/1408_image001.png', 'https://ik.imagekit.io/tvlk/blog/2022/11/go-and-share-van-mieu-quoc-tu-giam-ha-noi-2-841x1024.jpg?tr=dpr-2,w-675', 'Văn Miếu – Quốc Tử Giám là quần thể di tích đa dạng, phong phú hàng đầu của thành phố Hà Nội, nằm ở phía Nam kinh thành Thăng Long.', NULL),
	('Bản Cát Cát', '', 'Xã Hoàng Liên', 'thị xã Sa Pa', 'tỉnh Lào Cai', 'https://ik.imagekit.io/tvlk/blog/2023/03/ban-cat-cat-3.jpg?tr=dpr-2,w-675', NULL, NULL, 'Bản Cát Cát từ lâu đã nức tiếng trong lòng những vị khách ghé thăm Sapa với vẻ ngoài mộc mạc được tô điểm thêm sống động cùng nét văn hóa và trang phục truyền thống của người dân tộc H’mông nơi đây.', NULL),
	('Khu du lịch Tam Chúc', '', 'xã Ba Sao', 'huyện Kim Bảng', 'tỉnh Hà Nam', 'https://cdn.vietnambiz.vn/stores/news_dataimages/loihh/022019/09/18/2731_A6.jpg', NULL, NULL, 'Khu tâm linh Tam Chúc (huyện Kim Bảng) hiện đang dần hoàn thiện với kiến trúc cổ truyền Việt Nam hòa trộn mảng màu văn hóa qua kỹ nghệ chế tác phù điêu, xây dựng các công trình Phật giáo của các nghệ nhân Indonesia và Ấn Độ. Và nơi đây năm 2019 được chọn làm địa điểm tổ chức Đại lễ Vesak Liên Hợp quốc.', NULL),
	('Quần thể danh thắng Tràng An', '', NULL, NULL, 'Ninh Bình', 'https://hutc.org/files/thumb/500/261//uploads//Resource/Quan-the-trang-an.jpg.jpg', 'https://ik.imagekit.io/tvlk/blog/2022/11/khu-du-lich-trang-an-2.jpg?tr=dpr-2,w-675', NULL, 'Quần thể danh thắng Tràng An là một vùng du lịch tổng hợp gồm các di sản văn hóa và thiên nhiên thế giới do UNESCO công nhận ở Ninh Bình, Việt Nam.', NULL),
	('Vịnh Hạ Long', 'khu vực biển Đông Bắc Việt Nam', NULL, NULL, 'Tỉnh Quảng Ninh', 'https://ik.imagekit.io/tvlk/blog/2022/10/kinh-nghiem-du-lich-vinh-ha-long-1.jpg?tr=dpr-2,w-675', 'https://ik.imagekit.io/tvlk/blog/2022/10/kinh-nghiem-du-lich-vinh-ha-long-5.jpg?tr=dpr-2,w-675', 'https://statics.vinpearl.com/du-lich-vinh-Ha-Long-hinh-anh3_1625912082.jpg', 'Nổi tiếng với phong cảnh thiên nhiên độc đáo giữa biển khơi mênh mông, du lịch vịnh Hạ Long vì thế mà trở thành địa điểm tham quan tuyệt đẹp xuất hiện liên tục trên các mặt báo, các trang mạng xã hội. Không những thế, nơi đây còn có nền ẩm thực phong phú, mang đến nhiều trải nghiệm lý thú cho du khách tham quan.', NULL);

-- insert khachhang
INSERT INTO KhachHang VALUES 
('KH0001', '025874136945', 'Nguyễn Minh Kha', 'kha12@gmail.com','0357598123','2000-06-01','Cà Mau'),
('KH0002', '123456789', 'Nguyễn Văn An', 'nguyenvanan@gmail.com', '0912345678', '1985-03-15', 'Số 1 Đường ABC, Quận 1, Thành phố Hồ Chí Minh'),
('KH0003', '987654321', 'Trần Thị Bình', 'tranthibinh@gmail.com', '0987654321', '1990-11-30', 'Số 2 Đường XYZ, Quận 2, Thành phố Hà Nội'),
('KH0004', '555555555', 'Lê Hoàng Long', 'lehoanglong@gmail.com', '0969696969', '1995-07-20', 'Số 3 Đường MNO, Quận 3, Thành phố Đà Nẵng'),
('KH0005', NULL, 'Vũ Minh Đức', NULL, NULL, '2010-06-10', 'Số 5 Đường GHI, Quận 5, Thành phố Hà Nội'),
('KH0006', NULL, 'Nguyễn Thị Mai', NULL, NULL, '2010-11-17', 'Số 6 Đường KLM, Quận 6, Thành phố Đà Nẵng'),
('KH0007', NULL, 'Trần Văn Hưng', NULL, NULL, '2012-04-22', 'Số 7 Đường OPQ, Quận 7, Thành phố Cần Thơ'),
('KH0008', NULL, 'Lê Thị Thùy Dung', NULL, NULL, '2012-09-05', 'Số 8 Đường STU, Quận 8, Thành phố Hải Phòng'),
('KH0009', NULL, 'Hoàng Văn Tùng', NULL, NULL, '2012-12-31', 'Số 9 Đường XYZ, Quận 9, Thành phố Hồ Chí Minh'),
('KH0010', NULL, 'Nguyễn Thị Hằng', NULL, NULL, '2013-09-15', 'Số 10 Đường ABC, Quận 10, Thành phố Hà Nội'),
('KH0011', NULL, 'Trần Văn Bình', NULL, NULL, '2015-06-22', 'Số 11 Đường DEF, Quận 11, Thành phố Đà Nẵng'),
('KH0012', NULL, 'Lê Thị Thu', NULL, NULL, '2015-11-05', 'Số 12 Đường GHI, Quận 12, Thành phố Cần Thơ'),
('KH0013', NULL, 'Vũ Minh Quang', NULL, NULL, '2013-12-31', 'Số 13 Đường MNO, Quận 13, Thành phố Hải Phòng'),
('KH0014', '123456789', 'Nguyễn Văn Điền', 'nguyenvandien@gmail.com', '0912345678', '1982-07-15', 'Hà Nội, Việt Nam'),
('KH0015', '987654321', 'Trần Thị Hạnh', 'tranthihanh@gmail.com', '0987654321', '1978-11-30', 'Hồ Chí Minh, Việt Nam'),
('KH0016', '654321987', 'Lê Hoàng Sơn', 'lehoangson@gmail.com', '0969696969', '2000-05-20', 'Đà Nẵng, Việt Nam'),
('KH0017', '321987654', 'Phạm Thị Thuỳ', 'phamthithuy@gmail.com', '0911111111', '1985-09-22', 'Hải Phòng, Việt Nam'),
('KH0018', '789456123', 'Vũ Minh Hạnh', 'vuminhhanh@gmail.com', '0977777777', '2003-05-16','Cần Thơ, Việt Nam'),
('KH0019', '456123789', 'Nguyễn Thị Lan', 'nguyenthilan@gmail.com', '0909090909','2002-05-17', 'Huế, Việt Nam'),
('KH0020', '963852741', 'Trần Văn Hiệp', 'tranvanhiep@gmail.com', '0922222222', '2001-02-02','Nha Trang, Việt Nam'),
('KH0021', '852741963', 'Lê Thị Thuận', 'lethithuan@gmail.com', '0933333333', '2001-04-16','Phú Quốc, Việt Nam'),
('KH0022', '147258369', 'Hoàng Văn Long', 'hoangvanlong@gmail.com', '0944444444', '2001-05-04','Quảng Ninh, Việt Nam'),
('KH0023', '369258147', 'Vũ Thị Quỳnh', 'vuthiquynh@gmail.com', '0955555555', '2005-03-16','Vũng Tàu, Việt Nam'),
 ('KH0024', '123456789', 'Nguyễn Minh Đức', 'nguyenminhduc@gmail.com', '0912345678', '1982-07-15', 'Hà Nội, Việt Nam'),
    ('KH0025', '987654321', 'Trần Thị Hương', 'tranthihuong@gmail.com', '0987654321', '1978-11-30', 'Hồ Chí Minh, Việt Nam'),
    ('KH0026', '654321987', 'Lê Hoàng Sơn', 'lehoangson@gmail.com', '0969696969', '2000-05-20', 'Đà Nẵng, Việt Nam'),
    ('KH0027', '321987654', 'Phạm Thị Lan', 'phamthilan@gmail.com', '0911111111', '1985-09-22', 'Hải Phòng, Việt Nam'),
    ('KH0028', '789456123', 'Vũ Minh Hà', 'vuminhha@gmail.com', '0977777777','2000-12-20', 'Cần Thơ, Việt Nam'),
    ('KH0029', '456123789', 'Nguyễn Thị Linh', 'nguyenthilinh@gmail.com', '0909090909', '2000-11-20','Huế, Việt Nam'),
    ('KH0030', '963852741', 'Trần Văn Hòa', 'tranvanhoa@gmail.com', '0922222222','2001-04-12', 'Nha Trang, Việt Nam'),
    ('KH0031', '852741963', 'Lê Thị Mai', 'lethimai@gmail.com', '0933333333', '2000-01-20','Phú Quốc, Việt Nam'),
    ('KH0032', '147258369', 'Hoàng Văn Quốc', 'hoangvanquoc@gmail.com', '0944444444', '2000-11-20','Quảng Ninh, Việt Nam'),
    ('KH0033', '369258147', 'Vũ Thị Thùy', 'vuthithuy@gmail.com', '0955555555', '2003-02-22','Vũng Tàu, Việt Nam'),
    ('KH0034', '258369147', 'Nguyễn Văn Tuấn', 'nguyenvantuan@gmail.com', '0966666666','2000-05-25', 'Hạ Long, Việt Nam'),
    ('KH0035', '147369258', 'Trần Thị Nga', 'tranthinga@gmail.com', '0977777777', '2003-09-02','Hội An, Việt Nam'),
    ('KH0036', '369147258', 'Lê Hoàng Nam', 'lehoangnam@gmail.com', '0988888888', '2003-09-11','Ninh Bình, Việt Nam'),
    ('KH0037', '123987456', 'Phạm Thị Hạnh', 'phamthihanh@gmail.com', '0999999999', '1999-09-13','Đà Lạt, Việt Nam'),
    ('KH0038', '789321654', 'Vũ Minh Hưng', 'vuminhhung@gmail.com', '0911111111', '1999-09-15','Buôn Ma Thuột, Việt Nam'),
    ('KH0039', '321789654', 'Nguyễn Thị Tâm', 'nguyenthitam@gmail.com', '0922222222', '1999-10-17','Hạ Tiên, Việt Nam'),
    ('KH0040', '147963852', 'Trần Văn Thành', 'tranvanthanh@gmail.com', '0933333333','2004-05-13', 'Cà Mau, Việt Nam'),
    ('KH0041', '963147852', 'Lê Thị Thu', 'lethithu@gmail.com', '0944444444', '2005-07-13','Mỹ Tho, Việt Nam'),
    ('KH0042', '852369741', 'Hoàng Văn Thông', 'hoangvanthong@gmail.com', '0955555555', '2006-09-15', 'Long Xuyên, Việt Nam'),
    ('KH0043', '369741852', 'Vũ Thị Trang', 'vuthitrang@gmail.com', '0966666666', '1999-04-05','Bắc Giang, Việt Nam'),
    ('KH0044', '741852963', 'Nguyễn Văn Tú', 'nguyenvantu@gmail.com', '0977777777', '1999-03-12', 'Quy Nhơn, Việt Nam'),
    ('KH0045', '852963741', 'Trần Thị Lệ', 'tranthile@gmail.com', '0988888888', '1998-07-13','Cần Giờ, Việt Nam'),
    ('KH0046', '963852741', 'Lê Hoàng Hà', 'lehoangha@gmail.com', '0999999999', '1997-05-18','Hạ Hòa, Việt Nam'),
    ('KH0047', '123456987', 'Phạm Thị Trinh', 'phamthitrinh@gmail.com', '0911111111', '1999-08-13','Hưng Yên, Việt Nam'),
    ('KH0048', '987654321', 'Vũ Minh Đan', 'vuminhdan@gmail.com', '0922222222', '2003-11-23','Cần Thơ, Việt Nam'),
    ('KH0049', '369852147', 'Nguyễn Thị Yến', 'nguyenthiyen@gmail.com', '0933333333', '2005-10-13', 'Hà Tĩnh, Việt Nam'),
    ('KH0050', '147963852', 'Trần Văn Lực', 'tranvanluc@gmail.com', '0944444444', '2004-09-26','Phan Thiết, Việt Nam');

-- insert into KhachHang
INSERT INTO KhachDoan VALUES ('KD0001', 'VietNam Co. Ltd.', 'vietnam01@gmail.com', '0912345678', 'Hanoi, VietNam', 'KH0024'),
    ('KD0002', 'VietNam Agency', 'vietnam02@gmail.com', '0987654321', 'Ho Chi Minh City, VietNam', 'KH0025'),
    ('KD0003', 'VietNam Group', 'vietnam03@gmail.com', '0977777777', 'Da Nang, VietNam', 'KH0026'),
    ('KD0004', 'VietNam Solutions', 'vietnam04@gmail.com', '0969696969', 'Hai Phong, VietNam', 'KH0027'),
    ('KD0005', 'VietNam Enterprises', 'vietnam05@gmail.com', '0911111111', 'Can Tho, VietNam', 'KH0028'),
    ('KD0006', 'VietNam Corporation', 'vietnam06@gmail.com', '0909090909', 'Hue, VietNam', 'KH0029'),
    ('KD0007', 'VietNam Services', 'vietnam07@gmail.com', '0922222222', 'Nha Trang, VietNam', 'KH0030'),
    ('KD0008', 'VietNam Industry', 'vietnam08@gmail.com', '0933333333', 'Vung Tau, VietNam', 'KH0031');
    
-- insert KHACHDOANGOMKHACHLE

INSERT INTO KhachDoanGomKhachLe VALUES  
('KD0001', 'KH0024'),
('KD0001', 'KH0001'),
('KD0001', 'KH0002'),
('KD0001', 'KH0005'),
('KD0001', 'KH0006'),
('KD0001', 'KH0039'),
('KD0002', 'KH0025'),
('KD0002', 'KH0003'),
('KD0002', 'KH0004'),
('KD0002', 'KH0007'),
('KD0002', 'KH0008'),
('KD0002', 'KH0040'),
('KD0003', 'KH0026'),
('KD0003', 'KH0009'),
('KD0003', 'KH0010'),
('KD0003', 'KH0011'),
('KD0003', 'KH0041'),
('KD0003', 'KH0032'),
('KD0004', 'KH0027'),
('KD0004', 'KH0017'),
('KD0004', 'KH0016'),
('KD0004', 'KH0033'),
('KD0004', 'KH0034'),
('KD0004', 'KH0035'),
('KD0005', 'KH0028'),
('KD0005', 'KH0036'),
('KD0005', 'KH0037'),
('KD0005', 'KH0038'),
('KD0005', 'KH0018'),
('KD0006', 'KH0029'),
('KD0006', 'KH0014'),
('KD0006', 'KH0015'),
('KD0006', 'KH0001'),
('KD0006', 'KH0002'),
('KD0007', 'KH0030'),
('KD0007', 'KH0012'),
('KD0007', 'KH0013'),
('KD0007', 'KH0019'),
('KD0007', 'KH0018'),
('KD0007', 'KH0016'),
('KD0007', 'KH0017'),
('KD0008', 'KH0031'),
('KD0008', 'KH0042'),
('KD0008', 'KH0040'),
('KD0008', 'KH0015'),
('KD0008', 'KH0014'),
('KD0008', 'KH0006'),
('KD0008', 'KH0007');





-- insert into TOUR	
insert into TOUR values ('','Ô Thum - Trà Sư','https://lh3.googleusercontent.com/p/AF1QipMpn7gXCq8JZe9LQ8je9bwUoWq90IzMgGPnVQNa=s1360-w1360-h1020', '2023-8-18',10,40,3000000,2500000,2500000,2000000,4,1,2,'CN4'),
						('', 'Dinh Độc Lập - Bảo tàng Hải Dương Học', 'https://www.dinhdoclap.gov.vn/wp-content/uploads/2018/05/dinh-tu-tren-cao.jpg', '2023-08-15', 10, 30, 600000, 400000, 500000, 300000, 4, 0, 1, 'CN1'),
						('','Nha Trang - Đà Lạt','https://sakos.vn/wp-content/uploads/2022/11/tour-can-tho-di-da-lat-bang-may-bay-2.jpg','2023-8-18',10,40,4000000,3500000,3500000,3000000,5,4,4,'CN3'),
                        ('','Nha Trang - Đà Lạt - Hồ Chí Minh','https://static.vinwonders.com/production/review-da-lat-1.jpg','2023-8-18',10,40,6000000,5500000,5000000,4000000,4,5,6,'CN4'),
                        ('', 'Đà Lạt', 'https://travelmedia.com.vn/wp-content/uploads/2023/05/Tour-du-li%CC%A3ch-Da%CC%80-La%CC%A3t-_-Du-li%CC%A3ch-Lion-Trip.png', '2023-08-20', 15, 40, 2500000, 1500000, 2000000, 1000000, 5, 2, 3, 'CN1'),
                        ('','Rừng Tràm Trà Sư - Núi Cấm - Ô Thum','https://thamhiemmekong.com/wp-content/uploads/2019/09/nui-cam01.jpg','2023-08-25',5 ,40,3500000 ,2500000 ,3000000 ,2000000 ,3,3 ,4 ,'CN2'),
                        ('','Đà Nẵng - Hội An - Huế - Quảng Bình','https://sakos.vn/wp-content/uploads/2023/06/phieu-luu-trong-long-dong-phong-nha-hanh-trinh-kham-pha-vung-dat-ky-bi-phan-1-1.jpeg','2023-8-18',15,40,8000000,6000000,7000000,5000000,5,4,5,'CN2'),
                        ('','Hội An - Huế','https://static.vinwonders.com/2022/07/chua-hoi-an-2.1.jpg','2023-8-18',8,40,7500000,7000000,6500000,6000000,5,4,5,'CN4'),
                        ('','Nha Trang','https://cdn.tgdd.vn/Files/2021/06/22/1362258/mot-so-kinh-nghiem-du-lich-nha-trang-cuc-bo-ich-ban-nen-biet-202201102016092511.jpeg','2023-8-25',8,32,6000000,5500000,5000000,4000000,4,2,3,'CN4'),
                        ('','HÀ NỘI, SAPA, NINH BÌNH - CHÙA TAM CHÚC, HẠ LONG','https://songhongtourist.vn/upload/2022-11-16/z3885040735996_7747580cb8f649e7a1604e3f84bd68b5-5.jpg','2023-8-18',10,40,10000000,8000000,9000000,7500000,4,6,7,'CN1');
                        
                        
-- insert into DiemCCDV

INSERT INTO DonViCungCapDV VALUES
('DV0007', 'Khách sạn Phú Quốc Pearl Resort', 'phuquocpearl@gmail.com', '0245678913', 'Lê Thị G', '0245678914', 'Số 30, Đường Trần Hưng Đạo', 'Dương Tơ', 'Phú Quốc', 'Kiên Giang', NULL, NULL, NULL, NULL, NULL, '1', ''),
('DV0008', 'Nhà hàng Phú Quốc Seafood Paradise', 'phuquocseafood@gmail.com', '0245678915', 'Nguyễn Văn H', '0245678916', 'Số 33, Đường Nguyễn Trung Trực', 'Dương Tơ', 'Phú Quốc', 'Kiên Giang', NULL, NULL, NULL, NULL, NULL, '3', ''),
('DV0009', 'Khách sạn Tràng An Palace', 'tranganpalace@gmail.com', '0245678905', 'Lê Văn C', '0245678906', 'Số 18, Đường Hoa Lư', 'Trường Yên', 'Hoa Lư', 'Ninh Bình', NULL, NULL, NULL, NULL, NULL, '1', ''),
('DV0010', 'Nhà hàng Cơm Lam Tràng An', 'comlamtrangan@gmail.com', '0245678907', 'Phạm Thị D', '0245678908', 'Số 21, Đường Tràng An', 'Trường Yên', 'Hoa Lư', 'Ninh Bình', NULL, NULL, NULL, NULL, NULL, '3',''),
('DV0011', 'Khách sạn Thiên Mụ Garden Resort & Spa ', 'thienmugarden@gmail.com','0245678909','Nguyễn Văn E','0245678910','Số 24 , Đường Nguyễn Sinh Cung','Vỹ Dạ','Huế','Thừa Thiên Huế' ,NULL,NULL,NULL,NULL,NULL,'1',''),
('DV0012','Nhà hàng Huế Garden','huegarden@gmail.com','0245678911','Trần Thị F','0245678912','Số 27 , Đường Lê Lợi','Phú Hội','Huế','Thừa Thiên Huế' ,NULL,NULL,NULL,NULL,NULL,'3',''),
('DV0013','Khách sạn Đà Lạt Palace','dalatpalace@gmail.com','0245678917','Trần Văn I','0245678918','Số 36 , Đường Trần Phú' ,'Phường 1' ,'Đà Lạt' ,'Lâm Đồng' ,NULL,NULL,NULL,NULL,NULL,'1',''),
('DV0014','Nhà hàng Đà Lạt Pizza House','dalatpizza@gmail.com','0245678919','Nguyễn Thị J','0245678920','Số 39 , Đường Nguyễn Chí Thanh' ,'Phường 1' ,'Đà Lạt' ,'Lâm Đồng' ,NULL,NULL,NULL,NULL,NULL,'3',''),
('DV0015','Khách sạn Nha Trang Beach Resort','nhatrangbeach@gmail.com','0245678921','Lê Thị K','0245678922','Số 42 , Đường Trần Phú' ,'Lộc Thọ' ,'Nha Trang' ,'Khánh Hòa' ,NULL,NULL,NULL,NULL,NULL,'1',''),
('DV0016','Nhà hàng Nha Trang Seafood Paradise','nhatrangseafood@gmail.com','0245678923','Phạm Văn L','0245678924','Số 45 , Đường Nguyễn Thiện Thuật' ,'Tân Lập' ,'Nha Trang' ,'Khánh Hòa' ,NULL,NULL,NULL,NULL,NULL,'3',''),
('DV0017','Khách sạn Hội An Ancient Town Resort','hoianancient@gmail.com','0245678925','Nguyễn Thị M','0245678926','Số 48 , Đường Nguyễn Phúc Chu' ,'Minh An' ,'Hội An' ,'Quảng Nam' ,NULL,NULL,NULL,NULL,NULL,'1',''),
('DV0018','Nhà hàng Hội An Quán','hoianquan@gmail.com','0245678927','Trần Văn N','0245678928','Số 51 , Đường Bạch Đằng' ,'Minh An' ,'Hội An' ,'Quảng Nam' ,NULL,NULL,NULL,NULL,NULL,'3',''),
('DV0019', 'Khách sạn Bà Nà Hills Resort', 'banahillsresort@gmail.com', '0245678929', 'Lê Văn O', '0245678930', 'Số 54, Đường Bà Nà', 'Hoà Ninh', 'Hoà Vang', 'Đà Nẵng', NULL, NULL, NULL, NULL, NULL, '1', ''),
('DV0020', 'Nhà hàng Bà Nà Hills Buffet', 'banahillsbuffet@gmail.com', '0245678931', 'Phạm Thị P', '0245678932', 'Số 57, Đường Bà Nà', 'Hoà Ninh', 'Hoà Vang', 'Đà Nẵng', NULL, NULL, NULL, NULL, NULL, '3', ''),
('DV0021', 'Khách sạn Thiên Đường Cave Resort', 'thienduongcave@gmail.com', '0245678933', 'Nguyễn Văn Q', '0245678934', 'Số 60, Đường Hoàng Sa', 'Sơn Trạch', 'Bố Trạch', 'Quảng Bình', NULL, NULL, NULL, NULL, NULL, '1', ''),
('DV0022', 'Nhà hàng Thiên Đường Cave Restaurant', 'thienduongcaverestaurant@gmail.com', '0245678935', 'Trần Thị R', '0245678936', 'Số 63, Đường Hoàng Sa', 'Sơn Trạch', 'Bố Trạch', 'Quảng Bình', NULL, NULL, NULL, NULL, NULL, '3', ''),
('DV0024', 'Khách sạn Lăng Bác Heritage Hotel', 'langbachotel@gmail.com', '0245678937', 'Lê Văn S', '0245678938', 'Số 66, Đường Ngọc Hà', 'Ngọc Hà', 'Ba Đình', 'Hà Nội', NULL, NULL, NULL, NULL, NULL, '1', ''),
('DV0025', 'Nhà hàng Lăng Bác Quán', 'langbacquan@gmail.com', '0245678939', 'Phạm Thị T', '0245678940', 'Số 69, Đường Ngọc Hà', 'Ngọc Hà', 'Ba Đình', 'Hà Nội', NULL, NULL, NULL, NULL, NULL, '3', ''),
('DV0026', 'Khách sạn Chùa Một Cột Paradise Hotel ', 'chuamotcothotel@gmail.com','0245678941','Nguyễn Văn U','0245678942','Số 72 , Đường Đội Cấn' ,'Liễu Giai' ,'Ba Đình' ,'Hà Nội' ,NULL,NULL,NULL,NULL,NULL,'1',''),
('DV0027', 'Nhà hàng Chùa Một Cột Quán', 'chuamotcotquan@gmail.com', '0245678943', 'Trần Thị V', '0245678944', 'Số 75, Đường Đội Cấn', 'Liễu Giai', 'Ba Đình', 'Hà Nội', NULL, NULL, NULL, NULL, NULL, '3', ''),
('DV0028', 'Khách sạn Văn Miếu Garden Resort & Spa ', 'vanmieugarden@gmail.com','0245678945','Lê Văn W','0245678946','Số 78 , Đường Quốc Tử Giám' ,'Văn Miếu' ,'Đống Đa' ,'Hà Nội' ,NULL,NULL,NULL,NULL,NULL,'1',''),
('DV0029', 'Nhà hàng Văn Miếu Quán', 'vanmieuquan@gmail.com', '0245678947', 'Phạm Thị X', '0245678948', 'Số 81, Đường Quốc Tử Giám', 'Văn Miếu', 'Đống Đa', 'Hà Nội', NULL, NULL, NULL, NULL, NULL,'3',''),
('DV0030','Khách sạn Bản Cát Cát Resort ','bancatcatresort@gmail.com','0245678949','Nguyễn Văn Y','0245678950','Số 84 , Đường Cát Cát' ,'San Sả Hồ' ,'Sa Pa' ,'Lào Cai' ,NULL,NULL,NULL,NULL,NULL,'1',''),
('DV0031','Nhà hàng Bản Cát Cát Quán','bancatcatquan@gmail.com','0245678951','Trần Thị Z','0245678952','Số 87,Dương Cát Cát','San Sả Hồ','Sa Pa','Lào Cai',NULL,NULL,NULL,NULL,NULL,'3',''),
('DV0032', 'Công ty vận chuyển HCM Express', 'hcmexpress@gmail.com', '0245678953', 'Nguyễn Văn A', '0245678954', 'Số 90, Đường Lê Lợi', 'Bến Thành', 'Quận 1', 'TP Hồ Chí Minh', NULL, NULL, NULL, NULL, NULL, '2', ''),
('DV0033', 'Công ty vận chuyển An Giang Travel', 'angiangtravel@gmail.com', '0245678955', 'Trần Thị B', '0245678956', 'Số 93, Đường Trần Hưng Đạo', 'Mỹ Bình', 'Long Xuyên', 'An Giang', NULL, NULL, NULL, NULL, NULL, '2', ''),
('DV0034', 'Công ty vận chuyển Đà Lạt Tourist', 'dalattourist@gmail.com','0245678957','Lê Văn C','0245678958','Số 96 , Đường Phan Đình Phùng' ,'Phường 2' ,'Đà Lạt' ,'Lâm Đồng' ,NULL,NULL,NULL,NULL,NULL,'2',''),
('DV0035','Công ty vận chuyển Nha Trang Beach Bus','nhatrangbeachbus@gmail.com','0245678959','Phạm Thị D','0245678960','Số 99 , Đường Trần Phú' ,'Vĩnh Nguyên' ,'Nha Trang' ,'Khánh Hòa' ,NULL,NULL,NULL,NULL,NULL,'2',''),
('DV0036','Công ty vận chuyển Đà Nẵng Fly Car','danangflycar@gmail.com','0245678961','Nguyễn Văn E','0245678962','Số 102 , Đường Nguyễn Văn Linh' ,'Nam Dương' ,'Hải Châu' ,'Đà Nẵng' ,NULL,NULL,NULL,NULL,NULL,'2','');



-- insert into Ngaykhoihanhtourdaingay

INSERT INTO Ngaykhoihanhtourdaingay (Matour, Ngay) VALUES
('CN1-000005', 25),
('CN1-000005', 2),

('CN1-000010', 25),
('CN1-000010', 2),

('CN2-000006', 25),
('CN2-000006', 2),

('CN2-000007', 25),
('CN2-000007', 2),

('CN3-000003', 25),
('CN3-000003', 2),

('CN4-000001', 25),

('CN4-000004', 25),

('CN4-000008', 25),

('CN4-000009', 25);



-- insert into Lichtrinhtour


INSERT INTO Lichtrinhtour VALUES
('CN1-000002', 1),
('CN1-000005', 1),
('CN1-000005', 2),
('CN1-000005', 3),
('CN1-000010', 1),
('CN1-000010', 2),
('CN1-000010', 3),
('CN1-000010', 4),
('CN1-000010', 5),
('CN1-000010', 6),
('CN1-000010', 7),
('CN2-000006', 1),
('CN2-000006', 2),
('CN2-000006', 3),
('CN2-000006', 4),
('CN2-000007', 1),
('CN2-000007', 2),
('CN2-000007', 3),
('CN2-000007', 4),
('CN2-000007', 5),
('CN3-000003', 1),
('CN3-000003', 2),
('CN3-000003', 3),
('CN3-000003', 4),
('CN4-000001', 1),
('CN4-000001', 2),
('CN4-000004', 1),
('CN4-000004', 2),
('CN4-000004', 3),
('CN4-000004', 4),
('CN4-000004', 5),
('CN4-000004', 6),
('CN4-000008', 1),
('CN4-000008', 2),
('CN4-000008', 3),
('CN4-000008', 4),
('CN4-000008', 5),
('CN4-000009', 1),
('CN4-000009', 2),
('CN4-000009', 3);

INSERT INTO TourGomDDTQ VALUES
('CN1-000002', 1, 1, '07:30:00','11:30:00',''),
('CN1-000002', 1, 12, '14:30:00','18:30:00',''),


('CN1-000005', 1, 2, '07:30:00','11:30:00',''),
('CN1-000005', 1, 11, '13:30:00','16:30:00',''),
('CN1-000005', 1, 3, '18:30:00','21:30:00',''),

('CN1-000005', 2, 10, '8:00:00','16:00:00',''),

('CN1-000005', 3, 9, '8:00:00','16:00:00',''),


('CN1-000010', 1, 23, '8:00:00','11:00:00',''),
('CN1-000010', 1, 24, '13:00:00','16:00:00',''),

('CN1-000010', 2, 25, '8:00:00','11:30:00',''),


('CN1-000010', 3, 26, '8:00:00','12:00:00',''),

('CN1-000010', 4, 28, '8:00:00','16:00:00',''),

('CN1-000010', 5, 27, '8:00:00', '16:00:00',''),

('CN1-000010', 6, 29, '13:30:00', '16:00:00',''),

('CN1-000010', 7, 29, '8:00:00','16:30:00',''),


('CN2-000006', 1, 8, '8:00:00', '16:00:00',''),

('CN2-000006', 2, 6, '8:00:00', '17:00:00',''),

('CN2-000006', 3, 6, '8:00:00', '18:00:00', ''),

('CN2-000006', 4, 7, '8:00:00', '15:00:00', ''),


('CN2-000007', 1,14,'8:00:00','11:30:00', ''),
('CN2-000007', 1,15,'13:30:00','16:30:00', ''),

('CN2-000007', 2, 17, '8:00:00', '17:00:00', ''),
('CN2-000007', 2, 16, '18:30:00','22:30:00',''),

('CN2-000007', 3, 22, '8:00:00','11:30:00',''),
('CN2-000007', 3, 18, '13:30:00','17:30:00',''),

('CN2-000007', 4, 19, '9:00:00','16:30:00',''),

('CN2-000007', 5, 20, '8:00:00','11:30:00',''),
('CN2-000007', 5, 21, '13:30:00','17:30:00',''),


('CN3-000003', 1, 13, '8:00:00','11:00:00',''),
('CN3-000003', 1, 5, '13:30:00','17:00:00',''),

('CN3-000003', 2, 11, '8:30:00','11:30:00',''),
('CN3-000003', 2, 2, '13:30:00','17:30:00',''),

('CN3-000003', 3, 9, '8:30:00','16:30:00', ''),

('CN3-000003', 4, 10, '8:30:00','16:30:00', ''),
('CN3-000003', 4, 3, '19:00:00','22:30:00', ''),





('CN4-000001', 1, 7, '8:30:00','16:30:00', ''),
('CN4-000001', 2, 8, '8:30:00','16:30:00', ''),



('CN4-000004', 1, 5, '8:30:00','16:30:00', ''),
('CN4-000004', 2, 10, '8:30:00','16:30:00', ''),
('CN4-000004', 3, 11, '8:30:00','16:30:00', ''),
('CN4-000004', 4, 9, '8:30:00','16:30:00', ''),
('CN4-000004', 5, 2, '8:30:00','16:30:00', ''),
('CN4-000004', 6, 1, '8:30:00','11:30:00', ''),



('CN4-000008', 1, 16, '8:30:00','21:30:00', ''),
('CN4-000008', 2, 22, '8:30:00','16:30:00', ''),
('CN4-000008', 3, 18, '8:30:00','18:00:00', ''),
('CN4-000008', 4, 19, '8:30:00','16:30:00', ''),
('CN4-000008', 5, 19, '8:30:00','16:30:00', ''),


('CN4-000009', 1, 5, '8:30:00','16:30:00', ''),
('CN4-000009', 2, 12, '8:30:00','16:30:00', ''),
('CN4-000009', 3, 13, '8:30:00','16:30:00', '');

INSERT INTO  HanhDongLichtrinhtour VALUES
('CN1-000002', 1, '1', '6:00:00', '6:30:00', ''),
('CN1-000002', 1, '4', '11:30:00', '13:00:00', ''),
('CN1-000002', 1, '2', '17:00:00', '18:00:00', ''),

('CN1-000005', 1, '1', '00:00:00', '6:30:00', ''),
('CN1-000005', 1, '4', '11:30:00', '12:00:00', ''),
('CN1-000005', 1, '6', '12:00:00', '12:30:00', ''),
('CN1-000005', 1, '5', '17:00:00', '18:00:00', ''),

('CN1-000005', 2, '3', '6:00:00', '6:30:00', ''),
('CN1-000005', 2, '4', '11:30:00', '12:00:00', ''),
('CN1-000005', 2, '5', '17:00:00', '18:00:00', ''),

('CN1-000005', 3, '3', '6:00:00', '6:30:00', ''),
('CN1-000005', 3, '7', '11:00:00', '11:30:00', ''),
('CN1-000005', 3, '4', '11:30:00', '12:00:00', ''),
('CN1-000005', 3, '5', '17:00:00', '18:00:00', ''),
('CN1-000005', 3, '2', '20:00:00', '21:00:00', ''),

('CN1-000010', 1, '1', '00:00:00', '6:30:00', ''),
('CN1-000010', 1, '4', '11:30:00', '12:00:00', ''),
('CN1-000010', 1, '6', '12:00:00', '12:30:00', ''),
('CN1-000010', 1, '5', '17:00:00', '18:00:00', ''),

('CN1-000010', 2, '3', '6:00:00', '6:30:00', ''),
('CN1-000010', 2, '4', '11:30:00', '12:00:00', ''),
('CN1-000010', 2, '5', '17:00:00', '18:00:00', ''),

('CN1-000010', 3, '3', '6:00:00', '6:30:00', ''),
('CN1-000010', 3, '4', '11:30:00', '12:00:00', ''),
('CN1-000010', 3, '5', '17:00:00', '18:00:00', ''),

('CN1-000010', 4, '3', '6:00:00', '6:30:00', ''),
('CN1-000010', 4, '4', '11:30:00', '12:00:00', ''),
('CN1-000010', 4, '5', '17:00:00', '18:00:00', ''),

('CN1-000010', 5, '3', '6:00:00', '6:30:00', ''),
('CN1-000010', 5, '4', '11:30:00', '12:00:00', ''),
('CN1-000010', 5, '5', '17:00:00', '18:00:00', ''),

('CN1-000010', 6, '3', '6:00:00', '6:30:00', ''),
('CN1-000010', 6, '4', '11:30:00', '12:00:00', ''),
('CN1-000010', 6, '5', '17:00:00', '18:00:00', ''),

('CN1-000010', 7, '3', '6:00:00', '6:30:00', ''),
('CN1-000010', 7, '7', '11:00:00', '11:30:00', ''),
('CN1-000010', 7, '4', '11:30:00', '12:00:00', ''),
('CN1-000010', 7, '5', '17:00:00', '18:00:00', ''),
('CN1-000010', 7, '2', '20:00:00', '', ''),


('CN2-000006', 1, '1', '4:00:00', '6:30:00', ''),
('CN2-000006', 1, '4', '11:30:00', '12:00:00', ''),
('CN2-000006', 1, '6', '12:00:00', '12:30:00', ''),
('CN2-000006', 1, '5', '17:00:00', '18:00:00', ''),

('CN2-000006', 2, '3', '6:00:00', '6:30:00', ''),
('CN2-000006', 2, '4', '11:30:00', '12:00:00', ''),
('CN2-000006', 2, '5', '17:00:00', '18:00:00', ''),

('CN2-000006', 3, '3', '6:00:00', '6:30:00', ''),
('CN2-000006', 3, '4', '11:30:00', '12:00:00', ''),
('CN2-000006', 3, '5', '17:00:00', '18:00:00', ''),

('CN2-000006', 4, '3', '6:00:00', '6:30:00', ''),
('CN2-000006', 4, '7', '11:00:00', '11:30:00', ''),
('CN2-000006', 4, '4', '11:30:00', '12:00:00', ''),
('CN2-000006', 4, '5', '17:00:00', '18:00:00', ''),
('CN2-000006', 4, '2', '20:00:00', '', ''),

('CN2-000007', 1, '1', '00:00:00', '6:30:00', ''),
('CN2-000007', 1, '4', '11:30:00', '12:00:00', ''),
('CN2-000007', 1, '6', '12:00:00', '12:30:00', ''),
('CN2-000007', 1, '5', '17:00:00', '18:00:00', ''),

('CN2-000007', 2, '3', '6:00:00', '6:30:00', ''),
('CN2-000007', 2, '4', '11:30:00', '12:00:00', ''),
('CN2-000007', 2, '5', '17:00:00', '18:00:00', ''),

('CN2-000007', 3, '3', '6:00:00', '6:30:00', ''),
('CN2-000007', 3, '4', '11:30:00', '12:00:00', ''),
('CN2-000007', 3, '5', '17:00:00', '18:00:00', ''),

('CN2-000007', 4, '3', '6:00:00', '6:30:00', ''),
('CN2-000007', 4, '4', '11:30:00', '12:00:00', ''),
('CN2-000007', 4, '5', '17:00:00', '18:00:00', ''),

('CN2-000007', 5, '3', '6:00:00', '6:30:00', ''),
('CN2-000007', 5, '7', '11:00:00', '11:30:00', ''),
('CN2-000007', 5, '4', '11:30:00', '12:00:00', ''),
('CN2-000007', 5, '5', '17:00:00', '18:00:00', ''),
('CN2-000007', 5, '2', '20:00:00', '21:00:00', ''),

('CN3-000003', 1, '1', '4:00:00', '6:30:00', ''),
('CN3-000003', 1, '4', '11:30:00', '12:00:00', ''),
('CN3-000003', 1, '6', '12:00:00', '12:30:00', ''),
('CN3-000003', 1, '5', '17:00:00', '18:00:00', ''),

('CN3-000003', 2, '3', '6:00:00', '6:30:00', ''),
('CN3-000003', 2, '4', '11:30:00', '12:00:00', ''),
('CN3-000003', 2, '5', '17:00:00', '18:00:00', ''),

('CN3-000003', 3, '3', '6:00:00', '6:30:00', ''),
('CN3-000003', 3, '4', '11:30:00', '12:00:00', ''),
('CN3-000003', 3, '5', '17:00:00', '18:00:00', ''),

('CN3-000003', 4, '3', '6:00:00', '6:30:00', ''),
('CN3-000003', 4, '7', '11:00:00', '11:30:00', ''),
('CN3-000003', 4, '4', '11:30:00', '12:00:00', ''),
('CN3-000003', 4, '5', '17:00:00', '18:00:00', ''),
('CN3-000003', 4, '2', '20:00:00', '21:00:00', ''),

('CN4-000001', 1, '1', '4:00:00', '6:30:00', ''),
('CN4-000001', 1, '4', '11:30:00', '12:00:00', ''),
('CN4-000001', 1, '6', '12:00:00', '12:30:00', ''),
('CN4-000001', 1, '5', '17:00:00', '18:00:00', ''),

('CN4-000001', 2, '3', '6:00:00', '6:30:00', ''),
('CN4-000001', 2, '7', '11:00:00', '11:30:00', ''),
('CN4-000001', 2, '4', '11:30:00', '12:00:00', ''),
('CN4-000001', 2, '5', '17:00:00', '18:00:00', ''),
('CN4-000001', 2, '2', '20:00:00', '21:00:00', ''),

('CN4-000004', 1, '1', '00:00:00', '6:30:00', ''),
('CN4-000004', 1, '4', '11:30:00', '12:00:00', ''),
('CN4-000004', 1, '6', '12:00:00', '12:30:00', ''),
('CN4-000004', 1, '5', '17:00:00', '18:00:00', ''),

('CN4-000004', 2, '3', '6:00:00', '6:30:00', ''),
('CN4-000004', 2, '4', '11:30:00', '12:00:00', ''),
('CN4-000004', 2, '5', '17:00:00', '18:00:00', ''),

('CN4-000004', 3, '3', '6:00:00', '6:30:00', ''),
('CN4-000004', 3, '4', '11:30:00', '12:00:00', ''),
('CN4-000004', 3, '5', '17:00:00', '18:00:00', ''),

('CN4-000004', 4, '3', '6:00:00', '6:30:00', ''),
('CN4-000004', 4, '4', '11:30:00', '12:00:00', ''),
('CN4-000004', 4, '5', '17:00:00', '18:00:00', ''),

('CN4-000004', 5, '3', '6:00:00', '6:30:00', ''),
('CN4-000004', 5, '4', '11:30:00', '12:00:00', ''),
('CN4-000004', 5, '5', '17:00:00', '18:00:00', ''),

('CN4-000004', 6, '3', '6:00:00', '6:30:00', ''),
('CN4-000004', 6, '7', '11:00:00', '11:30:00', ''),
('CN4-000004', 6, '4', '11:30:00', '12:00:00', ''),
('CN4-000004', 6, '5', '17:00:00', '18:00:00', ''),
('CN4-000004', 6, '2', '20:00:00', '21:00:00', ''),

('CN4-000008', 1, '1', '00:00:00', '6:30:00', ''),
('CN4-000008', 1, '4', '11:30:00', '12:00:00', ''),
('CN4-000008', 1, '6', '12:00:00', '12:30:00', ''),
('CN4-000008', 1, '5', '17:00:00', '18:00:00', ''),

('CN4-000008', 2, '3', '6:00:00', '6:30:00', ''),
('CN4-000008', 2, '4', '11:30:00', '12:00:00', ''),
('CN4-000008', 2, '5', '17:00:00', '18:00:00', ''),

('CN4-000008', 3, '3', '6:00:00', '6:30:00', ''),
('CN4-000008', 3, '4', '11:30:00', '12:00:00', ''),
('CN4-000008', 3, '5', '17:00:00', '18:00:00', ''),

('CN4-000008', 4, '3', '6:00:00', '6:30:00', ''),
('CN4-000008', 4, '4', '11:30:00', '12:00:00', ''),
('CN4-000008', 4, '5', '17:00:00', '18:00:00', ''),

('CN4-000008', 5, '3', '6:00:00', '6:30:00', ''),
('CN4-000008', 5, '7', '11:00:00', '11:30:00', ''),
('CN4-000008', 5, '4', '11:30:00', '12:00:00', ''),
('CN4-000008', 5, '5', '17:00:00', '18:00:00', ''),
('CN4-000008', 5, '2', '20:00:00', '21:00:00', ''),

('CN4-000009', 1, '1', '00:00:00', '6:30:00', ''),
('CN4-000009', 1, '4', '11:30:00', '12:00:00', ''),
('CN4-000009', 1, '6', '12:00:00', '12:30:00', ''),
('CN4-000009', 1, '5', '17:00:00', '18:00:00', ''),

('CN4-000009', 2, '3', '6:00:00', '6:30:00', ''),
('CN4-000009', 2, '4', '11:30:00', '12:00:00', ''),
('CN4-000009', 2, '5', '17:00:00', '18:00:00', ''),

('CN4-000009', 3, '3', '6:00:00', '6:30:00', ''),
('CN4-000009', 3, '7', '11:00:00', '11:30:00', ''),
('CN4-000009', 3, '4', '11:30:00', '12:00:00', ''),
('CN4-000009', 3, '5', '17:00:00', '18:00:00', ''),
('CN4-000009', 3, '2', '20:00:00', '21:00:00', '');

INSERT INTO ChuyenDi VALUES
('CN1-000002','2023-06-25','2023-06-25',0),
('CN1-000002','2023-07-25','2023-08-25',0),
('CN4-000001','2023-05-25','2023-05-25',0);

INSERT INTO ChuyenDi VALUES
('CN1-000002','2023-08-25','2023-08-25',0),
('CN1-000002','2023-08-26','2023-08-26',0),
('CN1-000002','2023-09-02','2023-09-02',0),

('CN1-000005','2023-08-25','2023-08-28',0),

('CN1-000005','2023-09-02','2023-09-05',0),

('CN1-000010','2023-08-25','2023-08-31',0),

('CN1-000010','2023-09-02','2023-09-09',0),

('CN2-000006','2023-08-25','2023-08-29',0),

('CN2-000006','2023-09-02','2023-09-06',0),

('CN2-000007','2023-08-25','2023-08-30',0),

('CN2-000007','2023-09-02','2023-09-07',0),

('CN3-000003','2023-08-25','2023-08-29',0),

('CN3-000003','2023-09-02','2023-09-06',0),

('CN4-000001','2023-08-25','2023-08-27',0),

('CN4-000001','2023-09-02','2023-09-04',0),

('CN4-000004','2023-08-25','2023-08-31',0),

('CN4-000004','2023-09-02','2023-09-08',0),

('CN4-000008','2023-08-25','2023-08-30',0),

('CN4-000008','2023-09-02','2023-09-07',0),

('CN4-000009','2023-08-25','2023-08-27',0),

('CN4-000009','2023-09-02','2023-09-04',0);

INSERT INTO HDVDanChuyenDi VALUES
('CN1-000002','2023-06-25','HD1011'),
('CN1-000002','2023-07-25','HD1011'),
('CN4-000001','2023-05-25','HD0016');

INSERT INTO HDVDanChuyenDi VALUES
('CN1-000002','2023-08-25','HD0016'),
('CN1-000002','2023-08-26','HD0077'),
('CN1-000002','2023-09-02','HD1011'),

('CN1-000005','2023-08-25','HD1012'),

('CN1-000005','2023-09-02','HD0077'),

('CN1-000010','2023-08-25','HD1011'),

('CN1-000010','2023-09-02','HD1012'),

('CN2-000006','2023-08-25','HD0016'),

('CN2-000006','2023-09-02','HD0077'),

('CN2-000007','2023-08-25','HD1012'),

('CN2-000007','2023-09-02','HD1011'),

('CN3-000003','2023-08-25','HD0077'),

('CN3-000003','2023-09-02','HD1011'),

('CN4-000001','2023-08-25','HD1012'),

('CN4-000001','2023-09-02','HD0016'),

('CN4-000004','2023-08-25','HD0016'),

('CN4-000004','2023-09-02','HD0016'),

('CN4-000008','2023-08-25','HD1011'),

('CN4-000008','2023-09-02','HD1011'),

('CN4-000009','2023-08-25','HD1012'),

('CN4-000009','2023-09-02','HD1012');
INSERT INTO LichTrinhChuyen VALUES
('CN1-000002','2023-06-25',1),
('CN1-000002','2023-07-25',1),

('CN4-000001','2023-05-25',1),
('CN4-000001','2023-05-25',2);

INSERT INTO LichTrinhChuyen VALUES

('CN1-000002','2023-08-25', 1),
('CN1-000002','2023-08-26', 1),
('CN1-000002','2023-09-02', 1),

('CN1-000005','2023-08-25',1),
('CN1-000005','2023-08-25',2),
('CN1-000005','2023-08-25',3),


('CN1-000005','2023-09-02',1),
('CN1-000005','2023-09-02',2),
('CN1-000005','2023-09-02',3),

('CN1-000010','2023-08-25',1),
('CN1-000010','2023-08-25',2),
('CN1-000010','2023-08-25',3),
('CN1-000010','2023-08-25',4),
('CN1-000010','2023-08-25',5),
('CN1-000010','2023-08-25',6),
('CN1-000010','2023-08-25',7),

('CN1-000010','2023-09-02',1),
('CN1-000010','2023-09-02',2),
('CN1-000010','2023-09-02',3),
('CN1-000010','2023-09-02',4),
('CN1-000010','2023-09-02',5),
('CN1-000010','2023-09-02',6),
('CN1-000010','2023-09-02',7),

('CN2-000006','2023-08-25',1),
('CN2-000006','2023-08-25',2),
('CN2-000006','2023-08-25',3),
('CN2-000006','2023-08-25',4),

('CN2-000006','2023-09-02',1),
('CN2-000006','2023-09-02',2),
('CN2-000006','2023-09-02',3),
('CN2-000006','2023-09-02',4),

('CN2-000007','2023-08-25',1),
('CN2-000007','2023-08-25',2),
('CN2-000007','2023-08-25',3),
('CN2-000007','2023-08-25',4),
('CN2-000007','2023-08-25',5),

('CN2-000007','2023-09-02',1),
('CN2-000007','2023-09-02',2),
('CN2-000007','2023-09-02',3),
('CN2-000007','2023-09-02',4),
('CN2-000007','2023-09-02',5),

('CN3-000003','2023-08-25',1),
('CN3-000003','2023-08-25',2),
('CN3-000003','2023-08-25',3),
('CN3-000003','2023-08-25',4),

('CN3-000003','2023-09-02',1),
('CN3-000003','2023-09-02',2),
('CN3-000003','2023-09-02',3),
('CN3-000003','2023-09-02',4),

('CN4-000001','2023-08-25',1),
('CN4-000001','2023-08-25',2),

('CN4-000001','2023-09-02',1),
('CN4-000001','2023-09-02',2),

('CN4-000004','2023-08-25',1),
('CN4-000004','2023-08-25',2),
('CN4-000004','2023-08-25',3),
('CN4-000004','2023-08-25',4),
('CN4-000004','2023-08-25',5),
('CN4-000004','2023-08-25',6),

('CN4-000008','2023-08-25',1),
('CN4-000008','2023-08-25',2),
('CN4-000008','2023-08-25',3),
('CN4-000008','2023-08-25',4),
('CN4-000008','2023-08-25',5),

('CN4-000009','2023-08-25',1),
('CN4-000009','2023-08-25',2),
('CN4-000009','2023-08-25',3);


INSERT INTO DVCCDVChuyen  VALUES
('CN1-000002','2023-06-25',1, '1', 'DV0032'),
('CN1-000002','2023-06-25',1, '2', 'DV0032'),
('CN1-000002','2023-06-25', 1, '4', 'DV0032'),
('CN1-000002','2023-06-25', 1, '8', 'DV0032'),

('CN1-000002','2023-07-25',1, '1', 'DV0032'),
('CN1-000002','2023-07-25',1, '2', 'DV0032'),
('CN1-000002','2023-07-25', 1, '4', 'DV0032'),
('CN1-000002','2023-07-25', 1, '8', 'DV0032'),

('CN4-000001','2023-05-25',1, '1', 'DV0033'),
('CN4-000001','2023-05-25',1, '4', 'DV0033'),
('CN4-000001','2023-05-25',1, '5', 'DV0033'),
('CN4-000001','2023-05-25',1, '6', 'DV0033'),
('CN4-000001','2023-05-25',1, '8', 'DV0033'),


('CN4-000001','2023-05-25',2, '2', 'DV0033'),
('CN4-000001','2023-05-25',2, '3', 'DV0033'),
('CN4-000001','2023-05-25',2, '4', 'DV0033'),
('CN4-000001','2023-05-25',2, '5', 'DV0033'),
('CN4-000001','2023-05-25',2, '7', 'DV0033'),
('CN4-000001','2023-05-25',2, '8', 'DV0033');

INSERT INTO DVCCDVChuyen  VALUES
('CN1-000002','2023-08-25', 1, '1', 'DV0032'),
('CN1-000002','2023-08-25', 1, '2', 'DV0032'),

('CN1-000002','2023-08-26', 1, '1', 'DV0032'),
('CN1-000002','2023-08-26', 1, '2', 'DV0032'),

('CN1-000002','2023-09-02', 1, '1', 'DV0032'),
('CN1-000002','2023-09-02', 1, '2', 'DV0032'),


('CN1-000005','2023-08-25',1,'1','DV0034'),
('CN1-000005','2023-08-25',1,'8','DV0034'),
('CN1-000005','2023-08-25',1,'6','DV0013'),

('CN1-000005','2023-08-25',1,'4','DV0013'),
('CN1-000005','2023-08-25',1,'5','DV0014'),



('CN1-000005','2023-08-25',2,'8','DV0034'),
('CN1-000005','2023-08-25',2,'3','DV0013'),
('CN1-000005','2023-08-25',2,'4','DV0013'),
('CN1-000005','2023-08-25',2,'5','DV0014'),

('CN1-000005','2023-08-25',3,'8','DV0034'),
('CN1-000005','2023-08-25',3,'3','DV0013'),
('CN1-000005','2023-08-25',3,'4','DV0013'),
('CN1-000005','2023-08-25',3,'5','DV0014'),
('CN1-000005','2023-08-25',3,'7','DV0013'),
('CN1-000005','2023-08-25',3,'2','DV0013'),




('CN1-000005','2023-09-02',1,'1','DV0034'),
('CN1-000005','2023-09-02',1,'8','DV0034'),
('CN1-000005','2023-09-02',1,'6','DV0013'),

('CN1-000005','2023-09-02',1,'4','DV0013'),
('CN1-000005','2023-09-02',1,'5','DV0014'),

('CN1-000005','2023-09-02',2,'8','DV0034'),
('CN1-000005','2023-09-02',2,'3','DV0013'),
('CN1-000005','2023-09-02',2,'4','DV0013'),
('CN1-000005','2023-09-02',2,'5','DV0014'),

('CN1-000005','2023-09-02',3,'8','DV0034'),
('CN1-000005','2023-09-02',3,'3','DV0013'),
('CN1-000005','2023-09-02',3,'4','DV0013'),
('CN1-000005','2023-09-02',3,'5','DV0014'),
('CN1-000005','2023-09-02',3,'7','DV0013'),
('CN1-000005','2023-09-02',3,'2','DV0013');

INSERT INTO DVCCDVChuyen  VALUES
('CN1-000002','2023-08-25', 1, '8', 'DV0032'),
('CN1-000002','2023-08-26', 1, '8', 'DV0032'),
('CN1-000002','2023-09-02', 1, '8', 'DV0032'),
('CN1-000002','2023-08-25', 1, '4', 'DV0032'),
('CN1-000002','2023-08-26', 1, '4', 'DV0032'),
('CN1-000002','2023-09-02', 1, '4', 'DV0032');

INSERT INTO PhieuDangky VALUES
('', '2023-05-04', '', 'VP0119', NULL, 'KD0007', 'CN4-000001', '2023-05-25'),
('', '2023-05-04', '', 'VP0119', NULL, 'KD0008', 'CN4-000001', '2023-05-25'),
('', '2023-05-04', '', 'VP0119', NULL, 'KD0006', 'CN4-000001', '2023-05-25');
INSERT INTO PhieuDangky VALUES
('', '2023-06-05', '', 'VP0119', 'KH0010', NULL , 'CN1-000002', '2023-06-25'),
('', '2023-06-05', '', 'VP0119', 'KH0011', NULL , 'CN1-000002', '2023-06-25'),
('', '2023-06-05', '', 'VP0119', 'KH0012', NULL , 'CN1-000002', '2023-06-25'),
('', '2023-06-05', '', 'VP0119', 'KH0013', NULL , 'CN1-000002', '2023-06-25'),
('', '2023-06-05', '', 'VP0119', 'KH0041', NULL , 'CN1-000002', '2023-06-25'),
('', '2023-06-05', '', 'VP0119', 'KH0042', NULL , 'CN1-000002', '2023-06-25'),
('', '2023-06-05', '', 'VP0119', 'KH0043', NULL , 'CN1-000002', '2023-06-25'),
('', '2023-06-05', '', 'VP0119', 'KH0044', NULL , 'CN1-000002', '2023-06-25'),
('', '2023-06-04', '', 'VP0119', NULL, 'KD0004', 'CN1-000002', '2023-06-25'),
('', '2023-06-04', '', 'VP0119', NULL, 'KD0005', 'CN1-000002', '2023-06-25'),
('', '2023-06-04', '', 'VP0119', NULL, 'KD0001', 'CN1-000002', '2023-06-25');
INSERT INTO PhieuDangky VALUES
('', '2023-07-05', '', 'VP0119', 'KH0008', NULL , 'CN1-000002', '2023-07-25'),
('', '2023-07-05', '', 'VP0119', 'KH0003', NULL , 'CN1-000002', '2023-07-25'),
('', '2023-07-05', '', 'VP0119', 'KH0012', NULL , 'CN1-000002', '2023-07-25'),
('', '2023-07-05', '', 'VP0119', 'KH0013', NULL , 'CN1-000002', '2023-07-25'),
('', '2023-07-05', '', 'VP0119', 'KH0041', NULL , 'CN1-000002', '2023-07-25'),
('', '2023-07-05', '', 'VP0119', 'KH0042', NULL , 'CN1-000002', '2023-07-25'),
('', '2023-07-05', '', 'VP0119', 'KH0047', NULL , 'CN1-000002', '2023-07-25'),
('', '2023-07-05', '', 'VP0119', 'KH0050', NULL , 'CN1-000002', '2023-07-25'),
('', '2023-07-04', '', 'VP0119', NULL, 'KD0005', 'CN1-000002', '2023-07-25'),
('', '2023-07-04', '', 'VP0119', NULL, 'KD0003', 'CN1-000002', '2023-07-25'),
('', '2023-07-04', '', 'VP0119', NULL, 'KD0002', 'CN1-000002', '2023-07-25');

INSERT INTO PhieuDangky VALUES
('', '2023-08-03', '', 'VP0119', NULL , 'KD0001', 'CN1-000002', '2023-08-25');

INSERT INTO PhieuDangky VALUES
('', '2023-08-03', '', 'VP0119', 'KH0049' , NULL , 'CN1-000002', '2023-08-25');

INSERT INTO PhieuDangky VALUES
('', '2023-08-03', '', 'VP0119', 'KH0050', NULL , 'CN1-000002', '2023-08-25');

INSERT INTO PhieuDangky VALUES
('', '2023-08-04', '', 'VP0119', NULL, 'KD0002', 'CN1-000002', '2023-08-25'),
('', '2023-08-05', '', 'VP0119', 'KH0010', NULL , 'CN1-000002', '2023-08-25'),
('', '2023-08-05', '', 'VP0119', 'KH0011', NULL , 'CN1-000002', '2023-08-25'),
('', '2023-08-05', '', 'VP0119', 'KH0012', NULL , 'CN1-000002', '2023-08-25'),
('', '2023-08-05', '', 'VP0119', 'KH0013', NULL , 'CN1-000002', '2023-08-25'),
('', '2023-08-05', '', 'VP0119', 'KH0041', NULL , 'CN1-000002', '2023-08-25'),
('', '2023-08-05', '', 'VP0119', 'KH0042', NULL , 'CN1-000002', '2023-08-25'),
('', '2023-08-05', '', 'VP0119', 'KH0043', NULL , 'CN1-000002', '2023-08-25'),
('', '2023-08-05', '', 'VP0119', 'KH0044', NULL , 'CN1-000002', '2023-08-25'),

('', '2023-08-06', '', 'VP0119', NULL, 'KD0002', 'CN1-000005', '2023-09-02'),
('', '2023-08-06', '', 'VP0201', NULL, 'KD0003', 'CN1-000005', '2023-09-02'),
('', '2023-08-06', '', 'VP0201', 'KH0001', NULL, 'CN1-000005', '2023-09-02'),
('', '2023-08-06', '', 'VP0201', 'KH0002', NULL, 'CN1-000005', '2023-09-02'),
('', '2023-08-06', '', 'VP0201', 'KH0020', NULL, 'CN1-000005', '2023-09-02'),
('', '2023-08-06', '', 'VP0201', 'KH0021', NULL, 'CN1-000005', '2023-09-02'),
('', '2023-08-06', '', 'VP0201', 'KH0005', NULL, 'CN1-000005', '2023-09-02'),
('', '2023-08-06', '', 'VP0201', 'KH0006', NULL, 'CN1-000005', '2023-09-02'),
('', '2023-08-06', '', 'VP0201', 'KH0022', NULL, 'CN1-000005', '2023-09-02'),
('', '2023-08-06', '', 'VP0201', 'KH0023', NULL, 'CN1-000005', '2023-09-02');


INSERT INTO DonViCungCapDVlienquan VALUES
('CN1-000002', 1, 'DV0032'),

('CN1-000005', 2, 'DV0034'),
('CN1-000005', 3, 'DV0034'),
('CN1-000005', 9, 'DV0034'),
('CN1-000005', 10, 'DV0034'),
('CN1-000005', 11, 'DV0034'),


('CN1-000010', 23, 'DV0024'),
('CN1-000010', 23, 'DV0025'),
('CN1-000010', 24, 'DV0028'),
('CN1-000010', 24, 'DV0029'),
('CN1-000010', 26, 'DV0030'),
('CN1-000010', 26, 'DV0031'),
('CN1-000010', 28, 'DV0009'),
('CN1-000010', 28, 'DV0010'),

('CN2-000006', 6, 'DV0007'),
('CN2-000006', 7, 'DV0007'),
('CN2-000006', 8, 'DV0007'),

('CN2-000006', 6, 'DV0008'),
('CN2-000006', 7, 'DV0008'),
('CN2-000006', 8, 'DV0008'),

('CN2-000007', 17, 'DV0036'),
('CN2-000007', 14, 'DV0036'),
('CN2-000007', 15, 'DV0036'),
('CN2-000007', 20, 'DV0036'),
('CN2-000007', 21, 'DV0036'),
('CN2-000007', 18, 'DV0036'),
('CN2-000007', 22, 'DV0036');

DROP TRIGGER tg_TOUR_insert;


DELIMITER //
CREATE PROCEDURE add_tour(
    OUT matour varchar(11),
	IN tentour varchar(100), 
    IN anh varchar(150), 
    IN ngaybatdau date,
    IN sokhachtourtoithieu int,
    IN sokhachtourtoida	 int,
    IN giavelenguoilon		 DECIMAL(10,0),
    IN giaveletreem	 	 DECIMAL(10,0),
    IN giavedoannguoilon	 DECIMAL(10,0),
    IN giavedoantreem	 	 DECIMAL(10,0),
    IN sokhachdoantoithieu	 int,
    IN sodem				 tinyint,
    IN songay				 tinyint,
    IN machinhanh			 varchar(4))
BEGIN
	DECLARE x tinyint DEFAULT 1;
  	INSERT INTO tour_index VALUES (NULL);
    SET matour = CONCAT(machinhanh,'-', LPAD(LAST_INSERT_ID(), 6, '0'));
    INSERT INTO tour VALUES(matour,tentour,anh,ngaybatdau,sokhachtourtoithieu,sokhachtourtoida,giavelenguoilon,giaveletreem,giavedoannguoilon,giavedoantreem,sokhachdoantoithieu,sodem,songay,machinhanh);
	WHILE x <= songay DO
		INSERT INTO lichtrinhtour VALUES(matour,x);
		SET x = x + 1;
	END WHILE;
END ;
 // DELIMITER ;


delimiter //
create procedure Scheduling (matour varchar(11))
begin
	select * from (select STTngay, Loaihanhdong, null as Madiemdulich, Giobatdau, Gioketthuc, Mota from HanhDongLichtrinhtour where HanhDongLichtrinhtour.Matour = matour
    union select STTNgay, null as Loaihanhdong , Madiemdulich, Thoigianbatdau as Giobatdau, Thoigianketthuc, Mota as Gioketthuc from TourGomDDTQ where TourGomDDTQ.Matour = matour) Temp order by Temp.STTNgay, Temp.Giobatdau, Temp.Gioketthuc;

end; //
delimiter ;


CREATE USER 'sManager'@'%' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON `assignment`.* TO `sManager`@`%`;


