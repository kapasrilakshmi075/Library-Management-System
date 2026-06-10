---Create the books table---
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    publisher VARCHAR(100),
    published_year INT,
    isbn VARCHAR(20) UNIQUE,
    total_copies INT NOT NULL,
    available_copies INT NOT NULL
);
SELECT * FROM books;

---Create the members table---
CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    join_date DATE DEFAULT CURRENT_DATE
);
SELECT * FROM members;

---Create the staff table---
CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE
);
SELECT * FROM staff;

---Create the borrow_records table---
CREATE TABLE borrow_records (
    borrow_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    book_id INT REFERENCES books(book_id),
    borrow_date DATE DEFAULT CURRENT_DATE,
    due_date DATE,
    return_date DATE
);
SELECT * FROM borrow_records;

---Create the fine table---
CREATE TABLE fine (
    fine_id SERIAL PRIMARY KEY,
    borrow_id INT REFERENCES borrow_records(borrow_id),
    fine_amount DECIMAL(10,2),
    paid_status VARCHAR(20) DEFAULT 'Unpaid'
);
SELECT * FROM fine;

---Insert data into books---
INSERT INTO books (title, author, genre, publisher, published_year, isbn, total_copies, available_copies)
VALUES
('The Alchemist', 'Paulo Coelho', 'Fiction', 'Harper', 1988, '9780061122415', 10, 8),
('Harry Potter', 'J.K. Rowling', 'Fantasy', 'Bloomsbury', 1997, '9780747532743', 15, 12),
('Clean Code', 'Robert C. Martin', 'Programming', 'Prentice Hall', 2008, '9780132350884', 5, 5);
SELECT * FROM books;

---Insert data into members---
INSERT INTO members (full_name, email, phone, address)
VALUES
('Rahul Sharma', 'rahul@example.com', '9876543210', 'Hyderabad'),
('Priya Reddy', 'priya@example.com', '9876543211', 'Vijayawada'),
('Arjun Kumar', 'arjun@example.com', '9876543212', 'Visakhapatnam');
SELECT * FROM members;

---Insert data into staff---
INSERT INTO staff (full_name, position, phone, email)
VALUES
('Anita Rao', 'Librarian', '9876500001', 'anita@example.com'),
('Suresh Kumar', 'Assistant', '9876500002', 'suresh@example.com');
SELECT * FROM staff;

---Insert data into borrow_records---
INSERT INTO borrow_records (member_id, book_id, due_date, return_date)
VALUES
(1, 1, '2026-06-20', NULL),
(2, 2, '2026-06-22', '2026-06-18'),
(3, 3, '2026-06-25', NULL);
SELECT * FROM borrow_records;

---Insert data into fine---
INSERT INTO fine (borrow_id, fine_amount, paid_status)
VALUES
(1, 50.00, 'Unpaid'),
(2, 0.00, 'Paid');
SELECT * FROM fine;


