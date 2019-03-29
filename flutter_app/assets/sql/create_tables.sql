-- 1
CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    active INTEGER DEFAULT 1,
    parent_category_id INTEGER DEFAULT NULL,
    FOREIGN KEY (parent_category_id)
        REFERENCES categories (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CHECK (active = 0 OR active = 1)
);

-- 2
CREATE TABLE IF NOT EXISTS products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    price REAL DEFAULT 0,
    quantity INTEGER DEFAULT 0,
    category_id INTEGER,
    FOREIGN KEY (category_id)
        REFERENCES categories (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CHECK (price >= 0 AND quantity >= 0)
);

-- 3
CREATE TABLE IF NOT EXISTS customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    address TEXT NOT NULL
);

-- 4
CREATE TABLE IF NOT EXISTS orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    FOREIGN KEY (customer_id)
        REFERENCES customers (id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

-- 5
CREATE TABLE IF NOT EXISTS order_details (
    order_id INTEGER,
    product_id INTEGER,
    FOREIGN KEY (order_id)
        REFERENCES orders (id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (product_id)
        REFERENCES products (id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);


select d.order_id, p.id as product_id, p.name as product_name, d.price as price, d.quantity
from order_details d
left join products p
on p.id = d.product_id
where d.order_id = 1;