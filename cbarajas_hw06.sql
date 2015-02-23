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
    "roomNo" INTEGER NOT NULL PRIMARY KEY,
    "hotelNo" INTEGER NOT NULL PRIMARY KEY,
    "type" CHAR(6),
    "price" MONEY,
    CONSTRAINT "roomNo limits" CHECK ("roomNo" > 0 AND "roomNo" < 101),
    CONSTRAINT "type can be 1 of 3" CHECK ("type" = 'Single' OR "type" = 'Double' OR "type" = 'Family'),
    CONSTRAINT "Price range" CHECK (price > MONEY(10) AND price < MONEY(100)),
    CONSTRAINT "Room F Key" FOREIGN KEY ("hotelNo")
        REFERENCES "Hotel" ("hotelNo")
        ON UPDATE NO ACTION ON DELETE NO ACTION

CREATE TABLE "Booking"
(
    "hotelNo" INTEGER NOT NULL,
    "guestNo" INTEGER NOT NULL,
    "dateFrom" date NOT NULL,
    "dateTo" date,
    "roomNo" INTEGER,
    CONSTRAINT "Booking P Key" PRIMARY KEY ("hotelNo", "guestNo", "dateTo"),
    CONSTRAINT "Booking F Key" FOREIGN KEY ("hotelNo", "roomNo")
        REFERENCES "Room" ("hotelNo", "roomNo")
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT "Booking F Key guestNo" FOREIGN KEY ("guestNo")
        REFERENCES  "Guest" ("guestNo")
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT "Date validity" CHECK ("dateTo" > date('today') AND "dateFrom" > date('today')),
    -- CONSTRAINT "No double Booking" CHECK ()
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Booking"
    OWNER TO postgres;
-- 7.12 (include your INSERT/DELETE statements)

CREATE TABLE "Archive"
(
    "hotelNo" INTEGER NOT NULL
    "guestNo" INTEGER NOT NULL
    "dateFrom" date NOT NULL
    "dateTo" date 
    "roomNo" INTEGER 
    CONSTRAINT "Archive P Keys" PRIMARY KEY ("hotelNo", "guestNo", "dateFrom")
    CONSTRAINT "Archive F Keys" FOREIGN KEY ("roomNo", "hotelNo")
        REFERENCES "Room" ("roomNo", "hotelNo")
        ON UPDATE NO ACTION ON DELETE NO ACTION
    CONSTRAINT "Archive Guest Number" FOREIGN KEY ("guestNo")
        REFERENCES "Guest" ("guestNo")
        ON UPDATE NO ACTION ON DELETE NO ACTION

);
  OIDS=FALSE
);
ALTER TABLE "Archive"
    OWNER TO postgres;
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
