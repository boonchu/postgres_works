
DROP TABLE teachers;

CREATE TABLE teachers (
	id bigserial,
	first_name varchar(25),
	last_name varchar(50),
	school varchar(50),
	hire_date date,
	salary numeric
);

INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
VALUES
('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500);


DROP TABLE supervisor_salaries;

CREATE TABLE supervisor_salaries (
    town varchar(30),
    county varchar(30),
    supervisor varchar(30),
    start_date date,
    salary money,
    benefits money
);

COPY supervisor_salaries (town, supervisor, salary)
FROM '/var/lib/pgsql/10/scripts/supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);

DROP TABLE departments CASCADE;
DROP TABLE employees CASCADE;

CREATE TABLE departments (
	dept_id bigserial,
	dept varchar(100),
	city varchar(100),
	CONSTRAINT dept_key PRIMARY KEY (dept_id),
	CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
	emp_id bigserial,
	first_name varchar(100),
	last_name varchar(100),
	salary integer,
	dept_id integer REFERENCES departments (dept_id),
	CONSTRAINT emp_key PRIMARY KEY (emp_id),
	CONSTRAINT emp_dept_unique UNIQUE (emp_id, dept_id)
);

INSERT INTO departments (dept, city) VALUES ('Tax', 'Atlanta'), ('IT', 'Boston');
INSERT INTO employees (first_name, last_name, salary, dept_id) VALUES ('Nancy', 'Jones', 62500, 1),('Lee', 'Smith', 59300, 1),('Soo', 'Nguyen', 83000, 2),('Janet', 'King', 95000, 2);

DROP TABLE schools_enrollment;
DROP TABLE schools_grades;

CREATE TABLE schools_enrollment (
	id integer,
	enrollment integer
);

CREATE TABLE schools_grades (
	id integer,
	grades varchar(10)
);

DROP TABLE schools_left CASCADE;
DROP TABLE schools_right CASCADE;

CREATE TABLE schools_left (
	id integer CONSTRAINT left_id_key PRIMARY KEY,
	left_school varchar(30)
);
CREATE TABLE schools_right (
	id integer CONSTRAINT right_id_key PRIMARY KEY,
	right_school varchar(30)
);

INSERT INTO schools_left (id, left_school) VALUES (1, 'Oak Street School'), (2, 'Roosevelt High School'), (5, 'Washington Middle School'), (6, 'Jefferson High School');
INSERT INTO schools_right (id, right_school) VALUES (1, 'Oak Street School'), (2, 'Roosevelt High School'), (3, 'Morrison Elementary'), (4, 'Chase Magnet Academy'), (6, 'Jefferson High School');

INSERT INTO schools_enrollment (id, enrollment)
VALUES
(1, 360),
(2, 1001),
(5, 450),
(6, 927);

INSERT INTO schools_grades (id, grades)
VALUES
(1, 'K-3'),
(2, '9-12'),
(5, '6-8'),
(6, '9-12');

