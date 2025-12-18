create database assignment;
use assignment;

-- user table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
-- Insert Users
INSERT INTO users (name, email) VALUES
('Amit', 'amit@gmail.com'),
('Bhanu', 'bhanu@gmail.com'),
('Charan', 'charan@gmail.com'),
('Deepak', 'deepak@gmail.com');


-- Groups Table
CREATE TABLE groupss (
    group_id INT PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(100),
    created_by INT,
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);
-- Insert Group
INSERT INTO groupss (group_name, created_by)
VALUES ('Trip to Goa', 1);


-- Group Members Table
CREATE TABLE group_members (
    group_id INT,
    user_id INT,
    PRIMARY KEY (group_id, user_id),
    FOREIGN KEY (group_id) REFERENCES groupss(group_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Insert Group Members
INSERT INTO group_members (group_id, user_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4);

-- Expenses Table
CREATE TABLE expenses (
    expense_id INT PRIMARY KEY AUTO_INCREMENT,
    group_id INT,
    paid_by INT,
    total_amount DECIMAL(10,2),
    split_type ENUM('EQUAL','EXACT','PERCENTAGE'),
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES groupss(group_id),
    FOREIGN KEY (paid_by) REFERENCES users(user_id)
);
-- -- Equal split
INSERT INTO expenses 
(group_id, paid_by, total_amount, split_type, description)
VALUES
(1, 1, 1200.00, 'EQUAL', 'Hotel Booking');
-- Exact split
INSERT INTO expenses
(group_id, paid_by, total_amount, split_type, description)
VALUES
(1, 2, 900.00, 'EXACT', 'Food Bill');
-- Percentage split
INSERT INTO expenses
(group_id, paid_by, total_amount, split_type, description)
VALUES
(1, 3, 1000.00, 'PERCENTAGE', 'Travel Expenses');


-- Expense Splits Table
CREATE TABLE expense_splits (
    expense_id INT,
    user_id INT,
    amount DECIMAL(10,2),
    percentage DECIMAL(5,2),
    FOREIGN KEY (expense_id) REFERENCES expenses(expense_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
-- Expense 1(Equal Split)
INSERT INTO expense_splits (expense_id, user_id, amount)
VALUES
(1, 1, 300.00),
(1, 2, 300.00),
(1, 3, 300.00),
(1, 4, 300.00);
-- Expense 2 (Exact)
INSERT INTO expense_splits (expense_id, user_id, amount) VALUES
(2, 1, 400.00),
(2, 3, 300.00),
(2, 4, 200.00);
-- Expense 3 (Percentage)
INSERT INTO expense_splits (expense_id, user_id, percentage, amount) VALUES
(3, 1, 50.00, 500.00),
(3, 2, 30.00, 300.00),
(3, 4, 20.00, 200.00);


-- BALANCES TABLE (CORE)
CREATE TABLE balances (
    from_user INT,
    to_user INT,
    amount DECIMAL(10,2),
    PRIMARY KEY (from_user, to_user),
    FOREIGN KEY (from_user) REFERENCES users(user_id),
    FOREIGN KEY (to_user) REFERENCES users(user_id)
);
-- Insert Balances
-- Expense 1 (Amit paid)
INSERT INTO balances VALUES
(2, 1, 300.00),
(3, 1, 300.00),
(4, 1, 300.00);
-- Expense 2 (Bhanu paid)
INSERT INTO balances VALUES
(1, 2, 400.00),
(3, 2, 300.00),
(4, 2, 200.00);
-- Expense 3 (Charan paid)
INSERT INTO balances VALUES
(1, 3, 500.00),
(2, 3, 300.00),
(4, 3, 200.00);

-- SETTLEMENTS TABLE
CREATE TABLE settlements (
    settlement_id INT PRIMARY KEY AUTO_INCREMENT,
    from_user INT,
    to_user INT,
    amount DECIMAL(10,2),
    settled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (from_user) REFERENCES users(user_id),
    FOREIGN KEY (to_user) REFERENCES users(user_id)
);
-- Insert Settlement
INSERT INTO settlements (from_user, to_user, amount)
VALUES (2, 1, 300.00);

-- How much a user owes?
SELECT u.name, SUM(b.amount) AS total_owed
FROM balances b
JOIN users u ON b.from_user = u.user_id
GROUP BY b.from_user;

-- How much a user should receive?
SELECT u.name, SUM(b.amount) AS total_to_receive
FROM balances b
JOIN users u ON b.to_user = u.user_id
GROUP BY b.to_user;





