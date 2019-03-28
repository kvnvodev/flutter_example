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

INSERT INTO order_status (name) VALUES ("New"), ("In Progress"), ("Canceled"), ("Done");