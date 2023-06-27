mysql> create database jobs;
Query OK, 1 row affected (0.00 sec)

mysql> use jobs
Database changed
mysql> create table regions (region_id int not null auto_increment,region_name varchar(20), primary key(region_id));
Query OK, 0 rows affected (0.24 sec)

mysql> desc regions
    -> ;
+-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| region_id   | int(11)     | NO   | PRI | NULL    | auto_increment |
| region_name | varchar(20) | YES  |     | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+
2 rows in set (0.01 sec)

mysql> create table countries (countrie_id int not null auto_increment,countrie_name varchar(20),region_id int, primary key(countrie_id),foreign key(region_id) references regions(region_id));
Query OK, 0 rows affected (0.29 sec)

mysql> desc countries;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| countrie_id   | int(11)     | NO   | PRI | NULL    | auto_increment |
| countrie_name | varchar(20) | YES  |     | NULL    |                |
| region_id     | int(11)     | YES  | MUL | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
3 rows in set (0.00 sec)

mysql> create table locations (location_id int not null auto_increment,street_address varchar(50),postal_code varchar(20),city varchar(20),state_province varchar(30),primary key(location_id),foreign key(countrie_id)references countries(countrie_id));
ERROR 1072 (42000): Key column 'countrie_id' doesn't exist in table
mysql> create table locations (location_id int not null auto_increment,street_address varchar(50),postal_code varchar(20),city varchar(20),state_province varchar(30),countrie_id int,primary key(location_id),foreign key(countrie_id)references countries(countrie_id));
Query OK, 0 rows affected (0.23 sec)

mysql> desc locations;
+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| location_id    | int(11)     | NO   | PRI | NULL    | auto_increment |
| street_address | varchar(50) | YES  |     | NULL    |                |
| postal_code    | varchar(20) | YES  |     | NULL    |                |
| city           | varchar(20) | YES  |     | NULL    |                |
| state_province | varchar(30) | YES  |     | NULL    |                |
| countrie_id    | int(11)     | YES  | MUL | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+
6 rows in set (0.00 sec)

mysql> create table departments (department_id int not null auto_increment,department_name varchar(30),location_id int,primary key(department_id),foreign key(location_id) references locations(location_id));
Query OK, 0 rows affected (0.26 sec)

mysql> desc departments;
+-----------------+-------------+------+-----+---------+----------------+
| Field           | Type        | Null | Key | Default | Extra          |
+-----------------+-------------+------+-----+---------+----------------+
| department_id   | int(11)     | NO   | PRI | NULL    | auto_increment |
| department_name | varchar(30) | YES  |     | NULL    |                |
| location_id     | int(11)     | YES  | MUL | NULL    |                |
+-----------------+-------------+------+-----+---------+----------------+
3 rows in set (0.01 sec)

mysql> create table jobs (job_id int not null auto_increment,job_title varchar(20),min_salary int ,max_salary int);
ERROR 1075 (42000): Incorrect table definition; there can be only one auto column and it must be defined as a key
mysql> create table jobs (job_id int not null auto_increment,job_title varchar(20),min_salary int ,max_salary int,primary key(job_id));
Query OK, 0 rows affected (0.21 sec)

mysql> desc jobs;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| job_id     | int(11)     | NO   | PRI | NULL    | auto_increment |
| job_title  | varchar(20) | YES  |     | NULL    |                |
| min_salary | int(11)     | YES  |     | NULL    |                |
| max_salary | int(11)     | YES  |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

mysql> create table manager (manager_id int not null auto_increment,name varchar(20),primary key(manager_id));
Query OK, 0 rows affected (0.20 sec)

mysql> desc manager;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| manager_id | int(11)     | NO   | PRI | NULL    | auto_increment |
| name       | varchar(20) | YES  |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
2 rows in set (0.00 sec)

mysql> CREATE TABLE `employee` (
    -> `employee_id` INT NOT NULL AUTO_INCREMENT,
    -> `first_name` VARCHAR(20),
    -> `last_name` VARCHAR(20),
    -> `email` VARCHAR(30),
    -> `phone_number` INT(12),
    -> `hire_date` DATE,
    -> `job_id` INT,
    -> `salary` INT,
    -> `manager_id` INT,
    -> `department_id` INT,
    -> PRIMARY KEY (`employee_id`),
    -> foreign key(job_id) references jobs(job_id),
    -> foreign key(manager_id) references manager(manager_id),
    -> foreign key(department_id) references departments(department_id),
    -> ); 
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ')' at line 16
mysql> CREATE TABLE `employee` ( `employee_id` INT NOT NULL AUTO_INCREMENT, `first_name` VARCHAR(20), `last_name` VARCHAR(20), `email` VARCHAR(30), `phone_number` INT(12), `hire_date` DATE, `job_id` INT,
`salary` INT, `manager_id` INT, `department_id` INT, PRIMARY KEY (`employee_id`), foreign key(job_id) references jobs(job_id), foreign key(manager_id) references manager(manager_id), foreign key(department_id) references departments(department_id));
Query OK, 0 rows affected (0.33 sec)

