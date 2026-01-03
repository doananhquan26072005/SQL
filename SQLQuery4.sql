-- Cau 1: Lập danh sách mã số, tên và số lượng tồn kho của tất cả các sản phẩm có số lượng tồn kho dưới 100.
select SAN_PHAM.MaSanPham, TenSanPham , SoLuong
from TON_KHO
join SAN_PHAM on TON_KHO.MaSanPham = SAN_PHAM.MaSanPham
where SoLuong < 100 

-- Cau 2: Lập danh sách các đơn nhập hàng đã nhận từ nhà cung cấp Sieu thi Sach.
select MaDonNhap
from DON_NHAP_HANG
join NHA_CUNG_CAP on NHA_CUNG_CAP.MaNhaCungCap = DON_NHAP_HANG.MaNhaCungCap
where TenNhaCungCap = 'Sieu thi Sach'

-- Cau 3: Lập danh sách mã số, tên và số lượng các sản phẩm thuộc danh mục Dien tu có số lượng tại kho WH001 lớn hơn 50 đơn vị.
select TON_KHO.MaSanPham, TenSanPham, Soluong
from TON_KHO
join SAN_PHAM on TON_KHO.MaSanPham = SAN_PHAM.MaSanPham
where MaKho = 'WH001' and TON_KHO.MaSanPham >= 'P00001' and TON_KHO.MaSanPham <= 'P00010' and SoLuong > 50
group by TON_KHO.MaSanPham, TenSanPham, Soluong
 
-- Cau 4: Lập danh sách mã số, tên, mã danh mục của các sản phẩm trong kho WH002 có số lượng trên 50, sắp xếp theo số lượng giảm dần.
select TON_KHO.MaSanPham, TenSanPham, MaDanhMuc , SoLuong
from TON_KHO
join SAN_PHAM on TON_KHO.MaSanPham = SAN_PHAM.MaSanPham
where MaKho = 'WH002' and SoLuong > 50
group by TON_KHO.MaSanPham, TenSanPham, MaDanhMuc , SoLuong
order by SoLuong DESC

-- Cau 5: Lập danh sách tên sản phẩm, số lượng, đơn giá và tên kho của các sản phẩm thuộc danh mục CAT003, sắp xếp theo tên kho tăng dần, theo số lượng giảm dần.
select TenSanPham, SoLuong , DonGia , TenKho
from TON_KHO
join KHO on TON_KHO.MaKho = KHO.MaKho
join SAN_PHAM on TON_KHO.MaSanPham = SAN_PHAM.MaSanPham
where MaDanhMuc = 'CAT003'
group by TenSanPham, SoLuong , DonGia , TenKho
order by TenKho ASC , SoLuong DESC

-- Cau 6: Lập danh sách tên danh mục và tổng số lượng tồn kho của các sản phẩm thuộc danh mục
select MaDanhMuc , sum(SoLuongTon) as 'so luong ton kho danh muc'
from SAN_PHAM
group by MaDanhMuc

-- Cau 7: Lập danh sách các nhà cung cấp có tổng giá trị hàng nhập
    --(dựa trên SoLuong * DonGiaNhap từ các đơn nhập hàng có trạng thái là R) trong tháng 5/2025 lớn 5000. 
    -- Danh sách gồm các thông tin mã số, tên nhà cung cấp và tổng giá trị hàng nhập.
select NHA_CUNG_CAP.MaNhaCungCap , TenNhaCungCap , sum(SoLuong * DonGiaNhap) as 'Tong gia tri nhap'
from NHA_CUNG_CAP
join DON_NHAP_HANG on NHA_CUNG_CAP.MaNhaCungCap = DON_NHAP_HANG.MaNhaCungCap
join CHI_TIET_DON_NHAP on CHI_TIET_DON_NHAP.MaDonNhap = DON_NHAP_HANG.MaDonNhap
where TrangThai = 'R' and NgayDatHang like '2025-05%'
group by NHA_CUNG_CAP.MaNhaCungCap , TenNhaCungCap
having sum(SoLuong * DonGiaNhap) > 5000

