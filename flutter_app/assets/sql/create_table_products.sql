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
