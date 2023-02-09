use MyFunkDB;

create table Employees1
(Employees_id int  auto_increment PRIMARY KEY not null,
FName VARCHAR(50) NOT NULL ,
phone varchar(30) NOT NULL 
);
drop table Employees1;
   
create table Salaryes1
(salaryes_id int NOT NULL PRIMARY KEY,
position VARCHAR(50) ,
salary int ,
FOREIGN KEY(salaryes_id) REFERENCES Employees1(Employees_id)
);
drop table Salaryes1;   

create table Informations1
(informations_id int  NOT NULL PRIMARY KEY,
status VARCHAR(50) ,
birthday date ,
adress VARCHAR(50) ,
FOREIGN KEY(informations_id) REFERENCES Employees1(Employees_id)  
);
drop table Informations1; 
-- спочатку створили трігер, який буде добавляти запис до 2-ї та 3-ї 
-- таблиці після вставки записів в таблицю співробітників (1-а таблиця), щоб не порушити цілісність даних.
DELIMITER |
CREATE TRIGGER new_Employees 
AFTER INSERT ON Employees1 
FOR EACH ROW 
  BEGIN
    INSERT INTO Salaryes1 (salaryes_id ) VALUES( new.Employees_id );
    INSERT INTO Informations1 (informations_id ) VALUES( new.Employees_id );
 END;
    |
    drop TRIGGER new_Employees;|
    
INSERT INTO Employees1 (FName,phone) VALUES ('Марія', '(099)236-58-98'); |

        
SELECT * FROM Employees1; | 
SELECT * FROM Salaryes1;  |
SELECT * FROM Informations1; | 

-- тепер створюємо трігер, який буде видаляти записи з 2-ї та 3-ї 
-- таблиць перед видаленням записів з таблиці співробітників (1-а таблиця), щоб не порушити цілісність даних.
DELIMITER |
CREATE TRIGGER delete_Salaryes
BEFORE DELETE ON Employees1 
FOR EACH ROW 
  BEGIN
    DELETE  FROM Salaryes1 WHERE salaryes_id = OLD.Employees_id ;
    DELETE  FROM Informations1 WHERE informations_id= OLD.Employees_id ;
 END;
    |
drop TRIGGER delete_Salaryes;|

delete  from Employees1 where Employees_id = 1;|   
SELECT * FROM Employees1; | 
SELECT * FROM Salaryes1;  |
SELECT * FROM Informations1; | 


