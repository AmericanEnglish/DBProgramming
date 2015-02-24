-- 7.10
CREATE TABLE hotel
(
    hotelNo INTEGER NOT NULL PRIMARY KEY,
    hotelName VARCHAR(10), -- Name for the name of the hotels
    city VARCHAR(10) -- Tells which city the hotel is in
);

-- 7.11 (2 points)

CREATE TABLE room
(
    roomNo INTEGER NOT NULL,
    hotelNo INTEGER NOT NULL,
    type CHAR(6),
    price MONEY,
    CHECK (roomNo > 0 AND roomNo < 101),
    CHECK (type = 'Single' OR type = 'Double' OR type = 'Family'),
    CHECK (price >= MONEY(10) AND price <= MONEY(100)),
    PRIMARY KEY (roomNo, hotelNo),
    FOREIGN KEY (hotelNo)
        REFERENCES hotel (hotelNo)
        ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE guest
(
	guestNo INTEGER,
	guestName VARCHAR(50),
	guestAddress VARCHAR(50),
	PRIMARY KEY (guestNo)
);

CREATE TABLE booking
(
    hotelNo INTEGER NOT NULL,
    guestNo INTEGER NOT NULL,
    dateFrom DATE NOT NULL,
    dateTo DATE,
    roomNo INTEGER,
    PRIMARY KEY (hotelNo, guestNo, dateFrom),
    FOREIGN KEY (hotelNo, roomNo)
        REFERENCES room (hotelNo, roomNo),
    FOREIGN KEY (guestNo)
        REFERENCES  guest (guestNo),
    CHECK (dateTo > DATE('today') AND dateFrom > DATE('today'))
);
    -- CHECK( NOT EXISTS (
    --     SELECT *
    --     FROM "Booking"
    --         WHERE roomno = 1 
    --         AND hotelno = 1 
    --         AND (
    --             ('Dec-10-2015'BETWEEN datefrom AND dateto)
    --             OR
    --             ('Dec-1-2015' BETWEEN datefrom AND dateto)
    --             )
    --         )
    -- );


-- 7.12 (include your INSERT/DELETE statements)
CREATE TABLE archive
(
    hotelNo INTEGER NOT NULL,
    guestNo INTEGER NOT NULL,
    dateFrom DATE NOT NULL,
    dateTo DATE,
    roomNo INTEGER,
    PRIMARY KEY (hotelNo, guestNo, dateFrom)
);
INSERT INTO archive 
(
	SELECT hotelNo, guestNo, dateFrom, dateTo 
	FROM booking
	WHERE dateFrom < 'Jan-01-2013'
);
DELETE FROM booking
    WHERE datefrom < 'Jan-01-2013';

-- 7.13

CREATE VIEW presentguests
    AS SELECT hotelName, guestName FROM booking
        INNER JOIN guest ON booking.guestNo = guest.guestNo
        INNER JOIN hotel ON booking.hotelNo = hotel.hotelNo;

-- 7.14
CREATE VIEW grosvenorguests
    AS SELECT hotelName, hotel.hotelno, guest.guestNo, allbookings.dateFrom, allbookings.dateTo FROM  
    (SELECT * FROM booking UNION SELECT * FROM archive) AS allbookings 
        INNER JOIN guest ON allbookings.guestNo = guest.guestNo
        INNER JOIN hotel ON allbookings.hotelno = hotel.hotelno
        INNER JOIN room  ON allbookings.roomno =  room.roomno
    WHERE hotelname = 'Grosvenor';
-- 7.15

-- 7.16

-- 7.17 (2 points)

-- Turn in a SQL file with DDL/DML for the assignment. Test your queries using PostgreSQL.
