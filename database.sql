-- Create Database
CREATE DATABASE restaurant_db;
USE restaurant_db;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

-- Menu Table
CREATE TABLE Menu (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order Items Table
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Menu(item_id)
);

-- Sample Inserts
INSERT INTO Customers (name, email, phone) VALUES
('John Doe', 'john@example.com', '9876543210'),
('Jane Smith', 'jane@example.com', '9123456780');

INSERT INTO Menu (item_name, price, category) VALUES
('Pizza', 250.00, 'Main Course'),
('Burger', 120.00, 'Snacks'),
('Pasta', 200.00, 'Main Course');

-- Sample Order
INSERT INTO Orders (customer_id, total_amount) VALUES (1, 370.00);

INSERT INTO Order_Items (order_id, item_id, quantity, subtotal) VALUES
(1, 1, 1, 250.00),
(1, 2, 1, 120.00);

-- Example Queries

-- Get all orders with customer details
SELECT o.order_id, c.name, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

-- Total revenue
SELECT SUM(total_amount) AS total_revenue FROM Orders;

-- Item-wise sales
SELECT m.item_name, SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Menu m ON oi.item_id = m.item_id
GROUP BY m.item_name;
