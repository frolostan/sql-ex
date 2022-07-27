/*
����� �� ������� �� ������� ������:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, price, screen)
Printer(code, model, color, type, price)
������� Product ������������ ������������� (maker), ����� ������ (model) � ��� ('PC' - ��, 'Laptop' - ��-������� ��� 'Printer' - �������). ��������������, ��� ������ ������� � ������� Product ��������� ��� ���� �������������� � ����� ���������. � ������� PC ��� ������� ��, ���������� ������������� ���������� ����� � code, ������� ������ � model (������� ���� � ������� Product), �������� - speed (���������� � ����������), ����� ������ - ram (� ����������), ������ ����� - hd (� ����������), �������� ������������ ���������� - cd (��������, '4x') � ���� - price (� ��������). ������� Laptop ���������� ������� �� �� ����������� ����, ��� ������ �������� CD �������� ������ ������ -screen (� ������). � ������� Printer ��� ������ ������ �������� �����������, �������� �� �� ������� - color ('y', ���� �������), ��� �������� - type (�������� � 'Laser', �������� � 'Jet' ��� ��������� � 'Matrix') � ���� - price.
*/


-- �������: 1 (Serge I: 2002-09-30)
-- ������� ����� ������, �������� � ������ �������� ����� ��� ���� �� ���������� ����� 500 ���. �������: model, speed � hd

select model, speed, hd from PC where price < 500

-- �������: 2 (Serge I: 2002-09-21)
-- ������� �������������� ���������. �������: maker

select distinct maker from product where type = 'printer'

-- �������: 3 (Serge I: 2002-09-30)
-- ������� ����� ������, ����� ������ � ������� ������� ��-���������, ���� ������� ��������� 1000 ���.

Select model, ram, screen from laptop where price > 1000

-- �������: 4 (Serge I: 2002-09-21)
-- ������� ��� ������ ������� Printer ��� ������� ���������.

select * from printer where color = 'y'

-- �������: 5 (Serge I: 2002-09-30)
-- ������� ����� ������, �������� � ������ �������� ����� ��, ������� 12x ��� 24x CD � ���� ����� 600 ���

Select model, speed, hd from pc where cd = '12x' and price < 600 or cd = '24x' and price < 600

-- �������: 9 (Serge I: 2002-11-02)
-- ������� �������������� �� � ����������� �� ����� 450 ���. �������: Maker

select distinct p.maker from product p join pc on p.model = pc.model and pc.speed >=450

-- �������: 10 (Serge I: 2002-09-23)
-- ������� ������ ���������, ������� ����� ������� ����. �������: model, price

select model, price from printer where price = (select max(price) from printer)

-- �������: 11 (Serge I: 2002-11-02)
-- ������� ������� �������� ��.

Select avg(speed) from pc

-- �������: 12 (Serge I: 2002-11-02)
-- ������� ������� �������� ��-���������, ���� ������� ��������� 1000 ���.

Select avg(speed) from laptop where price > 1000

-- �������: 13 (Serge I: 2002-11-02)
-- ������� ������� �������� ��, ���������� �������������� A.

select avg(pc.speed) from pc join product p on pc.model = p.model where p.maker = 'A' group by p.maker

-- �������: 6 (Serge I: 2002-10-28)
-- ��� ������� �������������, ������������ ��-�������� c ������� �������� ����� �� ����� 10 �����, ����� �������� ����� ��-���������. �����: �������������, ��������.

select distinct p.maker, lt.speed  
from product p join laptop lt 
on p.model = lt.model and 	
lt.hd >=10

-- �������: 7 (Serge I: 2002-11-02)
-- ������� ������ ������� � ���� ���� ��������� � ������� ��������� (������ ����) ������������� B (��������� �����).

select distinct p.model, pc.price from product p  join pc on p.model = pc.model and p.maker = 'B' 
union
select distinct p.model, lt.price from product p  join laptop lt on p.model = lt.model and p.maker = 'B'
union 
select distinct p.model, pr.price from product p  join printer pr on p.model = pr.model and p.maker = 'B'

-- �������: 8 (Serge I: 2003-02-03)
-- ������� �������������, ������������ ��, �� �� ��-��������.

select maker from product where type = 'pc'
except
select maker from product where type = 'laptop'

-- �������: 19 (Serge I: 2003-02-13)
-- ��� ������� �������������, �������� ������ � ������� Laptop, ������� ������� ������ ������ ����������� �� ��-���������.
-- �������: maker, ������� ������ ������.

select p.maker, avg(lt.screen) from product p inner join laptop lt on p.model=lt.model group by p.maker

-- �������: 20 (Serge I: 2003-02-13)
-- ������� ��������������, ����������� �� ������� ���� ��� ��������� ������ ��. �������: Maker, ����� ������� ��.

select p.maker, count(p.model) count_model from product p where p.type='pc' group by p.maker having count(distinct p.model)>=3

-- �������: 21 (Serge I: 2003-02-13)
-- ������� ������������ ���� ��, ����������� ������ ��������������, � �������� ���� ������ � ������� PC.
-- �������: maker, ������������ ����.

select p.maker, max(pc.price) from product p inner join pc on p.model=pc.model group by p.maker

-- �������: 22 (Serge I: 2003-02-13)
-- ��� ������� �������� �������� ��, ������������ 600 ���, ���������� ������� ���� �� � ����� �� ���������. �������: speed, ������� ����.

Select pc.speed, avg(pc.price) from pc where pc.speed>600 group by pc.speed

