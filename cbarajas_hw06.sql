-- 7.10
CREATE TABLE "hotel"
(
    "hotelNo" INTEGER NOT NULL PRIMARY KEY,
    "hotelName" VARCHAR(10), -- Name for the name of the hotels
    "city" VARCHAR(10) -- Tells which city the hotel is in
)

-- 7.11 (2 points)

CREATE TABLE "room"
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

CREATE TABLE "guest"
(
	guestNo INTEGER,
	guestName VARCHAR(50),
	guestAddress VARCHAR(50),
	PRIMARY KEY (guestNo)
)

CREATE TABLE "Booking"
(
    "hotelNo" INTEGER NOT NULL,
    "guestNo" INTEGER NOT NULL,
    "dateFrom" DATE NOT NULL,
    "dateTo" DATE,
    "roomNo" INTEGER,
    FOREIGN KEY ("hotelNo", "roomNo")
        REFERENCES "Room" ("hotelNo", "roomNo")
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY ("guestNo")
        REFERENCES  "Guest" ("guestNo")
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    CHECK ("dateTo" > date('today') AND "dateFrom" > date('today')),
    -- CONSTRAINT "No double Booking" CHECK ()
);
-- 7.12 (include your INSERT/DELETE statements)


-- 7.13
CREATE VIEW "PresentGuests" 
    AS SELECT "hotelName", "guestName" FROM"Booking"
        INNER JOIN "Guest" ON "Booking"."guestNo" = "Guest"."guestNo"
        INNER JOIN "Hotel" ON "Booking"."hotelNo" = "Hotel"."hotelNo";

-- 7.14

-- 7.15

-- 7.16

-- 7.17 (2 points)

-- Turn in a SQL file with DDL/DML for the assignment. Test your queries using PostgreSQL.
