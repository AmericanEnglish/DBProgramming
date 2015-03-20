-- (2 points) Write a stored procedure for exercise 6.8, making city a parameter.
--   List full details of all hotels in london
CREATE PROCEDURE london_hotels
AS 
SELECT hotelNo, hotelName
FROM hotel 
WHERE city = 'London';

-- (2 points) Write a stored procedure for exercise 6.10, making the price a parameter.
--   List all double or family rooms with a price below 40.00 euro per night in ascending order of price

CREATE PROCEDURE singles_doubles_lt40
AS
SELECT room.hotelName, roomNo, price
FROM room
    INNER JOIN hotel ON room.hotelNo = hotel.hotelNo
WHERE price < money(40) 
    AND (type = 'Double' OR type = 'Family')
ORDER BY price;

-- (2 points each) Complete exercises 8.11 a, c, e. create triggers for
-- a.  price of all double rooms greater than 100 euro
CREATE TRIGGER doubles_under_100
    BEFORE INSERT ON room
    REFERENCE NEW AS new_room
    BEGIN
        IF new_room.type = 'Double' AND new_room.price < money(100)
            RAISE EXCEPTION 'Doubles must not be less than 100 euros'
        END IF
    END;

-- c.  A booking cannot be for a hotel room that is already booked for any of the specified dates
CREATE TRIGGER booking_check
    BEFORE INSERT ON booking
    REFERENCE NEW AS new_booking
    BEGIN
        IF EXISTS (
            SELECT *
            FROM booking
            WHERE roomno = new_booking.roomno 
                AND hotelno = new_booking.hotelno
                AND (
                    (new_booking.dateto BETWEEN datefrom AND dateto)
                    OR
                    (new_booking.datefrom BETWEEN datefrom AND dateto)
                    )
            )
            RAISE EXCEPTION 'Room cannot be double booked'
        END IF
    END;

-- e. maintain an audit table with names and addresses of all guests who make bookings for hotels in london. No duplicate guests.
CREATE TRIGGER audit_insert
    AFTER INSERT ON guests
    REFERENCE NEW AS new_guest
    BEGIN
        IF new_guest NOT IN (SELECT * FROM audit_table)
            INSERT INTO audit_table VALUES (new_guest)
        END IF
    END;
            
