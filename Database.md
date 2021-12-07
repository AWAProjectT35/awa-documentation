
# Database

## Tables

### users

| user_name (pk) | address  | manager | password_hash |
| -------------- | -------  | ------- | ------------- |
| John Doe       | Oulu     | FALSE   | 19vvz5%8vg208 |
| Mark Ambitious | Helsinki | TRUE    | 773bvo%8vg2b8 |

### products

| product_id (pk) | restaurant_id (fk) | name         | description | price | image | categories   |
| --------------- | ------------------ | ------------ | ----------- | ----- | ----- | ------------ |
| 11583           | 43956              | Cheeseburger | very cheesy | 2.50  | /url1 | burgers      |
| 59832           | 78931              | Chicken King | chrispyyy   | 4.20  | /url2 | cheesy,cheap |

### restaurants 

| restaurant_id (pk) | restaurant_name      | manager_name (fk) | address  | opens | closes | price_level | image   | type      |
| ------------------ | -------------------- | ----------------- | -------  | ----- | ------ | ----------- | ------- | --------- |
| 43956              | Even Better Burgers  | Mark Ambitious    | Oulu     | 9:00  | 22:00  | 2           | /url1   | dining in |
| 78931              | Best Burgers         | Steven King       | Helsinki | 9:00  | 20:00  | 1           | /url2   | fastfood  |

### orders

| order_id (pk) | restaurant_id (fk) | user_name (fk) | order_status | order_date | total       | delivery_address    | eta    | 
| ------------- | ------------------ | -------------- | ------------ | ---------- | ----------- | ------------------- | ------ |
| 31151         | 43956              | Nina Fisher    | 1            | 2021.11.05 | 27.20       | Tutkijantie 7, Oulu | 19:30  |
| 11239         | 78931              | Anna Greta     | 2            | 2021.10.22 | 16.50       | Adlerweg 23, Zürich | 12:25  |

### orders_products

| order_id (pk) | product_id (pk) | amount | product_price |
| ------------- | --------------- | ------ | ---------- |
| 31151         | 11583           | 1      | 2.50       |
| 11239         | 59832           | 3      | 4.20       |


## Migrations 

To setup and take down the database use the migration files. `migration-up.sql`
will setup the database and insert some data in each table. `miration-down.sql` 
drops all tables and sequences. The files are linked here:

[Migration Up](./sql/migration-up.sql)

[Migration Down](./sql/migration-down.sql)

## Database Operations and SQL 

### Setup

Do not use this to setup the database. Use the migrations above instead

```sql
create sequence restaurant_pk_seq;
create sequence product_pk_seq;
create sequence order_pk_seq;

create table users (
    user_name VARCHAR(50) NOT NULL PRIMARY KEY,
    address VARCHAR(50) NOT NULL,
    manager BOOLEAN NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
);
create table restaurants (
    restaurant_id INT NOT NULL PRIMARY KEY DEFAULT NEXTVAL('restaurant_pk_seq'),
    restaurant_name VARCHAR(50) UNIQUE NOT NULL,
    manager_name VARCHAR(20) REFERENCES users (user_name),
    address VARCHAR(50) NOT NULL,
    opens VARCHAR(5) NOT NULL,
    closes VARCHAR(5) NOT NULL,
    price_level SMALLINT NOT NULL,
    type VARCHAR(20) NOT NULL,
    image VARCHAR(100) NOT NULL,
);
create table products (
    product_id INT NOT NULL PRIMARY KEY DEFAULT NEXTVAL('product_pk_seq'),
    restaurant_id INT REFERENCES restaurants (restaurant_id),
    product_name VARCHAR(50) NOT NULL,
    description VARCHAR(150),
    price NUMERIC NOT NULL,
    image VARCHAR(100),
    categories VARCHAR(100)
);
create table orders (
    order_id INT NOT NULL PRIMARY KEY DEFAULT NEXTVAL('order_pk_seq'),
    restaurant_id INT REFERENCES restaurants (restaurant_id),
    user_name VARCHAR(50) REFERENCES users (user_name),
    order_status SMALLINT NOT NULL,
    order_date DATE NOT NULL,
    total NUMERIC NOT NULL,
    delivery_address VARCHAR(255)
);
create table orders_products (
    order_id INT REFERENCES orders (order_id),
    product_id INT REFERENCES products (product_id),
    amount SMALLINT NOT NULL,
    unit_price NUMERIC NOT NULL,
    PRIMARY KEY(order_id, product_id)
);
```

