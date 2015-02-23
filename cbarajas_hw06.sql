-- 7.10
CREATE TABLE "Hotel Database"."Hotel"
(
    "hotelNo" integer NOT NULL,
    "hotelName" character varying(10), -- Name for the name of the hotels
    city character varying(10), -- Tells which city the hotel is in
    CONSTRAINT "hotelNo" PRIMARY KEY ("hotelNo")
)
WITH (
    OIDS=FALSE
);
ALTER TABLE "Hotel Database"."Hotel"
    OWNER TO postgres;

-- 7.11 (2 points)

CREATE TABLE "Hotel Database"."Room"
(
    "roomNo" integer NOT NULL,
    "hotelNo" integer NOT NULL,
    "type" character(6),
    "price" money,
    CONSTRAINT "roomNo limits" CHECK ("roomNo" > 0 AND "roomNo" < 101),
    CONSTRAINT "type can be 1 of 3" CHECK ("type" = 'Single' OR "type" = 'Double' OR "type" = 'Family'),
    CONSTRAINT "Price range" CHECK (price > money(10) AND price < money(100)),
    CONSTRAINT "Room P Key" PRIMARY KEY ("roomNo", "hotelNo"),
    CONSTRAINT "Room F Key" FOREIGN KEY ("hotelNo")
        REFERENCES "Hotel Database"."Hotel" ("hotelNo")
        ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Hotel Database"."Room"
    OWNER TO postgres;
-- 7.12 (include your INSERT/DELETE statements)

CREATE TABLE "Hotel Database"."Archive"
(
    "hotelNo" integer NOT NULL
    "guestNo" integer NOT NULL
    "dateFrom" date NOT NULL
    "dateTo" date 
    "roomNo" integer 
    CONSTRAINT "Archive P Keys" PRIMARY KEY ("hotelNo", "guestNo", "dateFrom")
    CONSTRAINT "Archive F Keys" FOREIGN KEY ("roomNo", "hotelNo")
        REFERENCES "Hotel Database"."Room" ("roomNo", "hotelNo")
        ON UPDATE NO ACTION ON DELETE NO ACTION
    CONSTRAINT "Archive Guest Number" FOREIGN KEY ("guestNo")
        REFERENCES "Hotel Database"."Guest" ("guestNo")
        ON UPDATE NO ACTION ON DELETE NO ACTION

);
  OIDS=FALSE
);
ALTER TABLE "Hotel Database"."Archive"
    OWNER TO postgres;
-- 7.13

-- 7.14

-- 7.15

-- 7.16

-- 7.17 (2 points)

-- Turn in a SQL file with DDL/DML for the assignment. Test your queries using PostgreSQL.
