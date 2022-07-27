/*
Схема БД состоит из четырех таблиц:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, price, screen)
Printer(code, model, color, type, price)
Таблица Product представляет производителя (maker), номер модели (model) и тип ('PC' - ПК, 'Laptop' - ПК-блокнот или 'Printer' - принтер). Предполагается, что номера моделей в таблице Product уникальны для всех производителей и типов продуктов. В таблице PC для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице Product), скорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), скорость считывающего устройства - cd (например, '4x') и цена - price (в долларах). Таблица Laptop аналогична таблице РС за исключением того, что вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице Printer для каждой модели принтера указывается, является ли он цветным - color ('y', если цветной), тип принтера - type (лазерный – 'Laser', струйный – 'Jet' или матричный – 'Matrix') и цена - price.
*/


-- Задание: 1 (Serge I: 2002-09-30)
-- Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd

select model, speed, hd from PC where price < 500

-- Задание: 2 (Serge I: 2002-09-21)
-- Найдите производителей принтеров. Вывести: maker

select distinct maker from product where type = 'printer'

-- Задание: 3 (Serge I: 2002-09-30)
-- Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

Select model, ram, screen from laptop where price > 1000

-- Задание: 4 (Serge I: 2002-09-21)
-- Найдите все записи таблицы Printer для цветных принтеров.

select * from printer where color = 'y'

-- Задание: 5 (Serge I: 2002-09-30)
-- Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол

Select model, speed, hd from pc where cd = '12x' and price < 600 or cd = '24x' and price < 600

-- Задание: 9 (Serge I: 2002-11-02)
-- Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

select distinct p.maker from product p join pc on p.model = pc.model and pc.speed >=450

-- Задание: 10 (Serge I: 2002-09-23)
-- Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

select model, price from printer where price = (select max(price) from printer)

-- Задание: 11 (Serge I: 2002-11-02)
-- Найдите среднюю скорость ПК.

Select avg(speed) from pc

-- Задание: 12 (Serge I: 2002-11-02)
-- Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

Select avg(speed) from laptop where price > 1000

-- Задание: 13 (Serge I: 2002-11-02)
-- Найдите среднюю скорость ПК, выпущенных производителем A.

select avg(pc.speed) from pc join product p on pc.model = p.model where p.maker = 'A' group by p.maker

-- Задание: 6 (Serge I: 2002-10-28)
-- Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

select distinct p.maker, lt.speed  
from product p join laptop lt 
on p.model = lt.model and 	
lt.hd >=10

-- Задание: 7 (Serge I: 2002-11-02)
-- Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

select distinct p.model, pc.price from product p  join pc on p.model = pc.model and p.maker = 'B' 
union
select distinct p.model, lt.price from product p  join laptop lt on p.model = lt.model and p.maker = 'B'
union 
select distinct p.model, pr.price from product p  join printer pr on p.model = pr.model and p.maker = 'B'

-- Задание: 8 (Serge I: 2003-02-03)
-- Найдите производителя, выпускающего ПК, но не ПК-блокноты.

select maker from product where type = 'pc'
except
select maker from product where type = 'laptop'

-- Задание: 19 (Serge I: 2003-02-13)
-- Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
-- Вывести: maker, средний размер экрана.

select p.maker, avg(lt.screen) from product p inner join laptop lt on p.model=lt.model group by p.maker

-- Задание: 20 (Serge I: 2003-02-13)
-- Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.

select p.maker, count(p.model) count_model from product p where p.type='pc' group by p.maker having count(distinct p.model)>=3

-- Задание: 21 (Serge I: 2003-02-13)
-- Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
-- Вывести: maker, максимальная цена.

select p.maker, max(pc.price) from product p inner join pc on p.model=pc.model group by p.maker

-- Задание: 22 (Serge I: 2003-02-13)
-- Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.

Select pc.speed, avg(pc.price) from pc where pc.speed>600 group by pc.speed

-- Задание: 23 (Serge I: 2003-02-14)
-- Найдите производителей, которые производили бы как ПК
-- со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
-- Вывести: Maker

select p.maker from product p inner join pc on p.model=pc.model where pc.speed>=750 
intersect 
select p.maker from product p inner join laptop lt on p.model=lt.model where lt.speed>=750

-- Задание: 24 (Serge I: 2003-02-03)
-- Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.

