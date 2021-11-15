
# Database

## Tables

### users

| user_name (pk) | address  | manager | password_hash |
| -------------- | -------  | ------- | ------------- |
| John Doe       | Oulu     | FALSE   | 19vvz5%8vg208 |
| Mark Ambitious | Helsinki | TRUE    | 773bvo%8vg2b8 |

### products

| product_id (pk) | restaurant_name (fk) | name         | description | price | image | categories   |
| --------------- | -------------------- | ------------ | ----------- | ----- | ----- | ------------ |
| 3456789feh332   | Even Better Burgers  | Cheeseburger | very cheesy | 2.50  | /url1 | burgers      |
| ertz5678tzu45   | Best Burgers         | Chicken King | chrispyyy   | 4.20  | /url2 | cheesy,cheap |

### restaurants 

|restaurant_id(pk) | restaurant_name      | manager_name (fk) | address  | opens | closes | price_level | image | type      |
| ---------------- | -------------------- | ----------------- | -------  | ----- | ------ | ----------- | ----- | --------- |
| 7728c4vz43s927   | Even Better Burgers  | Mark Ambitious    | Oulu     | 9:00  | 22:00  | 2           | ???   | dining in |
| 77s4399qwr2927   | Best Burgers         | Steven King       | Helsinki | 9:00  | 20:00  | 1           | ???   | fastfood  |

### orders

| order_id (pk) | restaurant_id (fk) | user_name (fk) | order_status | order_date | total       |
| ------------- | ------------------ | -------------- | ------------ | ---------- | ----------- |
| 31151         | 7728c4vz43s927     | Nina Fisher    | delivered    | 2021.11.05 | 27.20       |
| 11239         | 77s4399qwr2927     | Anna Greta     | preparing    | 2021.10.22 | 16.50       |

### orders_products

| order_id (pk) | product_id (pk) | amount | unit_price |
| ------------- | --------------- | ------ | ---------- |
| 31151         | 3456789feh332   | 1      | 2.50       |
| 11239         | ertz5678tzu45   | 3      | 4.20       |



## Database Operations and SQL 

### Setup

```sql
create table users (
    user_name VARCHAR(50) NOT NULL PRIMARY KEY,
    address VARCHAR(50) NOT NULL,
    manager BOOLEAN NOT NULL,
    password_hash VARCHAR(50) NOT NULL,
);
create table restaurants (
    restaurant_id VARCHAR(50) NOT NULL PRIMARY KEY,
    restaurant_name VARCHAR(50) NOT NULL,
    manager_name VARCHAR(20) REFERENCES users (user_name),
    address VARCHAR(50) NOT NULL,
    opens VARCHAR(5) NOT NULL,
    closes VARCHAR(5) NOT NULL,
    price_level SMALLINT NOT NULL,
    type VARCHAR(20) NOT NULL,
    image VARCHAR(100) NOT NULL,
);
create table products (
    product_id VARCHAR(50) NOT NULL PRIMARY KEY,
    restaurant_id VARCHAR(50) REFERENCES restaurant (restaurant_id),
    name VARCHAR(50) NOT NULL,
    description VARCHAR(150),
    price NUMERIC NOT NULL,
    image VARCHAR(100),
    categories VARCHAR(100)
);
create table orders (
    order_id VARCHAR(50) NOT NULL PRIMARY KEY,
    restaurant_id VARCHAR(50) REFERENCES restaurants (restaurant_id),
    user_name VARCHAR(20) REFERENCES users (user_name),
    order_status VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    total NUMERIC NOT NULL
);
create table orders_products (
    order_id VARCHAR(50) REFERENCES orders (order_id),
    product_id VARCHAR(50) REFERENCES products (product_id),
    amount INT NOT NULL,
    unit_price NUMERIC NOT NULL,
    PRIMARY KEY(order_id, product_id)
)
```

### Get restaurants 

```sql
SELECT * FROM restaurants;
```

### Get menu for restaurant

```sql
SELECT * FROM products 
WHERE restaurant_id = '?';
```
### Search restaurants

```sql
SELECT * FROM products 
WHERE restaurant_id LIKE '?'
AND address LIKE '?'
AND type LIKE '?'
AND price_level LIKE '?';
```

### Get users orders

```sql
SELECT * FROM orders 
WHERE username_name = '?';
```

### Get order products

```sql
SELECT product_name, amount, amount * unit_price AS price FROM orders_products op 
WHERE order_id = '?' 
JOIN orders o ON o.order_id = op.order_id;
```

### Get order status

```sql
SELECT order_status FROM orders 
WHERE order_id = '?';
```
### Insert user or manager

```sql
INSERT INTO users values (
    'user_name',
    'address',
    'manager',
    'password_hash'
);
```


### Insert restaurant

```sql
INSERT INTO restaurants VALUES (
    'restaurant_name',
    'manager_name',
    'address',
    'price_level',
    'opens',
    'closes',
    'image',
    'type'
);
```

### Insert product

```sql
INSERT INTO products VALUES (
    'product_id',
    'restaurant_id',
    'name',
    'description',
    'price',
    'image',
    'categories'
);
```

### Insert order

```sql
INSERT INTO orders VALUES (
    'product_id',
    'restaurant_id',
    'user_name',
    'ordered',
    'datetoday',
    'total'
);
```
for every item in the order run:
```sql
INSERT INTO orders_products VALUES (
    'order_id',
    'product_id',
    'amount',
    'unit_price'
)
```

### Update order status

```sql
UPDATE orders SET order_status = '?'
WHERE order_id = '?'
```