
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

Create all the sequences and tables by typing or pasting the contents of [migration-up](../sqlmigration-up.sql)


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

## Delete and recreate a database

```bash
sudo -i -u postgres
psql
drop database <db-name>
create database <db-name>
\q 
```
run migration-up.sql from above again.