-- �������: 23 (Serge I: 2003-02-14)
-- ������� ��������������, ������� ����������� �� ��� ��
-- �� ��������� �� ����� 750 ���, ��� � ��-�������� �� ��������� �� ����� 750 ���.
-- �������: Maker

select p.maker from product p inner join pc on p.model=pc.model where pc.speed>=750 
intersect 
select p.maker from product p inner join laptop lt on p.model=lt.model where lt.speed>=750

-- �������: 24 (Serge I: 2003-02-03)
-- ����������� ������ ������� ����� �����, ������� ����� ������� ���� �� ���� ��������� � ���� ������ ���������.

with cte(model, price) as
(select model, price from pc
union 
select model,price from laptop
union 
select model,price from printer)
select model from cte where price = ( select max(price) from cte)

-- �������: 15 (Serge I: 2003-02-03)
-- ������� ������� ������� ������, ����������� � ���� � ����� PC. �������: HD

select hd from pc group by hd having count(hd)>=2

-- �������: 16 (Serge I: 2003-02-03)
-- ������� ���� ������� PC, ������� ���������� �������� � RAM. � ���������� ������ ���� ����������� ������ ���� ���, �.�. (i,j), �� �� (j,i), ������� ������: ������ � ������� �������, ������ � ������� �������, �������� � RAM.

select distinct a2.model, a1.model, a1.speed, a1.ram from pc as a1, pc a2 where a1.speed=a2.speed and a1.ram=a2.ram and a2.model>a1.model

-- �������: 17 (Serge I: 2003-02-03)
-- ������� ������ ��-���������, �������� ������� ������ �������� ������� �� ��.
-- �������: type, model, speed

select  distinct p.type, lt.model, lt.speed from laptop as lt, pc pc, product p  where lt.speed<all (select speed from pc) and p.model=lt.model

-- �������: 18 (Serge I: 2003-02-03)
-- ������� �������������� ����� ������� ������� ���������. �������: maker, price

select p.maker, pr.price from product p inner join printer pr on p.model=pr.model where pr.color='y'
group by p.maker, pr.color, pr.price
having pr.price in (select min(price) from printer where color = 'y')



/*
��������������� �� ��������, ������������� �� ������ ������� �����. ������� ��������� ���������:
Classes (class, type, country, numGuns, bore, displacement)
Ships (name, class, launched)
Battles (name, date)
Outcomes (ship, battle, result)
������� � ��������� ��������� �� ������ � ���� �� �������, � ������ ������������� ���� ��� ������� �������, ������������ �� ������� �������, ���� �������� ������ ������ ��� �������, ������� �� ��������� �� � ����� �� �������� � ��. �������, ������ �������� ������, ���������� ��������.
��������� Classes �������� ��� ������, ��� (bb ��� ������� (���������) ������� ��� bc ��� ������� ��������), ������, � ������� �������� �������, ����� ������� ������, ������ ������ (������� ������ ������ � ������) � ������������� ( ��� � ������). � ��������� Ships �������� �������� �������, ��� ��� ������ � ��� ������ �� ����. � ��������� Battles �������� �������� � ���� �����, � ������� ����������� �������, � � ��������� Outcomes � ��������� ������� ������� ������� � ����� (��������-sunk, ��������� - damaged ��� �������� - OK).
���������. 1) � ��������� Outcomes ����� ������� �������, ������������� � ��������� Ships. 2) ����������� ������� � ����������� ������ ������� �� ���������.
*/

-- �������: 14 (Serge I: 2002-11-05)
-- ������� �����, ��� � ������ ��� �������� �� ������� Ships, ������� �� ����� 10 ������.

select c.class, s.name, c.country from classes c inner join ships s on c.class=s.class where numGUNS>=10

-- �������: 33 (Serge I: 2002-11-02)
-- ������� �������, ����������� � ��������� � �������� ��������� (North Atlantic). �����: ship.

select ship from outcomes where battle = 'north atlantic' and result = 'sunk'
 
/*
 ����� �� ������� �� ������� ���������:
Company (ID_comp, name)
Trip(trip_no, ID_comp, plane, town_from, town_to, time_out, time_in)
Passenger(ID_psg, name)
Pass_in_trip(trip_no, date, ID_psg, place)
������� Company �������� ������������� � �������� ��������, �������������� ��������� ����������. ������� Trip �������� ���������� � ������: ����� �����, ������������� ��������, ��� ��������, ����� �����������, ����� ��������, ����� ����������� � ����� ��������. ������� Passenger �������� ������������� � ��� ���������. ������� Pass_in_trip �������� ���������� � �������: ����� �����, ���� ������ (����), ������������� ��������� � �����, �� ������� �� ����� �� ����� ������. ��� ���� ������� ����� � ����, ���
- ����� ����������� ���������, � ������������ ������ ������ ����� ����� �����; town_from <> town_to;
- ����� � ���� ����������� ������������ ������ �������� �����;
- ����� ����������� � �������� ����������� � ��������� �� ������;
- ����� ���������� ����� ���� ������������ (���������� �������� ���� name, ��������, Bruce Willis);
- ����� ����� � ������ � ��� ����� � ������; ����� ���������� ����� ����, ����� (a � d) � ����� � ���� ����� ������� � ���������� �������;
- ����� � ����������� �������� �� ����� ������.
 */
 
--  �������: 63 (Serge I: 2003-04-08)
-- ���������� ����� ������ ����������, �����-���� �������� �� ����� � ��� �� ����� ����� ������ ����.
 
select name from passenger where ID_psg IN (select pt.ID_psg from pass_in_trip pt group by pt.place, pt.ID_psg having count(pt.place)>1)

 


