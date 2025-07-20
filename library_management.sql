CREATE DATABASE LibraryDB;

USE LibraryDB;

CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100),
    Author VARCHAR(100),
    TotalCopies INT,
    AvailableCopies INT
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);

CREATE TABLE IssueRecords (
    IssueID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    MemberID INT,
    IssueDate DATE,
    ReturnDate DATE,
    Fine DECIMAL(5,2),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

INSERT INTO Books (Title, Author, TotalCopies, AvailableCopies)
VALUES 
('DBMS Concepts', 'Navathe', 5, 5),
('Java Programming', 'Herbert Schildt', 3, 3),
('Python Crash Course', 'Eric Matthes', 4, 4);

SELECT * FROM Books;
SELECT * FROM Members;

-- If BookID = 1 doesn't exist
INSERT INTO Books (Title, Author, TotalCopies, AvailableCopies)
VALUES ('DBMS Concepts', 'Navathe', 5, 5);

-- If MemberID = 1 doesn't exist
INSERT INTO Members (Name, Email, JoinDate)
VALUES ('Bhuvaneswari', 'bhuvi@gmail.com', '2025-01-01');

INSERT INTO IssueRecords (BookID, MemberID, IssueDate, ReturnDate, Fine)
VALUES (1, 1, CURDATE(), NULL, 0.00);

UPDATE Books SET AvailableCopies = AvailableCopies - 1 WHERE BookID = 1;

UPDATE IssueRecords 
SET ReturnDate = CURDATE(), Fine = DATEDIFF(CURDATE(), IssueDate) * 2
WHERE IssueID = 1;

UPDATE Books 
SET AvailableCopies = AvailableCopies + 1 
WHERE BookID = 1;

SELECT MemberID, SUM(Fine) AS TotalFine 
FROM IssueRecords 
GROUP BY MemberID;

CREATE VIEW BookStatus AS
SELECT Title, TotalCopies, AvailableCopies 
FROM Books;

SELECT * FROM BookStatus;

DELIMITER //

CREATE TRIGGER after_book_issue
AFTER INSERT ON IssueRecords
FOR EACH ROW
BEGIN
  UPDATE Books 
  SET AvailableCopies = AvailableCopies - 1 
  WHERE BookID = NEW.BookID;
END //

DELIMITER ;






