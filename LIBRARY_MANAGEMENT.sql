CREATE DATABASE Library_management;

USE Library_management;
create table authors(
author_id INT  AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
birth_year int
);

create table books(
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255),
genre varchar(50),
publication_year int,
author_id int,
foreign key (author_id) references authors(author_id)
);

create table users(
user_id int auto_increment primary key,
first_name varchar(50),
last_name  varchar(50),
email varchar(100)
);

create table TRANSACTIONS(
transaction_id int auto_increment primary key,
book_id INT,
user_id INT,
borrow_date DATE,
due_date DATE,
return_date date,
foreign key (book_id) references books(book_id),
FOREIGN  key (user_id) references users(user_id)
);

INSERT INTO authors (first_name, last_name, birth_year)
VALUES 
('George', 'Orwell', 1903),
('Jane', 'Austen', 1775),
('J.K.', 'Rowling', 1965);

INSERT INTO books (title, genre, publication_year, author_id)
VALUES 
('1984', 'Dystopian', 1949, 1),
('Pride and Prejudice', 'Romance', 1813, 2),
('Harry Potter and the Philosopher\'s Stone', 'Fantasy', 1997, 3);

INSERT INTO users (first_name, last_name, email)
VALUES 
('John', 'Doe', 'johndoe@example.com'),
('Mary', 'Smith', 'marysmith@example.com');

INSERT INTO transactions (book_id, user_id, borrow_date, due_date)
VALUES 
(1, 1, '2025-01-01', '2025-01-14'),
(2, 2, '2025-01-05', '2025-01-19');

SELECT title, genre, publication_year
FROM books
WHERE author_id = 1;  -- Get books by George Orwell

SELECT first_name, last_name, email
FROM users;

SELECT b.title, t.borrow_date, t.due_date
FROM transactions t
JOIN books b ON t.book_id = b.book_id
WHERE t.user_id = 1;  -- Get books borrowed by John Doe

select a.first_name,a.last_name,b.title
from authors a
join books b on a.author_id = b.author_id
where b.publication_year >1900;

SELECT u.first_name, u.last_name, b.title, t.borrow_date, t.due_date, t.return_date
FROM transactions t
JOIN users u ON t.user_id = u.user_id
JOIN books b ON t.book_id = b.book_id
WHERE t.return_date IS NOT NULL;

SELECT u.first_name, u.last_name, b.title, t.due_date
FROM transactions t
JOIN users u ON t.user_id = u.user_id
JOIN books b ON t.book_id = b.book_id
WHERE t.due_date < CURDATE() AND t.return_date IS NULL;

ALTER TABLE transactions
ADD COLUMN fine DECIMAL(5, 2) DEFAULT 0.00;

UPDATE transactions
SET fine = DATEDIFF(CURDATE(), due_date)
WHERE due_date < CURDATE() AND return_date IS NULL;

SELECT u.first_name, u.last_name, b.title, t.due_date, t.fine
FROM transactions t
JOIN users u ON t.user_id = u.user_id
JOIN books b ON t.book_id = b.book_id
WHERE t.due_date < CURDATE() AND t.return_date IS NULL;











