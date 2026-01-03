--Ma so : 23110111
--Ho ten: Doan Anh Quan
--RDBMS: SQL Sever

--1. Lập danh sách mã số, tên, đơn giá và số lượng tồn của các sản phẩm có đơn giá lớn hơn 100 và số lượng tồn kho dưới 50.
select SAN_PHAM.MaSanPham, TenSanPham , DonGia, SoLuongTon
from SAN_PHAM 
where SoLuongTon < 50 and DonGia > 100 

--2. Lập danh sách mã số, ngày đặt hàng, tổng tiền, tên nhà cung cấp của các đơn nhập hàng có trạng thái đã nhập vào kho WH002.
select MaDonNhap , NgayDatHang , TongTien , TenNhaCungCap
from DON_NHAP_HANG
join NHA_CUNG_CAP on DON_NHAP_HANG.MaNhaCungCap = NHA_CUNG_CAP.MaNhaCungCap
where TrangThai = 'R' and MaKho = 'WH002'
group by MaDonNhap , NgayDatHang , TongTien , TenNhaCungCap 

--3. Lập danh sách mã số, tên và số lượng của các sản phẩm thuộc danh mục Thuc pham có số lượng tại kho WH003 lớn hơn 100.
select TON_KHO.MaSanPham , TenSanPham , Soluong
from TON_KHO 
join SAN_PHAM on TON_KHO.MaSanPham = SAN_PHAM.MaSanPham
where MaKho = 'WH003' and SoLuong > 100
group by TON_KHO.MaSanPham , TenSanPham , Soluong

--4. Lập danh sách mã số, ngày đặt hàng, tổng tiền và tên nhà cung cấp của các đơn nhập hàng được đặt trong tháng 5/2025 có tổng tiền trên 2000 và đang chờ giao hàng. Sắp xếp kết quả theo tổng tiền giảm.
select MaDonNhap , NgayDatHang , TongTien , TenNhaCungCap
from DON_NHAP_HANG
join NHA_CUNG_CAP on DON_NHAP_HANG.MaNhaCungCap = NHA_CUNG_CAP.MaNhaCungCap
where NgayDatHang like '2025-05%' and TongTien > 2000 and TrangThai = 'P'
group by MaDonNhap , NgayDatHang , TongTien , TenNhaCungCap

--5. Lập danh sách các chi tiết đơn hàng có số lượng nhập lớn hơn 100 từ các đơn nhập hàng đã nhập kho trong tháng 5/2025 cho danh mục CAT003. Danh sách gồm các thông tin mã đơn nhập, tên sản phẩm, mã kho, và số lượng nhập. Sắp xếp kết quả theo mã kho tăng, số lượng nhập giảm.
select CHI_TIET_DON_NHAP.MaDonNhap , TenSanPham , MaKho , Soluong
from CHI_TIET_DON_NHAP
join SAN_PHAM on CHI_TIET_DON_NHAP.MaSanPham = SAN_PHAM.MaSanPham
join DON_NHAP_HANG on CHI_TIET_DON_NHAP.MaDonNhap = DON_NHAP_HANG.MaDonNhap
where Soluong > 100 and NgayDatHang like '2025-05%' and MaDanhMuc = 'CAT003'
order by MaKho ASC , Soluong DESC

--6. Lập danh sách mã số, tên và tổng số tiền từ các đơn nhập hàng đã nhập trong tháng 5/2025 của các nhà cung cấp.
select MaDonNhap , TenNhaCungCap , TongTien
from DON_NHAP_HANG
join NHA_CUNG_CAP on DON_NHAP_HANG.MaNhaCungCap = NHA_CUNG_CAP.MaNhaCungCap
where NgayDatHang like '2025-05%'