with cte(model, price) as
(select model, price from pc
union 
select model,price from laptop
union 
select model,price from printer)
select model from cte where price = ( select max(price) from cte)

-- Задание: 15 (Serge I: 2003-02-03)
-- Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

select hd from pc group by hd having count(hd)>=2

-- Задание: 16 (Serge I: 2003-02-03)
-- Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

select distinct a2.model, a1.model, a1.speed, a1.ram from pc as a1, pc a2 where a1.speed=a2.speed and a1.ram=a2.ram and a2.model>a1.model

-- Задание: 17 (Serge I: 2003-02-03)
-- Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
-- Вывести: type, model, speed

select  distinct p.type, lt.model, lt.speed from laptop as lt, pc pc, product p  where lt.speed<all (select speed from pc) and p.model=lt.model

-- Задание: 18 (Serge I: 2003-02-03)
-- Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price

select p.maker, pr.price from product p inner join printer pr on p.model=pr.model where pr.color='y'
group by p.maker, pr.color, pr.price
having pr.price in (select min(price) from printer where color = 'y')



/*
Рассматривается БД кораблей, участвовавших во второй мировой войне. Имеются следующие отношения:
Classes (class, type, country, numGuns, bore, displacement)
Ships (name, class, launched)
Battles (name, date)
Outcomes (ship, battle, result)
Корабли в «классах» построены по одному и тому же проекту, и классу присваивается либо имя первого корабля, построенного по данному проекту, либо названию класса дается имя проекта, которое не совпадает ни с одним из кораблей в БД. Корабль, давший название классу, называется головным.
Отношение Classes содержит имя класса, тип (bb для боевого (линейного) корабля или bc для боевого крейсера), страну, в которой построен корабль, число главных орудий, калибр орудий (диаметр ствола орудия в дюймах) и водоизмещение ( вес в тоннах). В отношении Ships записаны название корабля, имя его класса и год спуска на воду. В отношение Battles включены название и дата битвы, в которой участвовали корабли, а в отношении Outcomes – результат участия данного корабля в битве (потоплен-sunk, поврежден - damaged или невредим - OK).
Замечания. 1) В отношение Outcomes могут входить корабли, отсутствующие в отношении Ships. 2) Потопленный корабль в последующих битвах участия не принимает.
*/

-- Задание: 14 (Serge I: 2002-11-05)
-- Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

select c.class, s.name, c.country from classes c inner join ships s on c.class=s.class where numGUNS>=10

-- Задание: 33 (Serge I: 2002-11-02)
-- Укажите корабли, потопленные в сражениях в Северной Атлантике (North Atlantic). Вывод: ship.

select ship from outcomes where battle = 'north atlantic' and result = 'sunk'
 
/*
 Схема БД состоит из четырех отношений:
Company (ID_comp, name)
Trip(trip_no, ID_comp, plane, town_from, town_to, time_out, time_in)
Passenger(ID_psg, name)
Pass_in_trip(trip_no, date, ID_psg, place)
Таблица Company содержит идентификатор и название компании, осуществляющей перевозку пассажиров. Таблица Trip содержит информацию о рейсах: номер рейса, идентификатор компании, тип самолета, город отправления, город прибытия, время отправления и время прибытия. Таблица Passenger содержит идентификатор и имя пассажира. Таблица Pass_in_trip содержит информацию о полетах: номер рейса, дата вылета (день), идентификатор пассажира и место, на котором он сидел во время полета. При этом следует иметь в виду, что
- рейсы выполняются ежедневно, а длительность полета любого рейса менее суток; town_from <> town_to;
- время и дата учитывается относительно одного часового пояса;
- время отправления и прибытия указывается с точностью до минуты;
- среди пассажиров могут быть однофамильцы (одинаковые значения поля name, например, Bruce Willis);
- номер места в салоне – это число с буквой; число определяет номер ряда, буква (a – d) – место в ряду слева направо в алфавитном порядке;
- связи и ограничения показаны на схеме данных.
 */
 
--  Задание: 63 (Serge I: 2003-04-08)
-- Определить имена разных пассажиров, когда-либо летевших на одном и том же месте более одного раза.
 
select name from passenger where ID_psg IN (select pt.ID_psg from pass_in_trip pt group by pt.place, pt.ID_psg having count(pt.place)>1)

 


