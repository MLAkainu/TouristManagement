-- I.1

SELECT SoLuongKhach ('CN1-000002', '2023-08-25');
SELECT SoLuongKhach ('CN1-000005', '2023-09-02');

-- I.2
CALL InLichTrinhChuyenDi('CN4-000001','2023-05-25');
CALL InLichTrinhChuyenDi('CN1-000002','2023-08-25');
CALL InLichTrinhChuyenDi('CN1-000005','2023-08-25');

-- I.3
 CALL ThongKeDoanhThu(2023);
 
 -- II.1
 
 -- Updatetonggia khi insert 1 phieudangky là khach hang le tre em 
SELECT * FROM ChuyenDi WHERE  Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-08-26';
INSERT INTO PhieuDangKy VALUES
('', '2023-08-12', '', 'VP0119', 'KH0012', NULL , 'CN1-000002', '2023-08-26');
SELECT * FROM ChuyenDi WHERE  Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-08-26';
SELECT * FROM KhachHang WHERE MaKhachHang = 'KH0012';
SELECT * FROM TOUR WHERE Matour = 'CN1-000002';
-- Update tonggia khi insert 1 phieudangky la khach hang nguoi lon
SELECT * FROM ChuyenDi WHERE  Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-08-26';
INSERT INTO PhieuDangKy VALUES
('', '2023-08-12', '', 'VP0119', 'KH0032', NULL , 'CN1-000002', '2023-08-26');
SELECT * FROM ChuyenDi WHERE  Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-08-26';
SELECT * FROM KhachHang WHERE MaKhachHang = 'KH0032';
SELECT * FROM TOUR WHERE Matour = 'CN1-000002';
-- Update tonggia khi insert 1 phieudangky la khach doan
SELECT * FROM ChuyenDi WHERE  Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-08-26';
INSERT INTO PhieuDangKy VALUES
('', '2023-08-12', '', 'VP0119', NULL, 'KD0006' , 'CN1-000002', '2023-08-26');
SELECT * FROM ChuyenDi WHERE  Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-08-26';
SELECT * FROM khachdoangomkhachle WHERE Madoan = 'KD0006';

-- Update tonggia khi delete 1 phieudangky voi chuyen đi chưa đi
SELECT * FROM ChuyenDi WHERE  Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-08-26';
DELETE FROM PhieuDangKy WHERE Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-08-26' AND Makhachdoan = 'KD0006';
SELECT * FROM ChuyenDi WHERE  Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-08-26';
-- Update tonggia khi delete 1 phieudangky đã đi
SELECT * FROM ChuyenDi WHERE  Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-06-25';
DELETE FROM PhieuDangKy WHERE Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-06-25' AND Makhachle = 'KH0010';
SELECT * FROM ChuyenDi WHERE  Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-06-25';
SELECT * FROM PhieuDangKy WHERE Matour = 'CN1-000002' AND Ngaykhoihanh = '2023-06-25' AND Makhachle = 'KH0010';

-- insert vao lichtrinhtour
insert into Lichtrinhtour value ('CN1-000002', 2);

-- insert vao Lich Trinh Chuyen record co STTNgay không đúng với STTNgay trong LichTrinhTour
insert into LichTrinhChuyen value ('CN1-000002','2023-08-25',3);

-- insert vao Lich Trinh Chuyen record khong co van de gi
insert into LichTrinhChuyen value ('CN1-000002','2023-08-25',2);

-- insert vao hanhdonglichtrinhtour mot hoat dong trong ngay thu 2
insert into HanhDongLichtrinhtour value ('CN1-000002', '2', '4', '11:30:00', '13:00:00', '');

-- insert vao DVCCDVChuyen record co Matour khong tim thay
insert into DVCCDVChuyen value ('CN1-000020', '2023-08-25', '1', '4', 'DV0032');

-- insert vao DCCDVChuyen record co STTNgay không đúng với STTNgay trong HanhDongLichTrinhTour
insert into DVCCDVChuyen value ('CN1-000020', '2023-08-25', '3', '4', 'DV0032');

-- insert vao DCCDVChuyen record co Loại không đúng với Hành động Lịch trình tour.
insert into DVCCDVChuyen value ('CN1-000002', '2023-08-25', '2', '2', 'DV0032');

-- insert vao DCCDVChuyen record hop le (khong phai don vi van chuyen)
insert into DVCCDVChuyen value ('CN1-000002', '2023-08-25', '2', '4', 'DV0032');

-- insert vao DCCDVChuyen record hop le la don vi van chuyen
insert into DVCCDVChuyen value ('CN1-000002', '2023-08-25', '2', '8', 'DV0032');