-- Cau 8: Lập danh sách mã số, tên và số lượng các sản phẩm có số lượng tại kho WH001 lớn hơn mức trung bình của tất cả các sản phẩm tại kho WH001.
select TON_KHO.MaSanPham, TenSanPham, SoLuong
from TON_KHO
join SAN_PHAM on TON_KHO.MaSanPham = SAN_PHAM.MaSanPham
where MaKho = 'WH001' and SoLuong > (
	select avg(SoLuong)
	from TON_KHO
	where MaKho = 'WH001'
)
group by TON_KHO.MaSanPham, TenSanPham, SoLuong

-- Cau 9: Lập danh sách các kho có tổng số lượng sản phẩm đã nhập lớn hơn số lượng tồn kho trung bình của tất cả sản phẩm trong danh mục Thuc pham. Danh sách gồm các thông tin mã số kho, tên kho và tổng số lượng sản phẩm đã nhập.
select KHO.MaKho, TenKho, sum(SoLuong) as 'tong so luong da nhap'
from TON_KHO
join KHO on TON_KHO.MaKho = KHO.MaKho
group by KHO.MaKho, TenKho
having sum(SoLuong) > (
	select avg(SoLuongTon)
	from SAN_PHAM
	where MaDanhMuc = 'CAT003'
)

-- Cau 9: Lập danh sách các kho có tổng số lượng sản phẩm đã nhập lớn hơn số lượng tồn kho trung bình của tất cả sản phẩm trong danh mục Thuc pham.
SELECT k.MaKho, k.TenKho, SUM(ctdn.SoLuong) AS TongSoLuongNhap
FROM Kho k
JOIN DonNhap dn ON k.MaKho = dn.MaKhoNhan
JOIN ChiTietDonNhap ctdn ON dn.MaDonNhap = ctdn.MaDonNhap
GROUP BY k.MaKho, k.TenKho
HAVING SUM(ctdn.SoLuong) > (
    SELECT AVG(tk.SoLuong)
    FROM TonKho tk
    JOIN SanPham sp ON tk.MaSP = sp.MaSP
    JOIN DanhMuc dm ON sp.MaDM = dm.MaDM
    WHERE dm.TenDM = 'Thuc pham'
);

-- Cau 10: Lập danh sách các danh mục sản phẩm có tổng giá trị hàng nhập trong tháng 5/2025 lớn hơn mức trung bình trong cùng tháng của tất cả các danh mục.
SELECT dm.MaDM, dm.TenDM, SUM(ctdn.SoLuong * ctdn.DonGiaNhap) AS TongGiaTriNhap
FROM DanhMuc dm
JOIN SanPham sp ON dm.MaDM = sp.MaDM
JOIN ChiTietDonNhap ctdn ON sp.MaSP = ctdn.MaSP
JOIN DonNhap dn ON ctdn.MaDonNhap = dn.MaDonNhap
WHERE dn.TrangThai = 'R'
  AND YEAR(dn.NgayNhap) = 2025
  AND MONTH(dn.NgayNhap) = 5
GROUP BY dm.MaDM, dm.TenDM
HAVING SUM(ctdn.SoLuong * ctdn.DonGiaNhap) > (
    SELECT AVG(TotalValue)
    FROM (
        SELECT SUM(ctdn2.SoLuong * ctdn2.DonGiaNhap) AS TotalValue
        FROM ChiTietDonNhap ctdn2
        JOIN DonNhap dn2 ON ctdn2.MaDonNhap = dn2.MaDonNhap
        WHERE dn2.TrangThai = 'R'
          AND YEAR(dn2.NgayNhap) = 2025
          AND MONTH(dn2.NgayNhap) = 5
        GROUP BY ctdn2.MaSP
    ) AS CategoryValues
);