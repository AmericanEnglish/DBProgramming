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