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
