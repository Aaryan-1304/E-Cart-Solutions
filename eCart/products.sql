CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_type VARCHAR(50) NOT NULL,
    product_price NUMERIC(10, 2) NOT NULL,
    product_name VARCHAR(100) NOT NULL
);
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_type VARCHAR(50) NOT NULL,
    product_price NUMERIC(10, 2) NOT NULL,
    product_name VARCHAR(100) NOT NULL
);

INSERT INTO products (product_type, product_price, product_name) VALUES
('Electronics', 1500.00, 'Smartphone'),
('Electronics', 35000.00, 'Laptop'),
('Clothing', 1200.00, 'Jeans'),
('Clothing', 500.00, 'T-Shirt'),
('Home Appliance', 4500.00, 'Microwave'),
('Home Appliance', 12000.00, 'Refrigerator'),
('Books', 300.00, 'Science Fiction Novel'),
('Books', 200.00, 'History Book'),
('Toys', 700.00, 'Action Figure'),
('Toys', 1500.00, 'Lego Set'),
('Groceries', 150.00, 'Rice Pack'),
('Groceries', 300.00, 'Olive Oil'),
('Electronics', 2500.00, 'Bluetooth Speaker'),
('Clothing', 1500.00, 'Jacket'),
('Home Appliance', 3500.00, 'Blender'),
('Books', 600.00, 'Cooking Guide'),
('Toys', 500.00, 'Board Game'),
('Groceries', 100.00, 'Sugar'),
('Electronics', 8000.00, 'Tablet'),
('Clothing', 1000.00, 'Sneakers'),
('Home Appliance', 5000.00, 'Vacuum Cleaner'),
('Books', 450.00, 'Mystery Novel'),
('Toys', 850.00, 'Puzzle'),
('Groceries', 250.00, 'Spices Set');
SELECT * FROM products