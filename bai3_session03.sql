create database demo_b3_ss03;
use demo_b3_ss03;

CREATE TABLE VatTu(
maVT INT AUTO_INCREMENT PRIMARY KEY,
tenVT VARCHAR(255) UNIQUE
);

CREATE TABLE PhieuXuat(
soPx INT AUTO_INCREMENT PRIMARY KEY,
ngayXuat DATETIME
);

CREATE TABLE PhieuNhap(
soPn INT AUTO_INCREMENT PRIMARY KEY,
ngayNhap DATETIME
);

CREATE TABLE NgayCungCap(
maNCC INT AUTO_INCREMENT PRIMARY KEY,
tenNCC VARCHAR(255),
diaChi VARCHAR(255),
soDienThoai VARCHAR(11) UNIQUE
);

CREATE TABLE PhieuXuatChiTiet(
soPx INT,
maVT INT,
donGiaXuat DOUBLE,
soLuongXuat INT CHECK(soLuongXuat > 0),
FOREIGN KEY(soPx) REFERENCES PhieuXuat(soPx),
FOREIGN KEY(maVT) REFERENCES VatTu(maVT) 
);

CREATE TABLE PhieuNhapChiTiet(
soPn INT,
maVT INT,
donGiaNhap DOUBLE CHECK(donGiaNhap > 0),
soLuongNhap INT check(soLuongNhap > 0),
FOREIGN KEY(soPn) REFERENCES PhieuNhap(soPn),
FOREIGN KEY(maVT) REFERENCES VatTu(maVT)
);

CREATE TABLE ChiTietDonDatHang(
maVT INT,
soDH INT AUTO_INCREMENT PRIMARY KEY,
FOREIGN KEY(maVT) REFERENCES VatTu(maVT)
);

CREATE TABLE DonDatHang(
soDH INT,
maNCC INT,
ngayDH DATETIME,
FOREIGN KEY(soDH) REFERENCES ChiTietDonDatHang(soDH),
FOREIGN KEY(maNCC) REFERENCES NgayCungCap(maNCC)
);

-- Nhập dữ liệu
INSERT INTO vattu (tenVT) VALUES
('Gang'), 
('Sắt'), 
('Thép'), 
('Nhôm'), 
('Thép không gỉ');

INSERT INTO PhieuXuat (ngayXuat) VALUES 
('2024-09-01 08:00:00'), 
('2024-09-05 09:30:00'), 
('2024-09-10 10:15:00'), 
('2024-09-12 14:45:00'), 
('2024-09-15 16:20:00');

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`demo_b3_ss03`.`phieunhapchitiet`, CONSTRAINT `phieunhapchitiet_ibfk_1` FOREIGN KEY (`soPn`) REFERENCES `phieunhap` (`soPn`))


INSERT INTO PhieuXuatChiTiet (soPx, maVT, donGiaXuat, soLuongXuat) VALUES 
(1, 1, 50000, 100), 
(2, 2, 60000, 50), 
(3, 3, 45000, 120), 
(4, 4, 55000, 70), 
(5, 5, 70000, 80);

INSERT INTO PhieuNhap (ngayNhap) VALUES 

('2023-02-12 17:10:00');


INSERT INTO PhieuNhapChiTiet (soPN, maVT, soLuongNhap, donGiaNhap) VALUES 
(1, 1, 20, 30000), 
(1, 2, 30, 50000), 
(1, 3, 30, 35000), 
(1, 4, 50, 40000), 
(1, 5, 40, 30000);

INSERT INTO NgayCungCap (tenNCC, diaChi, soDienThoai) VALUES 
('Công ty A', 'Hà Nội', '0123456789'), 
('Công ty B', 'TP.HCM', '0987654321'), 
('Công ty C', 'Đà Nẵng', '0912345678'), 
('Công ty D', 'Hải Phòng', '0976543210'), 
('Công ty E', 'Cần Thơ', '0932123456');

INSERT INTO ChiTietDondatHang (maVT) VALUES 
(1), 
(2), 
(3), 
(4), 
(5);

INSERT INTO DonDatHang (soDH, maNCC,ngayDH) VALUES 
(1, 1,'2024-09-13'), 
(2, 2,'2024-09-15'), 
(3, 3,'2024-08-13'), 
(4, 4,'2024-01-13'), 
(5, 5,'2024-02-13');

-- 1. danh sách vật tư bán chạy
SELECT vt.*,sum(pxct.soluongxuat) as quantity from vattu as vt
join phieuxuatchitiet as pxct on vt.mavt = pxct.mavt
group by vt.maVT ORDER BY quantity desc LIMIT 3;

-- 2. Tìm danh sách vật tư có trong kho nhiều nhất
SELECT vt.*,sum(pnct.soluongnhap) - sum(pxct.soluongxuat) as quantity from vattu vt
join phieunhapchitiet pnct on vt.maVT = pnct.maVT
join phieuxuatchitiet pxct on vt.maVT = pxct.maVT
GROUP BY vt.maVT ORDER BY quantity desc;

-- % vs _


-- phạm văn huỳnh

SELECT * from vattu where tenVT like '%a%';
