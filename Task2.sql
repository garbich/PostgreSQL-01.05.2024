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
    salary int not null,
    surname varchar(255) not null
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
FOREIGN key(department_id) REFERENCES departments(id) on delete cascade
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

INSERT INTO doctors (name, premium_money, salary, surname) VALUES
('John', 500, 6000, 'Doe'),
('Alice', 600, 7000, 'Smith'),
('Michael', 400, 5500, 'Johnson');

INSERT INTO doctorsExaminations (startTime, endTime, doctor_id, examination_id, ward_id) VALUES 
('12:00', '15:00', 1, 1, 1),
('15:00', '16:00', 2, 2, 2),
('16:00', '17:00', 3, 3, 3);

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
(1500, '2024-04-24', 3, 2);



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
--select d.name, d.surname
--from doctors as d
--where (d.salary + d.premium_money) > (select sum(salary + 100) from doctors where name = 'John' and surname = 'Doe')
--and name <> 'John' and surname <> 'Doe';

--Task 7
--select dp.name
--from doctors as d
--join doctorsExaminations as de
--on de.doctor_id = d.id
--join wards as w
--on de.ward_id = w.id
--join departments as dp
--on w.department_id = dp.id
--where d.name = 'Michael' and d.surname = 'Johnson';

--Task 8
--select sp.name
--from sponsors as sp
--join donations as don
--on sp.id = don.sponsor_id 
--join departments as dp
--on don.department_id = dp.id
--where dp.name != 'Cardiology' and dp.name != 'Neurology'; 

--Task 9
--select d.surname
--from doctors as d
--join doctorsExaminations as de
--on d.id = de.doctor_id
--where de.startTime = '12:00' and de.endTime = '15:00';
