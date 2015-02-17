-- 6.45
SELECT copyno
FROM
    bookcopy INNER JOIN book ON bookcopy.ISBN = book.ISBN
-- Assuming available = 1 means the copy is ready to be checked out
-- and available = 0 means the copy cannot be checked out
WHERE available = 1 AND title = 'Lord of the Rings';

--6.46
SELECT borrowername
FROM book
    INNER JOIN bookcopy ON bookcopy.ISBN = book.ISBN
    INNER JOIN bookloan ON bookloan.copyno = bookcopy.copyno
    INNER JOIN borrower ON borrower.borrowerno = bookloan.borrowerno
WHERE title = 'Lord of the Rings';

--6.47
SELECT DISTINCT borrowername
    FROM bookloan
        INNER JOIN borrower ON bookloan.borrowerno = borrower.borrowerno
WHERE date(datedue) < date('now');

--6.48
SELECT count(ISBN)
    FROM bookcopy
WHERE ISBN = '0-321-52306-7';

--6.49
SELECT count(bookcopy.ISBN) - count(bookloan.dateout) AS 'remaining'
FROM bookcopy
    LEFT JOIN  bookloan ON bookcopy.copyno = bookloan.copyno
WHERE ISBN = '0-321-52306-7';

--6.50
SELECT COUNT(ISBN)
FROM  bookcopy
    INNER JOIN bookloan ON bookcopy.copyno = bookloan.copyno
WHERE ISBN = '0-321-52306-7';

--6.51
SELECT title, bookcopy.ISBN, bookcopy.copyno
FROM book
    INNER JOIN bookcopy ON bookcopy.ISBN = book.ISBN
    INNER JOIN bookloan ON bookloan.copyno = bookcopy.copyno
    INNER JOIN borrower ON borrower.borrowerno = bookloan.borrowerno
WHERE borrowername = 'Peter Bloomfield';

--6.52
SELECT borrowername, book.title
FROM book
    INNER JOIN bookcopy ON book.ISBN = bookcopy.ISBN
    INNER JOIN bookloan ON bookcopy.copyno = bookloan.copyno
    INNER JOIN
    (
    SELECT title, COUNT(bookcopy.copyno) as copies
    FROM bookcopy
        INNER JOIN  book ON bookcopy.ISBN = book.ISBN
        GROUP BY title
        HAVING copies > 2
    ) AS booktotals ON book.title = booktotals.title
    INNER JOIN borrower ON bookloan.borrowerno = borrower.borrowerno

--6.53
SELECT borrowerno, borrowername, borroweraddress
FROM  bookloan
    INNER JOIN borrower ON bookloan.borrowerno = borrower.borrowerno
WHERE date(datedue) < date('now')

--6.54
SELECT title, COUNT(bookloan.copyno) AS 'number borrowed'
FROM book
    LEFT JOIN bookcopy ON bookcopy.ISBN = book.ISBN
    LEFT JOIN bookloan ON bookloan.copyno = bookcopy.copyno
    GROUP BY title;