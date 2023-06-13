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
