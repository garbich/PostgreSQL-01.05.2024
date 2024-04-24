drop table if exists doctorsExaminations;
drop table if exists doctors;
drop table if exists examinations;
drop table if exists wards;
drop table if exists departments;
drop table if exists donations;
drop table if exists sponsors;

create table if not exists departments (
    id serial not null primary key,
    building int not null, 
    name varchar(255) NOT NULL 
);

create table if not exists doctors (
    id serial not null primary key,
    name varchar(255) NOT NULL,
    premium_money int not null,
    department_id int not null,
    salary int not null,
    surname varchar(255) not null,
	FOREIGN key(department_id) REFERENCES departments(id) on delete cascade
);

create table if not exists doctorsExaminations (
    id serial not null primary key,
    endTime time not null,
    startTime time not null,
    doctor_id int not null,
    examination_id int not null,
    ward_id int not null,
	FOREIGN key(doctor_id) REFERENCES doctors(id) on delete cascade
);

create table if not exists donations(
id serial not null primary key,
amount int not null,
date date not null,
department_id int not null,
sponsor_id int not null,
FOREIGN key(department_id) REFERENCES departments(id)
);

create table if not exists examinations (
    id serial primary key,
    name varchar(255) NOT NULL 
);

create table if not exists sponsors(
id serial not null primary key,
name VARCHAR(255)
);

create table if not exists wards (
    id serial not null primary key,
    name varchar(255) NOT NULL,
    places int not null,
    department_id int not null,
    FOREIGN KEY (department_id) REFERENCES departments(id) on DELETE CASCADE
);


INSERT INTO departments (building, name) VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'General Surgery');

INSERT INTO doctors (name, premium_money, department_id, salary, surname) VALUES
('John', 500, 1, 6000, 'Doe'),
('Alice', 600, 2, 7000, 'Smith'),
('Michael', 400, 3, 5500, 'Johnson');

INSERT INTO examinations (name) VALUES
('MRI Scan'),
('Echocardiogram'),
('X-ray');

INSERT INTO sponsors (name) VALUES
('ABC Company'),
('XYZ Foundation');

INSERT INTO wards (name, places, department_id) VALUES
('Ward A', 20, 1),
('Ward A', 20, 1),
('Ward B', 15, 2),
('Ward C', 25, 3);

INSERT INTO donations (amount, date, department_id, sponsor_id) VALUES
(1000, '2024-04-23', 1, 1),
(500, '2024-04-23', 1, 1),
(1500, '2024-04-24', 2, 2);


--Task 1
--select w.name
--from wards as w
--join departments as d
--on w.department_id = d.id
--where d.name like 'Cardiology';

--Task 2
--select w.name
--from wards as w
--join departments as d
--on w.department_id = d.id
--where d.name in('Neurology', 'General Surgery');

--Task 3
--select name, Count(*)
--from donations
--join departments 
--on department_id = departments.id
--GROUP BY name
--ORDER by Count(*)
--limit 1;

--Task 4
--select d.name, d.surname
--from doctors as d
--where d.salary > (select salary from doctors where name = 'John' and surname = 'Doe');


--Task 5
--select w.name, w.places
--from wards as w
--join departments as dp
--on w.department_id = dp.id
--where w.places > 
--(select avg(wr.places) 
--from wards as wr 
--join departments as d 
--on wr.department_id = d.id  
--where d.name = 'Cardiology');


--Task 6
select d.name, d.surname
from doctors as d
where d.salary > (select sum(salary + premium_money) from doctors where name = 'John' and surname = 'Doe');