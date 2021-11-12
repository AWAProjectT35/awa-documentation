
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
| 3456789feh332   | Even Better Burgers  | Cheeseburger | very cheesy | 2.50  | ???   | burgers      |
| ertz5678tzu45   | Best Burgers         | Chicken King | chrispyyy   | 4.20  | ???   | cheesy,cheap |

### restaurants 

| restaurant_name (pk) | manager_name (fk) | address  | operating_hours | price_level | image | type      |
| -------------------- | ----------------- | -------  | --------------- | ----------- | ----- | --------- |
| Even Better Burgers  | Mark Ambitious    | Oulu     | 9:00 - 22:00    | $$          | ???   | dining in |
| Best Burgers         | Steven King       | Helsinki | 9:00 - 20:00    | $           | ???   | fastfood  |

### orders

| order_id (pk) | restaurant_name (fk)| user_name (fk) | status    | order_date | total       |
| ------------- | --------------------| -------------- | ------    | ---------- | ----------- |
| 31151         | Even Better Burgers | Nina Fisher    | delivered | 2021.11.05 | 27.20       |
| 11239         | Best Burgers        | Anna Greta     | preparing | 2021.10.22 | 16.50       |

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
    restaurant_name VARCHAR(50) NOT NULL PRIMARY KEY,
    manager_name VARCHAR(20) REFERENCES users (user_name),
    address VARCHAR(50) NOT NULL,
    operating_hours VARCHAR(20) NOT NULL,
    price_level VARCHAR(3) NOT NULL,
    type VARCHAR(20) NOT NULL,
    image VARCHAR(100) NOT NULL,
);
create table products (
    product_id VARCHAR(50) NOT NULL PRIMARY KEY,
    restaurant_name VARCHAR(50) REFERENCES restaurant (restaurant_name),
    name VARCHAR(50) NOT NULL,
    description VARCHAR(150),
    price FLOAT8 NOT NULL,
    image VARCHAR(100),
    categories VARCHAR(100)
);
create table orders (
    order_id VARCHAR(50) NOT NULL PRIMARY KEY,
    restaurant_name VARCHAR(50) REFERENCES restaurants (restaurant_name),
    user_name VARCHAR(20) REFERENCES users (user_name),
    status VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    total FLOAT8 NOT NULL
);
create table orders_products (
    order_id VARCHAR(50) REFERENCES orders (order_id),
    product_id VARCHAR(50) REFERENCES products (product_id),
    amount INT NOT NULL,
    unit_price FLOAT8 NOT NULL,
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
WHERE restaurant_name = '?';
```
### Search restaurants

```sql
SELECT * FROM products 
WHERE restaurant_name LIKE '?'
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
SELECT status FROM orders 
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
    'restaurant_name
    'manager_name',
    'address',
    'price_level',
    'operating_hours',
    'image',
    'type'
);
```

### Insert product

```sql
INSERT INTO products VALUES (
    'product_id',
    'restaurant_name',
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
    'restaurant_name',
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
UPDATE orders SET status = '?'
WHERE order_id = '?'
```