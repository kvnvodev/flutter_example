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
