--cau 1
select manv,honv,dem,tennv,ngaysinh,mapb
from nhanvien
where mapb = 4

--cau 2
select manv,honv,dem,tennv,luong
from nhanvien
where luong >= 30000

--cau 3
select manv,honv,dem,tennv,luong,mapb
from nhanvien
where (mapb = 4 and luong >= 25000) or (mapb = 5 and luong >= 30000)

--cau 4
select tennv,ngaysinh,diachi
from nhanvien
where diachi like '%TpHCM'

--cau 5
select honv,dem,tennv,ngaysinh,diachi
from nhanvien
where (honv = 'Nguyen' and dem = 'Bao' and tennv = 'Hung')

--cau 6
select honv,dem,tennv,ngaysinh,diachi
from nhanvien 
where diachi like '%Phu Nhuan, TpHCM'

--cau 7
select honv,dem,tennv,ngaysinh,diachi
from nhanvien
where ngaysinh like '195%'

--cau 8 
select distinct luong
from nhanvien

--cau 9
select manv,honv,dem,tennv,mags
from nhanvien
where mags is null

--cau 10
select phongban.mapb,tenpb,truso
from phongban
join truso_phong on phongban.mapb = truso_phong.mapb

--cau 11
select maql,tenpb,honv,dem,tennv
from phongban
join nhanvien on phongban.maql = nhanvien.manv

--cau 12
select honv,dem,tennv,tentn
from nhanvien,thannhan
where nhanvien.gioitinh= 'F' and tennv = tentn

--cau 13
select tenpb,honv,dem,tennv,diachi
from phongban
join nhanvien on phongban.mapb = nhanvien.mapb
where phongban.mapb = 5

--cau 14
select mada,tenpb,honv,dem,tennv,diachi,ngaysinh
from duan
join phongban on phongban.mapb = duan.mapb
join nhanvien on phongban.maql = nhanvien.manv
where diadiem = 'Go Vap'

--cau 15 
select nhanvien.honv,nhanvien.dem,nhanvien.tennv,NV.honv as hogs,NV.dem,NV.tennv as tengs
from nhanvien , (select * from nhanvien) as NV
where nhanvien.mags = NV.manv

--cau 16
select honv,dem,tennv,luong*1.1
from duan
join thamgia on duan.mada = thamgia.mada
join nhanvien on thamgia.manv = nhanvien.manv
where tenda = 'San pham X'

--cau 17
select honv,dem,tennv,nhanvien.gioitinh,tentn
from nhanvien,thannhan
where tennv = tentn and nhanvien.gioitinh = thannhan.gioitinh

--cau 18
select honv,dem,tennv,duan.mapb,mada
from nhanvien
join duan on nhanvien.mapb = duan.mapb
order by mapb,honv

--cau 19
select count(manv) as 'so luong nhan vien',max(luong) as 'luong cao nhat',min(luong)as 'luong thap nhat',avg(luong)as 'luong trung binh'
from nhanvien
where mapb = 5

--cau 20
select nhanvien.mapb,count(manv) as 'so luong nhan vien'
from nhanvien
group by nhanvien.mapb

--cau 21
select mapb,avg(luong) as 'luong trung binh'
from nhanvien
group by mapb

--cau 22
select thamgia.mada,duan.tenda,count(manv) as 'so luong nhan vien'
from thamgia
join duan on thamgia.mada = duan.mada
group by tenda,thamgia.mada
order by mada

--cau 23
select thamgia.mada,duan.tenda,count(manv) as 'so luong nhan vien'
from thamgia
join duan on thamgia.mada = duan.mada
group by tenda,thamgia.mada
order by mada

--cau 23
select thamgia.mada,duan.tenda,count(manv) as 'so luong nhan vien'
from thamgia
join duan on thamgia.mada = duan.mada
group by tenda,thamgia.mada
having count(manv) > 2
order by mada

--cau 24
select nhanvien.mapb,tenpb,count(manv) as 'so luong nhan vien'
from nhanvien
join phongban on nhanvien.mapb = phongban.mapb
group by tenpb,nhanvien.mapb
having count(manv) > 5
order by mapb

--cau 25
select duan.mada,tenda,count(manv) as 'so luong nhan vien'
from duan
join thamgia on duan.mada = thamgia.mada
group by tenda,duan.mada
order by duan.mada

--cau 26
select duan.mada,tenda,count(nhanvien.manv) as 'so luong nhan vien phong so 5'
from duan
join thamgia on duan.mada = thamgia.mada
join nhanvien on thamgia.manv = nhanvien.manv
where nhanvien.mapb = 5
group by tenda,duan.mada
order by duan.mada

--cau 27
select honv,dem,tennv,count(thannhan.manv) as 'so luong nguoi than'
from nhanvien
join thannhan on nhanvien.manv = thannhan.manv
group by honv,dem,tennv

--cau 28
select tenpb,count(manv) as 'so luong nhan vien'
from nhanvien
join phongban on nhanvien.mapb = phongban.mapb
group by tenpb
having avg(luong) > 30000 

--cau 29
select tenda
from duan 
join thamgia on duan.mada = thamgia.mada
join nhanvien on thamgia.manv = nhanvien.manv
where honv = 'Nguyen'

--cau 30
select tenpb,count(case when gioitinh = 'F' then manv end) as 'so luong nhan vien nu'
from nhanvien
join phongban on nhanvien.mapb = phongban.mapb
group by tenpb
having avg(luong) > 30000 

--cau 31
select honv,dem,tennv
from nhanvien
join thannhan on nhanvien.manv = thannhan.manv
group by thannhan.manv,nhanvien.honv,nhanvien.dem,nhanvien.tennv
having count(thannhan.manv) > 2

--cau 32
select honv,dem,tennv
from nhanvien
left join thannhan on nhanvien.manv = thannhan.manv
where thannhan.manv is NULL
group by thannhan.manv,nhanvien.honv,nhanvien.dem,nhanvien.tennv

--cau 33
select honv,dem,tennv
from nhanvien
join thannhan on nhanvien.manv = thannhan.manv
join phongban on nhanvien.manv = phongban.maql
group by thannhan.manv,nhanvien.honv,nhanvien.dem,nhanvien.tennv
having count(thannhan.manv) >= 1

--cau 34
select honv,dem,tennv
from nhanvien
where luong > (select avg(luong) from nhanvien) and mapb = 5

--cau 35 

--cau 36
select honv,dem,tennv,diachi
from nhanvien
join thamgia on nhanvien.manv = thamgia.manv
join duan on thamgia.mada = duan.mada
join truso_phong on duan.mapb = truso_phong.mapb
where diadiem = 'Phu Nhuan' and truso not like 'Phu Nhuan'
group by honv, dem , tennv, diachi

--cau 37
select 
    nhanvien.manv,honv,dem,tennv
from nhanvien
where not exists (
    select duan.mada 
    from duan
    where not exists (
        select 1 
        from thamgia
        where thamgia.mada = duan.mada and thamgia.manv = nhanvien.manv
    )
)

--cau 38
select 
    nhanvien.manv,honv,dem,tennv
from nhanvien
where not exists (
    select duan.mada 
    from duan
    where mapb = 5 and not exists (
        select 1 
        from thamgia
        where thamgia.mada = duan.mada and thamgia.manv = nhanvien.manv
    )
)