
-- إنشاء قاعدة البيانات
CREATE DATABASE automation_exercise;
USE automation_exercise;

-- جدول المستخدمين
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    gender ENUM('Male', 'Female'),
    date_of_birth DATE,
    newsletter BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- جدول الفئات
CREATE TABLE Categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE
);

-- جدول العلامات التجارية
CREATE TABLE Brands (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE
);

-- جدول المنتجات
CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2),
    category_id INT,
    brand_id INT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(id),
    FOREIGN KEY (brand_id) REFERENCES Brands(id)
);

-- جدول عربة التسوق
CREATE TABLE CartItems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity INT,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

-- جدول الطلبات
CREATE TABLE Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DECIMAL(10,2),
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- جدول تفاصيل الطلبات
CREATE TABLE OrderItems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);
-- جدول عناوين الشحن
CREATE TABLE ShippingAddresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    full_name VARCHAR(100),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255) NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    country VARCHAR(100),
    phone_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- بيانات تجريبية
INSERT INTO Users (name, email, password, gender, date_of_birth, newsletter)
VALUES 
('Katrin', 'katrin@example.com', 'password123', 'Female', '2001-01-01', TRUE),
('Ahmed', 'ahmed@example.com', 'ahmedpass', 'Male', '1998-06-15', FALSE);

INSERT INTO Categories (name)
VALUES ('Women'), ('Men'), ('Kids');

INSERT INTO Brands (name)
VALUES ('Nike'), ('Adidas'), ('Puma');

INSERT INTO Products (name, description, price, category_id, brand_id, image_url)
VALUES 
('T-Shirt - Women', 'Comfortable cotton T-shirt', 15.99, 1, 1, 'tshirt1.jpg'),
('Running Shoes - Men', 'High performance shoes', 75.50, 2, 2, 'shoes1.jpg'),
('Kids Jacket', 'Warm and stylish jacket', 39.90, 3, 3, 'jacket1.jpg');

INSERT INTO CartItems (user_id, product_id, quantity)
VALUES (1, 1, 2), (2, 2, 1);

INSERT INTO Orders (user_id, total_amount, status)
VALUES (1, 31.98, 'Pending'), (2, 75.50, 'Shipped');

INSERT INTO OrderItems (order_id, product_id, quantity, price)
VALUES (1, 1, 2, 15.99), (2, 2, 1, 75.50);

INSERT INTO ShippingAddresses (user_id, full_name, address_line1, address_line2, city, state, zip_code, country, phone_number)
VALUES
(1, 'Katrin Youssef', '15 El-Tahrir Street', 'Flat 12, Floor 3', 'Cairo', 'Cairo', '11111', 'Egypt', '+20-100-0000000'),
(2, 'Ahmed El-Sayed', '220 Fouad Street', NULL, 'Alexandria', 'Alexandria', '22222', 'Egypt', '+20-122-2222222');
