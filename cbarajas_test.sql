--1
--      The relational model was developed so that you could easily process, find, and handle 
--large amounts of data. By determining that each tuple and column much be unique then you 
--start to eliminate any chance that you are going to have problems sorting through the data 
--that you have collected. So essentially it was just created to have a nice homogenized 
--system that human beings could easily use for data storage, analysis, and even data 
--processing. 

--2
-- Algebra:  Capital Pi sub (specimen.date, species.name) 
--              USING (
--                  (specimen) /Left Inner Join/  SIGMA (location = 'Costa Rica')(Species)

--3
-- This relation will produce the latitude and the longitutde of all the specimens that were 
--discovered on 2007-07-07


-- 4
CREATE TABLE location
(
    name VARCHAR(20) NOT NULL,
    latitude REAL,
    longitude REAL,
    PRIMARY KEY (name),
    CHECK (longitude >= -180 AND longitude <= 180),
    CHECK (latitude >= -90 AND latitude <= 90)
);

CREATE TABLE species
(
    name VARCHAR(15) NOT NULL,
    discovered_by VARCHAR(20),
    discovered_date DATE,
    discovered_location_name VARCHAR(20),
    PRIMARY KEY (name),
    FOREIGN KEY (discovered_location_name)
        REFERENCES location (name),
    CHECK (discovered_date <= date('today'))
);

CREATE TABLE specimen
(
    date DATE NOT NULL,
    species_name VARCHAR(15) NOT NULL,
    location_name VARCHAR(20),
    collected_by VARCHAR(20),
    PRIMARY KEY (date, species_name),
    FOREIGN KEY (species_name)
        REFERENCES species (name),
    FOREIGN KEY (location_name)
        REFERENCES location (name)
);

-- 5

INSERT INTO location VALUES
    ('Location A', 0, 0),
    ('Location B', 30, -30),
    ('Location C', -10, 10);
UPDATE location 
    SET name = 'Location F'
    WHERE name = 'Location C';
DELETE FROM location
    WHERE name = 'Location F';

INSERT INTO species VALUES
    ('Ant', 'Bob', 'Dec-10-2014', 'Location A'),
    ('Badger', 'Carol', 'Jan-10-2014', 'Location B'),
    ('Shark', 'Evan', 'Dec-12-2014', 'Location A');
UPDATE species
    SET discovered_location_name = 'Location A'
    WHERE discovered_location_name != 'Location A';
DELETE FROM species
    WHERE discovered_date = 'Dec-12-2014';

INSERT INTO specimen VALUES
    ('Dec-22-2014', 'Ant', 'Location A', 'Hans'),
    ('Oct-12-2014', 'Badger', 'Location A', 'Hans'),
    ('Oct-12-2014', 'Ant', 'Location B', 'Hans');
UPDATE specimen
    SET collected_by = 'Verful'
    WHERE date < 'Dec-22-2014' AND collected_by = 'Hans';
DELETE FROM specimen
    WHERE location_name = 'Location B';

-- 6
SELECT species_name, date, collected_by, location_name, longitude, latitude 
FROM specimen
    INNER JOIN location ON specimen.location_name = location.name;

--7
CREATE VIEW specimen_log
    AS  SELECT species_name, date, collected_by, location_name, longitude, latitude 
        FROM specimen
            INNER JOIN location ON specimen.location_name = location.name;

--8

GRANT SELECT, INSERT
ON specimen_log
TO grad_student;

GRANT SELECT
ON species, specimen, location
TO grad_student;

GRANT ALL PRIVILEGES
ON specimen, species, location, specimen_log
TO egon;

GRANT SELECT
ON specimen_log
TO grant_supervisor;

--9

SELECT species_name, discovered_location_name, COUNT(specimen.location_name)
FROM species
    INNER JOIN specimen ON species.name = specimen.species_name
    INNER JOIN location ON species.discovered_location_name = location.name
    GROUP BY specimen.location_name, specimen.species_name, species.discovered_location_name
    ORDER BY species_name;

--10
SELECT species.name FROM species
WHERE EXISTS (
    SELECT name FROM location
    WHERE  longitude = 0 AND latitude = 0
    );
