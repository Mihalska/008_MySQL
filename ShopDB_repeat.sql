USE ShopDB;
/*видаляємо існуючі таблиці з бази даних ShopDB */
drop TABLE Customers;
drop TABLE Orders;
drop table Products;
drop TABLE OrderDetails;

/*створюємо таблицю в базі даних ShopDB без первічного ключа */
CREATE TABLE Customers
	(
	CustomerNo int NOT NULL ,
	FName nvarchar(15) NOT NULL,
	LName nvarchar(15) NOT NULL,
	MName nvarchar(15) NULL,
	Address1 nvarchar(50) NOT NULL,
	Address2 nvarchar(50) NULL,
	City nchar(10) NOT NULL,
	Phone char(12) NOT NULL,
	DateInSystem date NULL
	);  
    
INSERT Customers 
(CustomerNo, LName, FName, MName, Address1, Address2, City, Phone,DateInSystem)
VALUES
(5,'Круковский','Анатолий','Петрович','Лужная 15',NULL,'Харьков','(092)3212211','2009-11-20'),
(2, 'Дурнев','Виктор','Викторович','Зелинская 10',NULL,'Киев','(067)4242132','2009-11-20'),
(1,'Унакий','Зигмунд','федорович','Дихтяревская 5',NULL,'Киев','(092)7612343','2009-11-20'),
(3,'Левченко','Виталий','Викторович','Глущенка 5','Драйзера 12','Киев','(053)3456788','2009-11-20'),
(4,'Выжлецов','Олег','Евстафьевич','Киевская 3','Одесская 8','Чернигов','(044)2134212','2009-11-20');
 select * from Customers;
 /*Отримали послідовне занесення даних до таблиці без жодного сортування.
 Пошук в такій таблиці відбудеться ускладнено,доведеться перебирати усі значення. Так як  дані є  кучею. */
 
 explain select * from Customers where CustomerNo = 1  ;
 
 /*виконавши explain, ми побачили що пошук запиту відбувся в усіх рядках, filtered = 20.00.
 Чим вищий цей показник, тим швидше відбувається пошук даних.У нашому випадку цей показник зі 100.00 дорівнює 
 лише 20.00, тобто низький.*/
 
 drop TABLE Customers;
 /* створюємо таблицю в базі даних ShopDB з первічним ключем який є кластеризованим індексом*/
CREATE TABLE Customers
	(
	CustomerNo int NOT NULL,
	FName nvarchar(15) NOT NULL,
	LName nvarchar(15) NOT NULL,
	MName nvarchar(15) NULL,
	Address1 nvarchar(50) NOT NULL,
	Address2 nvarchar(50) NULL,
	City nchar(10) NOT NULL,
	Phone char(12) NOT NULL,
	DateInSystem date NULL,
    primary key(CustomerNo)
	); 
    
INSERT Customers 
(CustomerNo, LName, FName, MName, Address1, Address2, City, Phone,DateInSystem)
VALUES
(5,'Круковский','Анатолий','Петрович','Лужная 15',NULL,'Харьков','(092)3212211','2009-11-20'),
(2, 'Дурнев','Виктор','Викторович','Зелинская 10',NULL,'Киев','(067)4242132','2009-11-20'),
(1,'Унакий','Зигмунд','федорович','Дихтяревская 5',NULL,'Киев','(092)7612343','2009-11-20'),
(3,'Левченко','Виталий','Викторович','Глущенка 5','Драйзера 12','Киев','(053)3456788','2009-11-20'),
(4,'Выжлецов','Олег','Евстафьевич','Киевская 3','Одесская 8','Чернигов','(044)2134212','2009-11-20');
    
select * from Customers;
 /*Отримали занесення даних до таблиці відсортоване, в порядку зростання CustomerNo. 
 Пошук в такій таблиці відбудеться швидко. */
 
 explain select * from Customers where CustomerNo = 1  ;
  /*виконавши explain, ми побачили, що пошук запиту відбувся в 1 рядку, filtered = 100.00.
 Чим вищий цей показник, тим швидше відбувається пошук даних.У нашому випадку цей показник зі 100.00 дорівнює 
 100.00, тобто високий.
 Завдяки встановленню primary key(CustomerNo) ми отримали впорядковані дані в таблиці з кластеризованим індексом.*/

drop TABLE Customers;

/* створюємо таблицю в базі даних ShopDB з некластеризованим індексом  LName.*/
 CREATE TABLE Customers
	(
    LName nvarchar(15) NOT NULL unique,
	FName nvarchar(15) NOT NULL ,
	MName nvarchar(15) NULL,
    CustomerNo int NOT NULL,
	Address1 nvarchar(50) NOT NULL,
	Address2 nvarchar(50) NULL,
	City nchar(10) NOT NULL,
	Phone char(12) NOT NULL,
	DateInSystem date NULL
	); 
    
INSERT Customers 
(LName, FName, MName, CustomerNo,Address1, Address2, City, Phone,DateInSystem)
VALUES
('Круковский','Анатолий','Петрович',5,'Лужная 15',NULL,'Харьков','(092)3212211','2009-11-20'),
( 'Дурнев','Виктор','Викторович',2,'Зелинская 10',NULL,'Киев','(067)4242132','2009-11-20'),
('Унакий','Зигмунд','федорович',1,'Дихтяревская 5',NULL,'Киев','(092)7612343','2009-11-20'),
('Левченко','Виталий','Викторович',3,'Глущенка 5','Драйзера 12','Киев','(053)3456788','2009-11-20'),
('Выжлецов','Олег','Евстафьевич',4,'Киевская 3','Одесская 8','Чернигов','(044)2134212','2009-11-20');