### Get restaurants 

```sql
SELECT * FROM restaurants;
```
> returns all columns from `restaurants` table

### Get menu for restaurant

```sql
SELECT * FROM products 
WHERE restaurant_id = '?';
```
> returns all columns from `products` table filtered by `restaurant_id`

### Search restaurants

```sql
SELECT * FROM restaurants 
WHERE restaurant_id LIKE '?'
AND address LIKE '?'
AND type LIKE '?'
AND price_level LIKE '?';
```
> returns all columns from `restaurants` table filtered for multiple parameters.
>
> `LIKE` allows pattern seaarch where the pattern is given as a string with % as 
> wildcard, so '%food' would match "fast food" as well as "street food" but not "food corner"


### Get users orders

```sql
SELECT * FROM orders 
WHERE user_name = '?'
ORDER BY order_date desc;
```
> returns all columns from `orders` table filtered for `user_name`
> in chronological order starting with the newest one

### Get order products

```sql
SELECT p.name, op.amount, op.product_price, op.amount * op.product_price as total_price FROM orders_products op
JOIN products p on (op.product_id = p.product_id)
where op.order_id = 'order_id';
```
> returns a list as follows:
>
> Product | amount | product price | total price
> --- | --- | --- | ---
> Chicken Burger | 3 | 4.20 | 12.80
> French Fries | 1 | 2.30 | 2.30

### Get order status

```sql
SELECT order_status FROM orders 
WHERE order_id = '?';
```
> returns only the `order_status` from a single record in the `orders` table

### Insert user or manager

```sql
INSERT INTO users values (
    'user_name',
    'address',
    'manager',
    'password_hash'
);
```

[Example](./sql/insert-users.sql)

### Insert restaurant

```sql
INSERT INTO restaurants (restaurant_name, manager_name, address, opens, closes, price_level, type, image) VALUES (
    'restaurant_name',
    'manager_name',
    'address',
    'opens',
    'closes',
    'price_level',
    'image',
    'type'
);
```
This will throw an error if `manager_name` is not in the `users` table
due to the `REFERENCES` constraint in the table definitions

[Example](./sql/insert-restaurants.sql)

### Insert product

```sql
INSERT INTO products(restaurant_id, product_name, description, price, image, categories)
VALUES (
    (SELECT restaurant_id from restaurants WHERE restaurant_name = 'best burgers'),
    'product_name',
    'description',
    'price',
    'image',
    'categories'
);
```
This will throw an error if `restaurant_id` or `product_id` do not exist
due to the `REFERENCES` constraint in the table definitions

[Example](./sql/insert-products.sql)

### Insert order

Before inserting an order get an id form the database. The id will be needed 
multiple times for inserting an order.

```sql
SELECT NEXTVAL('order_pk_seq');
```
use the returned value in place of `order_id`

```sql
INSERT INTO orders VALUES (
    'order_id',
    'restaurant_id',
    'user_name',
    'order_status',
    'date',
    'total',
    (SELECT address FROM users
    WHERE user_name = 'user_name')
);
```
This will throw an error if `order_id`, `restaurant_id` or `user_name` 
does not exist due to the `REFERENCES` constraint in the table definitions

for every item in the order run:
```sql
INSERT INTO orders_products VALUES (
    'order_id',
    'product_id',
    'amount',
    (SELECT price FROM products
    WHERE product_id = 'product_id')
);
```
This will throw an error if `order_id` or `product_id` do not exist

Next run this to set the price for the order. Skip this if you
have already set the orders total in the first statement.
```sql
UPDATE orders 
SET total = (
    SELECT sum(amount * product_price) 
    FROM orders_products
    WHERE order_id = 'order_id'
)
WHERE order_id = 'order_id'
```

[Example](./sql/insert-order.sql)

### Update order status

```sql
UPDATE orders SET order_status = ?
WHERE order_id = ?
```