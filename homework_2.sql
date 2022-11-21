
CREATE TABLE customers
(
    id       INT IDENTITY,
    name     VARCHAR(50) NOT NULL,
    address  VARCHAR(200) NOT NULL,
    email    VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    CONSTRAINT pk_customer_id PRIMARY KEY (id),
);

CREATE TABLE product_stock_status
(
    id   INT IDENTITY,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_product_stock_status_id PRIMARY KEY (id),
);

CREATE TABLE product_categories
(
    id       INT IDENTITY,
    name     VARCHAR(50) NOT NULL,
    CONSTRAINT pk_product_category_id PRIMARY KEY (id),
);

CREATE TABLE products
(
    id                  INT IDENTITY,
    name                VARCHAR(50)   NOT NULL,
    ek_price            DECIMAL(7, 2) NOT NULL,
    vk_price            DECIMAL(7, 2) NOT NULL,
    product_stock_id    INT           NOT NULL,
    product_category_id INT           NOT NULL,
    CONSTRAINT pk_product_id PRIMARY KEY (id),
    CONSTRAINT fk_product_stock_id
        FOREIGN KEY (product_stock_id) REFERENCES product_stock_status (id),
    CONSTRAINT fk_product_category_id
        FOREIGN KEY (product_category_id) REFERENCES product_categories (id),
);

CREATE TABLE orders
(
    id          INT IDENTITY,
    customer_id INT      NOT NULL,
    timestamp   DATETIME NOT NULL,
    ip          VARCHAR(50),
    CONSTRAINT pk_order_id PRIMARY KEY (id),
    CONSTRAINT fk_customer_id
        FOREIGN KEY (customer_id) REFERENCES customers (id),
)

CREATE TABLE positions
(
    id            INT IDENTITY,
    count_ordered INT NOT NULL,
    order_id      INT NOT NULL,
    product_id    INT NOT NULL,
    CONSTRAINT pk_position PRIMARY KEY (id),
    CONSTRAINT fk_order_id
        FOREIGN KEY (order_id) REFERENCES orders (id),
    CONSTRAINT fk_product_id
        FOREIGN KEY (product_id) REFERENCES products (id),
)