
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

| order_id (pk) | restaurant_name (fk)| user_name (fk) | status    | order_date | total_price |
| ------------- | --------------------| -------------- | ------    | ---------- | ----------- |
| 31151         | Even Better Burgers | Nina Fisher    | delivered | 2021.11.05 | 27.20       |
| 11239         | Best Burgers        | Anna Greta     | preparing | 2021.10.22 | 16.50       |

### orders_products

| order_id (pk) | product_id (pk) | amount | unit_price |
| ------------- | --------------- | ------ | ---------- |
| 31151         | 3456789feh332   | 1      | 2.50       |
| 11239         | ertz5678tzu45   | 3      | 4.20       |



## Oparations, Queries and Statements
