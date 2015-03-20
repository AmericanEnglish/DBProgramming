-- (2 points) Write a stored procedure for exercise 6.8, making city a parameter.
--   List full details of all hotels in london
CREATE PROCEDURE londonhotels 
AS 
SELECT hotelNo, hotelName
FROM hotel 
WHERE city = 'London';

-- (2 points) Write a stored procedure for exercise 6.10, making the price a parameter.
--   List all double or family rooms with a price below 40.00 euro per night in ascending order of price


-- (2 points each) Complete exercises 8.11 a, c, e. create triggers for
-- a.  price of all double rooms greater than 100 euro
-- c. 
