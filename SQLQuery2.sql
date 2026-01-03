--cau 1
select matb,tentuyen,culy,tendonvi
from tuyenbuyt,dvvanhanh
where culy > 20000

--cau 2
select tramdung.matd,tentram,matb
from tramdung,lotrinh
where diadiem like '%HAM NGHI, QUAN 1'
group by tramdung.matd,tentram,matb

--cau 3
select tramdung.matd,tentram,loai
from tramdung,lotrinh
where diadiem like '%QUAN 12' and matb = 3
group by tramdung.matd,tentram,loai

--cau 4
select tramdung.matd,tentram,loai
from tramdung,lotrinh
where thututram = 1

--cau 5
select tuyenbuyt.matb,tentuyen
from tuyenbuyt,lotrinh
where matd = 4

--cau 6
select distinct tendonvi
from dvvanhanh,tuyenbuyt,lotrinh
where matd = 53

--cau 7
select tuyenbuyt.matb,tentuyen,culy,tentram as 'tram dung khoi hanh'
from tuyenbuyt
join lotrinh on tuyenbuyt.matb = lotrinh.matb
join tramdung on lotrinh.matd = tramdung.matd
where sochuyen < 250 and thututram = 1

--cau 8
select tuyenbuyt.matb,tentuyen
from tuyenbuyt,lotrinh
where matd = 7 

--cau 9
select tuyenbuyt.matb,tentuyen,culy,thututram,tentram,diadiem
from tuyenbuyt
join lotrinh on tuyenbuyt.matb = lotrinh.matb
join tramdung on lotrinh.matd = tramdung.matd
where madv = 2
order by matb , thututram

--cau 10
select distinct tuyenbuyt.matb,tentuyen
from tuyenbuyt,lotrinh,tramdung
where diadiem like '%DEN THO AN GIAO PASTEUR, QUAN 1'

--cau 11
select tramdung.matd,tentram,diadiem,matb
from tramdung
join lotrinh on tramdung.matd = lotrinh.matd
where diadiem like '%QUAN 1'
order by tentram,matb

--cau 12
select tendonvi,tuyenbuyt.matb,culy
from dvvanhanh,tuyenbuyt
join lotrinh on tuyenbuyt.matb = lotrinh.matb
where matd = 36
order by tendonvi,tuyenbuyt.matb

--cau 13
select tendonvi,count(matb) as 'so luong tuyen xe'
from dvvanhanh
join tuyenbuyt on dvvanhanh.madv = tuyenbuyt.madv
group by tendonvi
having count(matb) < 2

--cau 14
select tuyenbuyt.matb,tentuyen,culy,count(tramdung.matd) as 'tong tram dung'
from tuyenbuyt
join lotrinh on tuyenbuyt.matb = lotrinh.matb
join tramdung on lotrinh.matd = tramdung.matd
group by tuyenbuyt.matb,tentuyen,culy
having count(tramdung.matd) < 40

--cau 15
select tramdung.matd,tentram,count(distinct tuyenbuyt.matb) as 'tong tuyen buyt di qua'
from tramdung
join lotrinh on tramdung.matd = lotrinh.matd
join tuyenbuyt on lotrinh.matb = tuyenbuyt.matb
group by tramdung.matd,tentram
having count(distinct tuyenbuyt.matb) > 1

--cau 16
select tramdung.matd,count(distinct tuyenbuyt.matb) as 'tong tuyen buyt di qua'
from tramdung
left join lotrinh on tramdung.matd = lotrinh.matd
left join tuyenbuyt on lotrinh.matb = tuyenbuyt.matb
group by tramdung.matd

--cau 17
select lotrinh.matb,loai,count(tramdung.matd) as 'tong tram dung thuoc loai nay'
from lotrinh
join tramdung on lotrinh.matb = tramdung.matd
group by lotrinh.matb,loai

--cau 18
select lotrinh.matb,count(tramdung.matd) as 'tong tram dung thuoc loai Nha cho'
from lotrinh
join tramdung on lotrinh.matb = tramdung.matd
where loai = 'NHA CHO'
group by lotrinh.matb

--cau 19
select matb,tentuyen,culy
from tuyenbuyt
where culy = (select max(culy) from tuyenbuyt)

--cau 20
select top 10 tramdung.matd,tentram,count(distinct matb) as 'so tuyen buyt di qua'
from tramdung
join lotrinh on tramdung.matd = lotrinh.matd
group by tramdung.matd,tentram
order by count(distinct matb) desc

--cau 21
select top 1 tuyenbuyt.matb,tentuyen,count(distinct tramdung.matd) as 'so tram dung'
from tuyenbuyt
join lotrinh on tuyenbuyt.matb = lotrinh.matb
join tramdung on lotrinh.matd = tramdung.matd
group by tuyenbuyt.matb,tentuyen
order by count(distinct tramdung.matd) desc

--cau 22
select top 1 dvvanhanh.madv,tendonvi,count(distinct tuyenbuyt.matb) as 'so tuyen buyt'
from dvvanhanh
join tuyenbuyt on dvvanhanh.madv = tuyenbuyt.madv
group by dvvanhanh.madv,tendonvi
order by count(distinct tuyenbuyt.matb) desc

--cau 23
select tuyenbuyt.matb,tentuyen
from tuyenbuyt
join lotrinh lt1 on tuyenbuyt.matb = lt1.matb
join tramdung td1 on lt1.matd = td1.matd and td1.tentram = 'TDH XE BUYT SAI GON'

join lotrinh lt2 on tuyenbuyt.matb = lt2.matb
join tramdung td2 on lt2.matd = td2.matd and td2.tentram = 'CONG VIEN 30/4'

--cau 24
select tuyenbuyt.matb,tentuyen
from tuyenbuyt
join lotrinh lt1 on tuyenbuyt.matb = lt1.matb
join tramdung td1 on lt1.matd = td1.matd and td1.matd = 31

join lotrinh lt2 on tuyenbuyt.matb = lt2.matb
join tramdung td2 on lt2.matd = td2.matd and td2.matd = 35

join lotrinh lt3 on tuyenbuyt.matb = lt3.matb
join tramdung td3 on lt3.matd = td3.matd and td3.matd = 81