mysql> create table dependents (dependent_id int not null auto_increment,first_name varchar(30), last_name varchar(30), relationship varchar(30), employee_id int ,primary key(dependent_id),foreign key(employee_id) references employee(employee_id));
Query OK, 0 rows affected (0.26 sec)

mysql> desc dependents;
+--------------+-------------+------+-----+---------+----------------+
| Field        | Type        | Null | Key | Default | Extra          |
+--------------+-------------+------+-----+---------+----------------+
| dependent_id | int(11)     | NO   | PRI | NULL    | auto_increment |
| first_name   | varchar(30) | YES  |     | NULL    |                |
| last_name    | varchar(30) | YES  |     | NULL    |                |
| relationship | varchar(30) | YES  |     | NULL    |                |
| employee_id  | int(11)     | YES  | MUL | NULL    |                |
+--------------+-------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> 
use jobs;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show table;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1
mysql> show tables;
+----------------+
| Tables_in_jobs |
+----------------+
| countries      |
| departments    |
| dependents     |
| employee       |
| jobs           |
| locations      |
| manager        |
| regions        |
+----------------+
8 rows in set (0.00 sec)

mysql> insert into regions values(1001,'Europe'),(1002,'America'),(1003,'Eurasia'),(1004,'Africa'),(1005,'Asia'),(1006,'Antarctica'),(1007,'Australia');
Query OK, 7 rows affected (0.04 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> select*from regions;
+-----------+-------------+
| region_id | region_name |
+-----------+-------------+
|        10 | Asia        |
|      1001 | Europe      |
|      1002 | America     |
|      1003 | Eurasia     |
|      1004 | Africa      |
|      1005 | Asia        |
|      1006 | Antarctica  |
|      1007 | Australia   |
+-----------+-------------+
8 rows in set (0.00 sec)

mysql> delete from regions where region_id=10;
Query OK, 1 row affected (0.05 sec)

mysql> select*from regions;
+-----------+-------------+
| region_id | region_name |
+-----------+-------------+
|      1001 | Europe      |
|      1002 | America     |
|      1003 | Eurasia     |
|      1004 | Africa      |
|      1005 | Asia        |
|      1006 | Antarctica  |
|      1007 | Australia   |
+-----------+-------------+
7 rows in set (0.01 sec)

mysql> insert into countries values(2001,'jermany',1001),(2002,'Mexico',1002),(2003,'Russia',1003),(2004,'Nigeria',1004),(2005,'India',1005),(2006,'France',1006),(2007,'New zealand',1007);
Query OK, 7 rows affected (0.03 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> select*from countries;
+------------+--------------+-----------+
| country_id | country_name | region_id |
+------------+--------------+-----------+
|       2001 | jermany      |      1001 |
|       2002 | Mexico       |      1002 |
|       2003 | Russia       |      1003 |
|       2004 | Nigeria      |      1004 |
|       2005 | India        |      1005 |
|       2006 | France       |      1006 |
|       2007 | New zealand  |      1007 |
+------------+--------------+-----------+
7 rows in set (0.00 sec)

mysql> insert in to locations values(1100,'zeli',84210,'Berlin','Hamburg',2001),(1200,'Madero street',70008,'Tijuana','Chiapas', 2002),(1300,'Sovetskaya',68215,'Moscow','st peterburg',2003),(1400,'Toyin street',45681,'Lagos','Imo state',2004),(1500,'Chandni chowk',22389,'Delhi','Delhi',2005),(1600,'Champs Elysees',18998,'Paris','Corsica',2006),(1700,'Queen street',21456,'Hamilton','Auckland',2007);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'in to locations values(1100,'zeli',84210,'Berlin','Hamburg',2001),(1200,'Madero ' at line 1
mysql> insert in to locations values(1100,'zeli',84210,'Berlin','Hamburg',2001),(1200,'Madero street',70008,'Tijuana','Chiapas', 2002),(1300,'Sovetskaya',68215,'Moscow','st peterburg',2003),(1400,'Toyin street',45681,'Lagos','Imo state',2004),(1500,'Chandni chowk',22389,'Delhi','Delhi',2005),(1600,'Champs Elysees',18998,'Paris','Corsica',2006),(1700,'Queen street',21456,'Hamilton','Auckland',2007);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'in to locations values(1100,'zeli',84210,'Berlin','Hamburg',2001),(1200,'Madero ' at line 1
mysql> insert into locations values(1100,'zeli',84210,'Berlin','Hamburg',2001),(1200,'Madero street',70008,'Tijuana','Chiapas', 2002),(1300,'Sovetskaya',68215,'Moscow','st peterburg',2003),(1400,'Toyin street',45681,'Lagos','Imo state',2004),(1500,'Chandni chowk',22389,'Delhi','Delhi',2005),(1600,'Champs Elysees',18998,'Paris','Corsica',2006),(1700,'Queen street',21456,'Hamilton','Auckland',2007);
Query OK, 7 rows affected (0.03 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> select*from locations;
+-------------+----------------+-------------+----------+----------------+------------+
| location_id | street_address | postal_code | city     | state_province | country_id |
+-------------+----------------+-------------+----------+----------------+------------+
|        1100 | zeli           | 84210       | Berlin   | Hamburg        |       2001 |
|        1200 | Madero street  | 70008       | Tijuana  | Chiapas        |       2002 |
|        1300 | Sovetskaya     | 68215       | Moscow   | st peterburg   |       2003 |
|        1400 | Toyin street   | 45681       | Lagos    | Imo state      |       2004 |
|        1500 | Chandni chowk  | 22389       | Delhi    | Delhi          |       2005 |
|        1600 | Champs Elysees | 18998       | Paris    | Corsica        |       2006 |
|        1700 | Queen street   | 21456       | Hamilton | Auckland       |       2007 |
+-------------+----------------+-------------+----------+----------------+------------+
7 rows in set (0.00 sec)

mysql> insert into  departments values(1,'Finance',1100),(2,'Management',1200),(3,'Quality assurance',1300),(4,'Accounting',1400),(5,'Marketing',1500),(6,'Engineering',1600),(7,'Law',1700);
Query OK, 7 rows affected (0.03 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> select*from  departments;
+---------------+-------------------+-------------+
| department_id | department_name   | location_id |
+---------------+-------------------+-------------+
|             1 | Finance           |        1100 |
|             2 | Management        |        1200 |
|             3 | Quality assurance |        1300 |
|             4 | Accounting        |        1400 |
|             5 | Marketing         |        1500 |
|             6 | Engineering       |        1600 |
|             7 | Law               |        1700 |
+---------------+-------------------+-------------+
7 rows in set (0.00 sec)

mysql> insert into jobs values(10,'Loan officer',15000,20000),(20,'Data entry',5000,8000),(30,'Quality Assurance Engineer',30000,65000),(40,'Senior Accountant',28000,45000),(50,'Digital marketing mnanager',35000,69000),(60,'Civil Engineer',30000,70000),(70,'Advocate',90000,100000);
ERROR 1406 (22001): Data too long for column 'job_title' at row 3
mysql> desc jobs;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| job_id     | int(11)     | NO   | PRI | NULL    | auto_increment |
| job_title  | varchar(20) | YES  |     | NULL    |                |
| min_salary | int(11)     | YES  |     | NULL    |                |
| max_salary | int(11)     | YES  |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
4 rows in set (0.01 sec)

mysql> insert into jobs values(10,'Loan officer',15000,20000),(20,'Data entry',5000,8000),(30,'Quality Engineer',30000,65000),(40,'Senior Accountant',28000,45000),(50,'Digital marketing mnanager',35000,69000),(60,'Civil Engineer',30000,70000),(70,'Advocate',90000,100000);
ERROR 1406 (22001): Data too long for column 'job_title' at row 5
mysql> insert into jobs values(10,'Loan officer',15000,20000),(20,'Data entry',5000,8000),(30,'Quality Engineer',30000,65000),(40,'Senior Accountant',28000,45000),(50,'Marketing manager',35000,69000),(60,'Civil Engineer',30000,70000),(70,'Advocate',90000,10
Query OK, 7 rows affected (0.03 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> select*from jobs;
+--------+-------------------+------------+------------+
| job_id | job_title         | min_salary | max_salary |
+--------+-------------------+------------+------------+
|     10 | Loan officer      |      15000 |      20000 |
|     20 | Data entry        |       5000 |       8000 |
|     30 | Quality Engineer  |      30000 |      65000 |
|     40 | Senior Accountant |      28000 |      45000 |
|     50 | Marketing manager |      35000 |      69000 |
|     60 | Civil Engineer    |      30000 |      70000 |
|     70 | Advocate          |      90000 |     100000 |
+--------+-------------------+------------+------------+
7 rows in set (0.00 sec)
