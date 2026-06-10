---Queries---
--finding all available books---
SELECT title, available_copies
FROM books
WHERE available_copies > 0;

---Find books published after 2010---
SELECT title, available_copies
FROM books
WHERE available_copies > 2010;

---Sort books by title---
SELECT *
FROM books
ORDER BY title ASC;

---Count total books--
SELECT COUNT(*) AS total_books
FROM books;

---Count total members---
SELECT COUNT(*) AS total_members
FROM members;

---Find total available copies---
SELECT SUM(available_copies) AS total_available
FROM books;

---Find total available copies---
SELECT SUM(available_copies) AS total_available
FROM books;

---Find average copies per book---
SELECT AVG(total_copies) AS average_copies
FROM books;

---List all borrowed books with member names---
SELECT
    m.full_name,
    b.title,
    br.borrow_date,
    br.due_date
FROM borrow_records br
JOIN members m
ON br.member_id = m.member_id
JOIN books b
ON br.book_id = b.book_id;

---List returned books---
SELECT * FROM borrow_records
WHERE return_date IS NOT NULL;

---List books not yet returned---
SELECT * FROM borrow_records
WHERE return_date IS NULL;

---Find overdue books---
SELECT
    m.full_name,
    b.title,
    br.due_date
FROM borrow_records br
JOIN members m
ON br.member_id = m.member_id
JOIN books b
ON br.book_id = b.book_id
WHERE br.return_date IS NULL
AND br.due_date < CURRENT_DATE;
 SELECT * FROM books;

 ---Count how many books each member borrowed---
 SELECT
    m.full_name,
    COUNT(br.borrow_id) AS books_borrowed
FROM members m
JOIN borrow_records br
ON m.member_id = br.member_id
GROUP BY m.full_name;

---Find the most borrowed books---
SELECT
    b.title,
    COUNT(br.book_id) AS borrow_count
FROM books b
JOIN borrow_records br
ON b.book_id = br.book_id
GROUP BY b.title
ORDER BY borrow_count DESC;

----Find unpaid fines---
SELECT * FROM fine
WHERE paid_status = 'Unpaid';

---Calculate total fine amount---
SELECT SUM(fine_amount) AS total_fine
FROM fine;

---Show member name and fine amount---
SELECT
    m.full_name,
    f.fine_amount
FROM fine f
JOIN borrow_records br
ON f.borrow_id = br.borrow_id
JOIN members m
ON br.member_id = m.member_id;

---Find books by a specific author---
SELECT *
FROM books
WHERE author = 'Paulo Coelho';

---Find members who borrowed more than one book---
SELECT
    member_id,
    COUNT(*) AS total
FROM borrow_records
GROUP BY member_id
HAVING COUNT(*) > 1;
SELECT * FROM members;

---Use a window function to rank books by borrow count---
SELECT
    b.title,
    COUNT(br.book_id) AS borrow_count,
    RANK() OVER (ORDER BY COUNT(br.book_id) DESC) AS ranking
FROM books b
LEFT JOIN borrow_records br
ON b.book_id = br.book_id
GROUP BY b.title;

---Create a view for borrowed books---
CREATE VIEW borrowed_books_view AS
SELECT
    m.full_name,
    b.title,
    br.borrow_date,
    br.due_date
FROM borrow_records br
JOIN members m
ON br.member_id = m.member_id
JOIN books b
ON br.book_id = b.book_id;
SELECT * FROM borrowed_books_view;

