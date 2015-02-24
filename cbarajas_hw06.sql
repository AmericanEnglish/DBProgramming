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
    AS SELECT hotelName, allbookings.roomNo, guest.guestNo, guest.guestName, allbookings.dateFrom, allbookings.dateTo FROM  
    (SELECT * FROM booking UNION SELECT * FROM archive) AS allbookings 
        INNER JOIN guest ON allbookings.guestNo = guest.guestNo
        INNER JOIN hotel ON allbookings.hotelno = hotel.hotelno
    WHERE hotelname = 'Grosvenor';
-- 7.15
GRANT ALL PRIVILEGES
ON presentguests, grosvenorguests
TO (Manager, Director);
-- 7.16
GRANT SELECT
ON presentguests, grosvenorguests
TO Accounts;

REVOKE SELECT
ON presentguests, grosvenorguests
FROM Accounts;
-- 7.17 (2 points)
    --a.) Valid, pulls the hotelno from hotel and then the count value from the select statement (which targets the booking table)
    --b.) Valid, pulls the hotelno. The query maps over both hotel and room because the hotelnos must exist in both
    --c.) Valid, It selects the minimum value from the view. This maps over the booking and room on roomno and then see which hotel has the minimum guests book by rooms booked
    --d.) Valid, maps over hotel, room, and booking counting only where the roomnos of room and booking match up as well as the hotelno and the roomno match up
    --e.) Valid,  Combs over hotel and room where the hotelnos match up and then combs over room and booking where the sum of booking.roomno and room.roomno  for one hotel is greater than 1k
    --f.) Valid, It seems that selecting hotelno from hotelbookingcount maps over all three but the select maps over hotel and room because it is pulling values where h.hotelno = r.hotelno. The orderby maps over booking and room where their numbers are equivalent
-- Turn in a SQL file with DDL/DML for the assignment. Test your queries using PostgreSQL.
