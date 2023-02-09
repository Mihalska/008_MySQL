drop database MyFunkDB;
create database MyFunkDB;
use MyFunkDB;

create table Employees
(Employees_id int  auto_increment PRIMARY KEY not null,
FName VARCHAR(50) NOT NULL ,
phone varchar(30) NOT NULL 
);
drop table Employees;
   
create table Salaryes
(salaryes_id int NOT NULL PRIMARY KEY,
position VARCHAR(50) NOT NULL,
salary int NOT NULL,
FOREIGN KEY(salaryes_id) REFERENCES Employees(Employees_id)
);
drop table Salaryes;   

create table Informations
(informations_id int NOT NULL PRIMARY KEY,
status VARCHAR(50) NOT NULL,
birthday date NOT NULL,
adress VARCHAR(50) NOT NULL,
FOREIGN KEY(informations_id) REFERENCES Employees(Employees_id)  
);
drop table Informations;  

DELIMITER |
DROP PROCEDURE MyProc; |
CREATE PROCEDURE MyProc (IN name varchar(50), IN ph_one varchar(30), IN pos varchar(50),IN sal int,
IN stat VARCHAR(50), IN Date date, IN adr VARCHAR(50))

BEGIN
DECLARE Id int;
START TRANSACTION;
			
		INSERT Employees (FName,phone)
		VALUES (name, ph_one);
		SET Id = @@IDENTITY;
		
		INSERT Salaryes (salaryes_id, position,salary)
		VALUES (Id, pos, sal);
		
		INSERT Informations (informations_id, status, birthday,adress)
		VALUES (Id, stat, Date, adr);
		
IF EXISTS (SELECT * FROM Employees WHERE FName = name AND phone = ph_one AND Employees_id != Id)
			THEN
				ROLLBACK; 
				
			END IF;	
			
		COMMIT; 
END; |	

-- Викунуємо ряд записів вставки у вигляді транзакції в зберігаємій процедурі. Якщо такий співробітник вже існує - відкочуємо базу даних назад.  
CALL MyProc( 'Іван', '(093)025-41-45','Головний директор', 30000, 'Неодружений', '1985-11-25', 'вул. Васильківська, 35'); |

CALL MyProc ( 'Олег', '(095)825-46-69' ,'Менеджер', 20000, 'Одружений', '1986-01-15', 'вул. Миру, 100'); |

CALL MyProc	( 'Артем', '(067)025-21-49' , 'Робітник', 15000, 'Неодружений', '1987-07-06', 'вул. Перемоги, 31/112' ); |
CALL MyProc	( 'Олена',  '(097)036-41-87' , 'Робітник_2', 13000, 'Одружений', '1988-05-11', 'вул. Хрещатик, 45/100' ); |
-- наступна вставка - співробітник вже існує, відповідно він не добавляється до таблиці, застосовується ROLLBACK; 
CALL MyProc	( 'Олена',  '(097)036-41-87' , 'Робітник_2', 13000, 'Одружений', '1988-05-11', 'вул. Хрещатик, 45/100' ); |

SELECT * FROM Employees; | 
SELECT * FROM Salaryes;  |
SELECT * FROM Informations; | 
 

