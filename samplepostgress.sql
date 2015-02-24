INSERT INTO hotel VALUES
(1, 'Hotel 1', 'London'),
(2, 'Hotel 2', 'Paris');

INSERT INTO guest VALUES
(1, 'Guest A', 'Address 1'),
(2, 'Guest B', 'Address 2'),
(3, 'Guest C', 'Address 3'),
(4, 'Guest D', 'Address 4'),
(5, 'Guest E', 'Address 5'),
(6, 'Guest F', 'Address 6');

INSERT INTO room VALUES
(1, 1, 'Single', 20),
(2, 1, 'Double', 30),
(3, 1, 'Family', 50),
(1, 2, 'Single', 20),
(2, 2, 'Double', 30),
(3, 2, 'Family', 50);

INSERT INTO booking VALUES
(1, 1, 'Dec-08-2015', 'Dec-20-2015', 1),
(1, 2, 'Dec-08-2015', 'Dec-20-2015', 2),
(1, 3, 'Dec-08-2015', 'Dec-20-2015', 3),
(2, 4, 'Dec-08-2015', 'Dec-20-2015', 1),
(2, 5, 'Dec-08-2015', 'Dec-20-2015', 2),
(2, 6, 'Dec-08-2015', 'Dec-20-2015', 3);

DROP TABLE booking;
DROP TABLE archive;
DROP TABLE guest;
DROP TABLE room;
DROP TABLE hotel;
