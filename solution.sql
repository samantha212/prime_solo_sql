-- 1.	Which authors are represented in our store?
SELECT * FROM authors;

-- 2.	Which authors are also distinguished authors?
SELECT * FROM authors 
INNER JOIN distinguished_authors
on authors.id = distinguished_authors.id;

-- 3.	Which authors are not distinguished authors?
SELECT * FROM authors 
LEFT OUTER JOIN distinguished_authors
ON authors.id = distinguished_authors.id
WHERE distinguished_authors.id IS null;


-- 4.	How many authors are represented in our store?
SELECT COUNT(*) FROM authors;

-- 5.	Who are the favorite authors of the employee with the first name of Michael?
SELECT authors_and_titles[1:3][1:1] FROM favorite_authors
INNER JOIN employees
ON favorite_authors.employee_id = employees.id
WHERE employees.first_name = 'Michael';


-- 6.	What are the titles of all the books that are in stock today?

SELECT books.title FROM books
INNER JOIN editions
ON editions.book_id = books.id
INNER JOIN stock
ON stock.isbn = editions.isbn
WHERE stock.stock > 0;

-- 7.	Insert one of your favorite books into the database. Hint: You’ll want to create data in at least 2 other tables to completely create this book.
INSERT INTO authors (id, last_name, first_name)
VALUES (5566, 'Lewis', 'C.S.');

INSERT INTO books (id, title, author_id, subject_id)
VALUES (212, 'The Lion, the Witch, and the Wardrobe', 5566, 3);

INSERT INTO editions (isbn, book_id, edition, publisher_id, publication, type)
VALUES (9780064471046, 212, 1, 67, '1950-10-16', 2);

-- 8.	What authors have books that are not in stock?
SELECT DISTINCT first_name, last_name FROM authors
INNER JOIN books
ON books.author_id = authors.id
INNER JOIN editions 
ON books.id = editions.book_id
INNER JOIN stock 
ON editions.isbn = stock.isbn
WHERE stock.stock = 0;

-- 9.	What is the title of the book that has the most stock?
SELECT books.title, SUM(stock.stock)
FROM books
INNER JOIN editions
ON editions.book_id = books.id
INNER JOIN stock
ON stock.isbn = editions.isbn
GROUP BY books.title
ORDER BY SUM(stock.stock) DESC
LIMIT 1;

