CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    price REAL DEFAULT 0,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES categories (id)
);

CREATE TABLE IF NOT EXISTS order_status (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    status_id INTEGER DEFAULT 1,
    total REAL DEFAULT 0,
    FOREIGN KEY (status_id) REFERENCES order_status (id)
);

CREATE TABLE IF NOT EXISTS order_details (
    product_id INTEGER,
    order_id INTEGER,
    price REAL,
    quantity INTEGER,
    PRIMARY KEY (product_id, order_id),
    FOREIGN KEY (product_id) REFERENCES products (id),
    FOREIGN KEY (order_id) REFERENCES orders (id)
);

INSERT INTO categories (name) VALUES ("Foods & Beverages"), ("Drinks");

INSERT INTO products (name, price, category_id) VALUES 
("Expresso", 30000, 2), 
("Latte", 34000, 2), 
("Cappuccino", 37000, 2), 
("Crossaints", 19000, 1), 
("Donuts", 16000, 1),
("Sandwich", 23000, 1),
("Hamburger", 34000, 1),
("Mashed potato", 23000, 1);

INSERT INTO order_status (name) VALUES ("New"), ("In Progress"), ("Canceled"), ("Done");

INSERT INTO orders (status_id) VALUES (1), (1), (1), (1);

INSERT INTO order_details (product_id, order_id, price, quantity) VALUES
(1, 1, 30000, 1),
(2, 1, 34000, 2),
(2, 2, 34000, 1),
(4, 2, 19000, 2),
(8, 2, 23000, 1),
(5, 3, 19000, 3),
(7, 3, 23000, 2),
(1, 3, 23000, 5);