select * from Customers;
/* виконавши select отримали дані відсортовані за прізвищами в алфавітному порядку */

explain select * from Customers where LName = 'Унакий'  ;
 /*виконавши explain, ми побачили що пошук запиту відбувся в 1 рядку, key = LName, filtered = 100.00.
  Чим вищий filtered, тим швидше відбувається пошук даних.У нашому випадку цей показник зі 100.00 дорівнює 
  100.00, тобто високий.
 Завдяки встановленню некластеризованого індексу ми отримали впорядковані дані за алфавітним порядком.*/

drop TABLE Customers;
/* створюємо таблицю в базі даних ShopDB з некластеризованим індексом  idx_pname, встановленим вручну.*/
 CREATE TABLE Customers
	(
    LName nvarchar(15) NOT NULL ,
	FName nvarchar(15) NOT NULL ,
	MName nvarchar(15) NULL,
    CustomerNo int NOT NULL,
	Address1 nvarchar(50) NOT NULL,
	Address2 nvarchar(50) NULL,
	City nchar(10) NOT NULL,
	Phone char(12) NOT NULL,
	DateInSystem date NULL
	); 
    
    INSERT Customers 
(LName, FName, MName, CustomerNo,Address1, Address2, City, Phone,DateInSystem)
VALUES
('Круковский','Анатолий','Петрович',5,'Лужная 15',NULL,'Харьков','(092)3212211','2009-11-20'),
( 'Дурнев','Виктор','Викторович',2,'Зелинская 10',NULL,'Киев','(067)4242132','2009-11-20'),
('Унакий','Зигмунд','федорович',1,'Дихтяревская 5',NULL,'Киев','(092)7612343','2009-11-20'),
('Левченко','Виталий','Викторович',3,'Глущенка 5','Драйзера 12','Киев','(053)3456788','2009-11-20'),
('Выжлецов','Олег','Евстафьевич',4,'Киевская 3','Одесская 8','Чернигов','(044)2134212','2009-11-20');
    
/* створення некластеризованого індекса вручну*/
CREATE INDEX idx_pname
ON Customers  (LName );

select * from Customers;
/* виконавши select отримали дані відсортовані за прізвищами в алфавітному порядку */

explain select * from Customers where LName = 'Унакий'  ;
 /*виконавши explain, ми побачили що пошук запиту відбувся в 1 рядку, key = idx_pname, filtered = 100.00.
  Чим вищий filtered, тим швидше відбувається пошук даних.У нашому випадку цей показник зі 100.00 дорівнює 
  100.00, тобто високий.
 Завдяки встановленню некластеризованого індексу ми отримали впорядковані дані за алфавітним порядком.*/

drop TABLE Customers;

/* створюємо таблицю в базі даних ShopDB з кластеризованим індексом та некластеризованим індексом  idx_pname1, встановленим вручну.*/
CREATE TABLE Customers
	(
    LName nvarchar(15) NOT NULL ,
	FName nvarchar(15) NOT NULL ,
	MName nvarchar(15) NULL,
    CustomerNo int NOT NULL primary key,
	Address1 nvarchar(50) NOT NULL,
	Address2 nvarchar(50) NULL,
	City nchar(10) NOT NULL,
	Phone char(12) NOT NULL,
	DateInSystem date NULL
	); 
    
INSERT Customers 
(LName, FName, MName, CustomerNo,Address1, Address2, City, Phone,DateInSystem)
VALUES
('Круковский','Анатолий','Петрович',5,'Лужная 15',NULL,'Харьков','(092)3212211','2009-11-20'),
( 'Дурнев','Виктор','Викторович',2,'Зелинская 10',NULL,'Киев','(067)4242132','2009-11-20'),
('Унакий','Зигмунд','федорович',1,'Дихтяревская 5',NULL,'Киев','(092)7612343','2009-11-20'),
('Левченко','Виталий','Викторович',3,'Глущенка 5','Драйзера 12','Киев','(053)3456788','2009-11-20'),
('Выжлецов','Олег','Евстафьевич',4,'Киевская 3','Одесская 8','Чернигов','(044)2134212','2009-11-20');
CREATE INDEX idx_pname1
ON Customers  (LName, FName, MName, Address1, Address2, City, Phone,DateInSystem);
select * from Customers;
/* виконавши select отримали дані відсортовані за прізвищами в алфавітному порядку */

explain select * from Customers where LName = 'Унакий'  ;
 /*виконавши explain, ми побачили що пошук запиту відбувся в 1 рядку, key = idx_pname, filtered = 100.00.
 З'явилося значення EXTRA - Using index. Тобто  некластеризований індекс має перевагу над кластеризованим,
 пошук відбувся за некластеризованим, відповідно відсортувало за прізвищами в алфавітному порядку.
 Чим вищий filtered, тим швидше відбувається пошук даних.У нашому випадку цей показник зі 100.00 дорівнює 
 100.00, тобто високий.*/
 
 /* Таким чином використання індексів значно спрощує та пришвидшує пошук необхідних даних, які з кучі 
 перетворюються у впорядковані та відсортовані за необхідним нам значенням.* /
    
    