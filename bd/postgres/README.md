Задача 1.  

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.  
Подключитесь к БД PostgreSQL используя psql.  
Воспользуйтесь командой \? для вывода подсказки по имеющимся в psql управляющим командам.  
Найдите и приведите управляющие команды для:  

вывода списка БД  
подключения к БД  
вывода списка таблиц  
вывода описания содержимого таблиц  
выхода из psql  

~~~
docker pull postgres:13
docker volume create vol_postgres
docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v vol_postgres:/var/lib/postgresql/data postgres:13
docker exec -it pg-docker bash
psql -h localhost -p 5432 -U postgres -W
~~~

вывода списка БД  

~~~
postgres-# \l
~~~

подключения к БД  

~~~
- \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}  
postgres-# \c postgres
Password: 
~~~

вывода списка таблиц postgres  

~~
postgres-# \dtS        
~~~

вывода описания содержимого таблиц  

~~~
postgres-# \d[S+] NAME
postgres-# \dS+ pg_index
~~~

выхода из psql  

~~~
postgres-# \q
~~~

Задача 2.  

Используя psql создайте БД test_database.  
Изучите бэкап БД.  
Восстановите бэкап БД в test_database.  
Перейдите в управляющую консоль psql внутри контейнера.  
Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.  
Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.  
Приведите в ответе команду, которую вы использовали для вычисления и полученный результат.  

~~~
postgres=# CREATE DATABASE test_database;
CREATE DATABASE

root@bd54a0eg7b93:/var/lib/postgresql/data# psql -U postgres -f ./pg_backup.sql test_database

postgres=# \c test_database
Password: 
You are now connected to database "test_database" as user "postgres".
test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner   
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE

test_database=# select avg_width from pg_stats where tablename='orders';
 avg_width 
-----------
         4
        16
         4
(3 rows)
~~~

Задача 3.  
Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).  
Предложите SQL-транзакцию для проведения данной операции.  
Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?  

~~~
CREATE TABLE public.orders_1 (LIKE public.orders);
CREATE TABLE public.orders_2 (LIKE public.orders);
insert into orders_1 (id,title,price) select * from orders where price > 499;
insert into orders_2 (id,title,price) select * from orders where price <= 499;
~~~

Или так:  

~~~
CREATE TABLE orders_1 (CHECK ( price > 499 )) INHERITS (orders);
CREATE TABLE orders_2 (CHECK ( price <= 499 )) INHERITS (orders);

CREATE INDEX orders_1_price ON orders (price);
CREATE INDEX orders_2_price ON orders (price);


CREATE OR REPLACE FUNCTION orders_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF ( NEW.price > 499) THEN INSERT INTO orders_1 VALUES (NEW.*);
    ELSIF ( NEW.price <= 499 ) THEN INSERT INTO orders_2 VALUES (NEW.*);
    ELSE
        RAISE EXCEPTION 'price is incorrect';
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER insert_orders_price_trigger
    BEFORE INSERT ON orders
    FOR EACH ROW EXECUTE PROCEDURE orders_insert_trigger();
~~~

Можно было исключить "ручное" разбиение если заранее использовать для price MINVALUE и MAXVALUE.  

Задача 4.  
Используя утилиту pg_dump создайте бекап БД test_database.  
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?  

~~~
root@bd54a0eg7b93:/var/lib/postgresql/data# pg_dump -U postgres -d test_database >test_database_dump.sql
~~~

Для уникальности нужно добавить индекс.  

~~~
CREATE INDEX ON orders ((lower(title)));
~~~