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
    REFERENCE NEW AS new
    BEGIN
        IF new.type = 'Double' AND new.price < money(100)
            RAISE EXCEPTION 'Doubles must not be less than 100 euros'
        END IF
    END;

-- c. 