--7. Lập danh sách mã số, tên và tổng số lượng của các sản phẩm đang chờ giao hàng (từ các đơn nhập hàng có trạng thái là P) trong tháng 5/2025 với tổng tiền hàng (dựa trên SoLuong * DonGiaNhap) trên 2000.
select SAN_PHAM.MaSanPham , TenSanPham , SoLuong
from CHI_TIET_DON_NHAP
join SAN_PHAM on CHI_TIET_DON_NHAP.MaSanPham = SAN_PHAM.MaSanPham
join DON_NHAP_HANG on CHI_TIET_DON_NHAP.MaDonNhap = DON_NHAP_HANG.MaDonNhap
where TrangThai = 'P' and NgayDatHang like '2025-05%' and (SoLuong * DonGiaNhap) > 2000

--8. Với mỗi nhà cung cấp, cho biết mã số, tên, tổng số đơn hàng đã nhập trong tháng 5/2025 và tổng số tiền từ các đơn hàng đã nhập.
select NHA_CUNG_CAP.MaNhaCungCap , TenNhaCungCap , count(MaDonNhap) as 'tong don hang da nhap' , sum(TongTien) as 'tong tien da nhap'
from NHA_CUNG_CAP
join DON_NHAP_HANG on NHA_CUNG_CAP.MaNhaCungCap = DON_NHAP_HANG.MaNhaCungCap
where NgayDatHang like '2025-05%' and TrangThai = 'R'
group by NHA_CUNG_CAP.MaNhaCungCap ,TenNhaCungCap

--9. Lập danh sách các kho có tổng số lượng sản phẩm đã nhập lớn hơn số lượng tồn kho trung bình của tất cả sản phẩm trong danh mục Thuc pham. Danh sách gồm các thông tin mã số kho, tên kho và tổng số lượng sản phẩm đã nhập.
select KHO.MaKho, TenKho, sum(SoLuong) as 'tong so luong da nhap'
from TON_KHO
join KHO on TON_KHO.MaKho = KHO.MaKho
group by KHO.MaKho, TenKho
having sum(SoLuong) > (
	select avg(SoLuongTon)
	from SAN_PHAM
	join DANH_MUC on DANH_MUC.MaDanhMuc = SAN_PHAM.MaDanhMuc
	where TenDanhMuc = 'Thuc pham'
)

--10. Lập danh sách các danh mục sản phẩm có tổng giá trị hàng nhập (dựa trên SoLuong * DonGiaNhap của các đơn nhập hàng có trạng thái là R)trong tháng 5/2025 lớn hơn mức trung bình trong cùng tháng của tất cả các danh mục. Danh sách gồm các thông tin mã danh mục, tên danh mục, tổng giá trịhàng nhập.
select DANH_MUC.MaDanhMuc, TenDanhMuc , sum(SoLuong * DonGiaNhap) as 'tong gia tri nhap'
from DANH_MUC
join SAN_PHAM on DANH_MUC.MaDanhMuc = SAN_PHAM.MaDanhMuc
join CHI_TIET_DON_NHAP on SAN_PHAM.MaSanPham = CHI_TIET_DON_NHAP.MaSanPham
join DON_NHAP_HANG on CHI_TIET_DON_NHAP.MaDonNhap = DON_NHAP_HANG.MaDonNhap
where NgayDatHang like '2025-05%' 
group by DANH_MUC.MaDanhMuc, TenDanhMuc
having sum(SoLuong * DonGiaNhap) > (
	select avg(tong)
	from(
		select DANH_MUC.MaDanhMuc, sum(SoLuong * DonGiaNhap) as tong
		from DANH_MUC
		join SAN_PHAM on DANH_MUC.MaDanhMuc = SAN_PHAM.MaDanhMuc
		join CHI_TIET_DON_NHAP on SAN_PHAM.MaSanPham = CHI_TIET_DON_NHAP.MaSanPham
		join DON_NHAP_HANG on CHI_TIET_DON_NHAP.MaDonNhap = DON_NHAP_HANG.MaDonNhap
		where NgayDatHang like '2025-05%'
		group by DANH_MUC.MaDanhMuc
		) as new_table
)
