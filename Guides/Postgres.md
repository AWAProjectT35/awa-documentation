
# Postgres

## Local install

Debian/Ubuntu

    sudo apt install postgresql postgresql-contrib

Arch

    sudo pacman -S postgresql
    sudo -u postgres –i  initdb -D '/var/lib/postgres/data'
    exit
    sudo systemctl enable postgresql
    sudo systemctl start postgresql

## Configure database awa project

To connect to the database with the default user `postgres` run this:

    sudo -i -u postgres
    psql

now change the password for the postgres user (default is a blank password). 

    ALTER USER postgres WITH PASSWORD 'password';

Create a new database 

```sql
CREATE DATABASE awa;
```
switch to awa database

    \c awa

Create all the tables

```sql

create table users (
    user_name VARCHAR(50) NOT NULL PRIMARY KEY,
    address VARCHAR(50) NOT NULL,
    manager BOOLEAN NOT NULL,
    password_hash VARCHAR(50) NOT NULL
);
create table restaurants (
    restaurant_id INT NOT NULL PRIMARY KEY,
    restaurant_name VARCHAR(50) NOT NULL,
    manager_name VARCHAR(20) REFERENCES users (user_name),
    address VARCHAR(50) NOT NULL,
    opens VARCHAR(5) NOT NULL,
    closes VARCHAR(5) NOT NULL,
    price_level SMALLINT NOT NULL,
    type VARCHAR(20) NOT NULL,
    image VARCHAR(100) NOT NULL
);
create table products (
    product_id INT NOT NULL PRIMARY KEY,
    restaurant_id INT REFERENCES restaurants (restaurant_id),
    product_name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    price NUMERIC NOT NULL,
    image VARCHAR(100),
    categories VARCHAR(100)
);
create table orders (
    order_id INT NOT NULL PRIMARY KEY,
    restaurant_id INT REFERENCES restaurants (restaurant_id),
    user_name VARCHAR(50) REFERENCES users (user_name),
    order_status SMALLINT NOT NULL,
    order_date DATE NOT NULL,
    total NUMERIC NOT NULL
);
create table orders_products (
    order_id INT REFERENCES orders (order_id),
    product_id INT REFERENCES products (product_id),
    amount SMALLINT NOT NULL,
    product_price NUMERIC NOT NULL,
    PRIMARY KEY(order_id, product_id)
);

```

## Access

You can use a VS Code extension to connect the database and run queries 
more easily: **Database Client**

> username: posgres
> 
> password: password
> 
> port: 5432
> 
> database: awa

now you can open a `.sql` file and run it directly on the database with the run 
button in the top right.
