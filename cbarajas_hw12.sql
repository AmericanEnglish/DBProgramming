-- 18.1
-- Conceptual design helps to pan out what things need to be tables, what things are relationships, how things are related to each other and what might have what properties of what. This process helps to pad out possible tables and relationships that object in the database experience.
-- Logical Models are the root pieces of a database. These things basically describe the structure of the tables and also exhibit key values that might stretch across several tables. So before the actual SQL creation happens this model helps put the finishing touches on database structure.
-- Physical  design is the hard SQL statements that are going to be run against server for table creation as well as interlocking tables to tables with foreign keys.
-- These jobs might be performed by different people because step of the process is a large undertaking. It might make sense to pass the buck from one person to another. Also nothing says you'd have to be a database admin to create a nice conceptual design or even perhaps a logical model.

-- 18.7
CREATE TABLE branch
(
    no INTEGER,
    address VARCHAR,
    telephone1 VARCHAR,
    telephone2 VARCHAR,
    telephone3 VARCHAR,
    staff_no INTEGER,
    PRIMARY KEY no,
    FOREIGN KEY (manager_no)
        REFERENCES manager (no)
);

CREATE TABLE manager
(
    staff_no INTEGER,
    date_assigned DATE,
    bonus MONEY,
    PRIMARY KEY staff_no,
    FOREIGN KEY  staff_no
        REFERENCES staff (no)
);

CREATE TABLE staff
(
    no INTEGER,
    name VARCHAR,
    address VARCHAR,
    position VARCHAR,
    salary MONEY,
    supervisor_name INTEGER,
    branch_no INTEGER,
    PRIMARY KEY no
    FOREIGN KEY (branch_no)
        REFERENCES branch (no)
    FOREIGN KEY (supervisor_nane)
        REFERENCES staff (name)
);

CREATE TABLE for_rent
(
    no  INTEGER,
    address VARCHAR,
    type VARCHAR,
    number_of_rooms INTEGER,
    monthly_rent MONEY,
    owner_no VARCHAR,
    staff_no INTEGER,
    PRIMARY KEY (no)
    FOREIGN KEY (staff_no)
        REFERENCES staff (no)
);

CREATE TABLE owners
(
    no INTEGER,
    name VARCHAR,
    address VARCHAR,
    telephone VARCHAR,
    email VARCHAR,
    password VARCHAR,
    contact_name VARCHAR,
    PRIMARY KEY (name)
);

CREATE TABLE clients
(
    no INTEGER,
    name INTEGER,
    telephone INTEGER,
    email VARCHAR,
    max_rent MONEY,
    prefer_type VARCHAR,
    PRIMARY KEY (no),
);

CREATE TABLE leases
(
    no INTEGER,
    client_no INTEGER,
    name VARCHAR,
    address VARCHAR,
    property_no INTEGER,
    rent MONEY, 
    payment_type VARCHAR,
    paid BOOLEAN,
    start DATE,
    end DATE,
    PRIMARY KEY (no)
    FOREIGN KEY (property_no)
        REFERENCES for_rent (no)
);

CREATE TABLE newspaper
(
    name INTEGER
    property_no INTEGER,
    address VARCHAR,
    type VARCHAR,
    room_no INTEGER,
    advertised DATE,
    telephone VARCHAR,
    contact VARCHAR,
    PRIMARY KEY (name, property_no, advertised)
    FOREIGN KEY (property_no, room_no)
        REFERENCES for_rent (no, room_no)
);

-- 18.9
CREATE TABLE students
(
    banner_no INTEGER,
    first_name VARCHAR,
    last_name VARCHAR,
    address VARCHAR,
    phone_no VARCHAR,
    email VARCHAR,
    DOB DATE,
    gender VARCHAR[6],
    class VARCHAR[9],
    nationality VARCHAR,
    needs VARCHAR,
    comments VARCHAR,
    status BOOLEAN,
    major_id INTEGER,
    minor_id INTEGER,
    residence_name VARCHAR,
    room_no,
    PRIMARY KEY (first_name, last_name, address),
    FOREIGN KEY (residence_name, room_no)
        REFERENCES residence (name, room_no)
);

CREATE TABLE residences
(
    name VARCHAR,
    address VARCHAR,
    telephone VARCHAR,
    room_no INTEGER,
    manager INTEGER,
    PRIMARY KEY (name, room_no),
    FOREIGN KEY (manager)
        REFERENCES students (banner_no)
);

CREATE TABLE leases
(
    no INTEGER,
    duration DATE,
    first_name VARCHAR,
    last_name VARCHAR,
    banner_no INTEGER,
    place_no INTEGER,
    room_no INTEGER,
    address VARCHAR,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (no)
    FOREIGN KEY (banner_no, first_name, last_name),
        REFERENCES students (banner_no, first_name, last_name)
);

CREATE TABLE invoices
(
    no INTEGER,
    lease_no INTEGER,
    semester VARCHAR,
    payment_due MONEY,
    payment_id INTEGER,
    first_name VARCHAR,
    last_name VARCHAR,
    banner_no INTEGER,
    place_no INTEGER,
    room_no INTEGER
    address VARCHAR,
    PRIMARY KEY (no)
    FOREIGN KEY (banner_no, first_name, last_name)
        REFERENCES students (banner_no, first_name, last_name)
    FOREIGN KEY (lease_no)
        REFERENCES lease (no place_no)
    FOREIGN KEY (room_no, address)
        REFERENCES residences (room_no, address)
    FOREIGN KEY (payment_id, payment_due)
        REFERENCES payments (id, due)
);

CREATE TABLE payments
(
    id INTEGER,
    due MONEY,
    paid BOOLEAN,
    invoice_no INTEGER,
    PRIMARY KEY (id)
    FOREIGN KEY (invoice_no)
        REFERENCES invoices (no)
);

CREATE TABLE inspections
(
    staff_name VARCHAR,
    inspection_date DATE,
    satifactory BOOLEAN,
    comments VARCHAR,
    PRIMARY KEY (staff_name, inspection_date, satifactory, comments)
    FOREIGN KEY (staff_name)
        REFERENCES staff
);

CREATE TABLE staff 
(
    no INTEGER,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    address VARCHAR,
    dob DATE,
    gender VARCHAR[6],
    position VARCHAR,
    location VARCHAR,
    PRIMARY KEY no
    FOREIGN KEY (location)
        REFERENCES residences
);

CREATE TABLE Coures 
(
    course_no INTEGER, 
    course_name VARCHAR, 
    course_year INTEGER, 
    course_instructor VARCHAR, 
    instructor_no INTEGER, 
    email VARCHAR, 
    room_no INTEGER, 
    department_name VARCHAR,
    PRIMARY KEY (course_no),
    FOREIGN KEY (instructor_no, course_instructor)
        REFERENCES staff (no, first_name),
    FOREIGN KEY (department_name)
        REFERENCES department (name)
);

CREATE TABLE kin
(
    name VARCHAR,
    relationship VARCHAR,
    address VARCHAR,
    telephone VARCHAR,
    kin_to VARCHAR,
    PRIMARY KEY (name, relationship, kin_to)
    FOREIGN KEY (kin_to)
        REFERENCES students (name)
);

-- 18.11