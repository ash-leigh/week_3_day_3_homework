DROP TABLE pets;
DROP TABLE stores;

CREATE TABLE stores (
  id SERIAL4 primary key,
  name VARCHAR(255),
  address VARCHAR(255),
  stock_type VARCHAR(255)
);

CREATE TABLE pets (
  id SERIAL4 primary key,
  name VARCHAR(255),
  type VARCHAR(255),
  store_id INT4 references stores(id)
);