CREATE TABLE IF NOT EXISTS users
(
  id            SERIAL      NOT NULL
    CONSTRAINT users_pkey
    PRIMARY KEY,
  name          VARCHAR(30) NOT NULL,
  email         VARCHAR(30),
  hash_password VARCHAR(56) NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS users_user_id_uindex
  ON users (id);

CREATE UNIQUE INDEX IF NOT EXISTS users_hash_password_uindex
  ON users (hash_password);

CREATE TABLE IF NOT EXISTS addresses
(
  id       serial      not null,
  user_id  integer     not null
  constraint user_id
  references users,
  city     varchar(14) not null,
  zip_code integer     not null,
  address  varchar(60) not null,
  country  varchar(20)
);

CREATE UNIQUE INDEX IF NOT EXISTS addresses_id_uindex
  ON addresses (id);

CREATE TABLE IF NOT EXISTS orders
(
  id                 SERIAL  NOT NULL,
  user_id            INTEGER NOT NULL
    CONSTRAINT user_id
    REFERENCES users,
  shipping_adress_id INTEGER NOT NULL
    CONSTRAINT shipping_address_id
    REFERENCES addresses (id),
  billing_address_id INTEGER NOT NULL
    CONSTRAINT billing_address_id
    REFERENCES addresses (id),
  status             VARCHAR(10)
);

CREATE UNIQUE INDEX IF NOT EXISTS orders_id_uindex
  ON orders (id);

CREATE TABLE IF NOT EXISTS suppliers
(
  id          SERIAL      NOT NULL
    CONSTRAINT suppliers_pkey
    PRIMARY KEY,
  name        VARCHAR(20) NOT NULL,
  description VARCHAR(200)
);

CREATE UNIQUE INDEX IF NOT EXISTS suppliers_id_uindex
  ON suppliers (id);

CREATE TABLE IF NOT EXISTS product_categories
(
  id          SERIAL      NOT NULL
    CONSTRAINT product_categories_pkey
    PRIMARY KEY,
  name        VARCHAR(12) NOT NULL,
  department  VARCHAR(12) NOT NULL,
  description VARCHAR(200)
);

CREATE UNIQUE INDEX IF NOT EXISTS product_categories_id_uindex
  ON product_categories (id);

CREATE TABLE IF NOT EXISTS products
(
  id                  SERIAL           NOT NULL
    CONSTRAINT products_pkey
    PRIMARY KEY,
  name                VARCHAR(12)      NOT NULL,
  default_price       DOUBLE PRECISION NOT NULL,
  default_currency    VARCHAR(3),
  product_category_id INTEGER
    CONSTRAINT product_category_id
    REFERENCES product_categories,
  supplier_id         INTEGER          NOT NULL
    CONSTRAINT supplier_id
    REFERENCES suppliers
);

CREATE UNIQUE INDEX IF NOT EXISTS products_id_uindex
  ON products (id);

CREATE TABLE IF NOT EXISTS cart_items
(
  product_id INTEGER NOT NULL,
  order_id   INTEGER NOT NULL,
  quantity   INTEGER,
  CONSTRAINT id
  PRIMARY KEY (order_id, product_id)
);


