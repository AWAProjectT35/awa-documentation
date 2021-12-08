
# Testcase


**Feature under test:** Test public routes

**Test designed by:** Lucas Aebi

**Test designed date:** 7.12.2021


| #    | Executed date | Executed by | result          | Github bug    |
| ---- | ------------- | ----------- | --------------- | ------------- |
|    1 | 8.12.2021     | Lucas Aebi  | success         |               |


## Preconditions / Test setup

Run these queries on empty database or create the entries manually:

```sql
insert into users values('Marie Grünenfelder', 'Oulu', true, 'auewlj');

insert into restaurants values (nextval('restaurant_pk_seq'),
    'Restaurant A',
    'Marie Grünenfelder',
    'Addresse 1',
    '8:00',
    '22:00',
    3,
    'Categorie A',
    '/url');

insert into restaurants values (nextval('restaurant_pk_seq'),
    'Restaurant B',
    'Marie Grünenfelder',
    'Addresse 2',
    '10:00',
    '20:00',
    1,
    'Categorie B',
    '/url');

insert into products values(
    1111,
    1111,
    'Product A',
    'irrelevant',
    12.50,
    '/irrelevant',
    'cat 1'
);

insert into products values(
    1111,
    2222,
    'Product B',
    'irrelevant',
    2.50,
    '/irrelevant',
    'cat 2'
);
insert into products values(
    3333,
    2222,
    'Product B',
    'irrelevant',
    2.50,
    '/irrelevant',
    'cat 1'
);

```

## Testing steps

**Step 1**

Call `GET /public/restaurants`. This should return:

```json
[
  {
    "restaurantId": 1111,
    "restaurantName": "Restaurant A",
    "managerName": "Marie Grünenfelder",
    "address": "Addresse 1",
    "opens": "8:00",
    "closes": "22:00",
    "image": "/url",
    "type": "Categorie A",
    "priceLevel": 3
  },
  {
    "restaurantId": 2222,
    "restaurantName": "Restaurant B",
    "managerName": "Marie Grünenfelder",
    "address": "Addresse 2",
    "opens": "10:00",
    "closes": "20:00",
    "image": "/url",
    "type": "Categorie B",
    "priceLevel": 1
  }
]
```

**Step 2** 
_not in use anymore since 8.12.2021_

> Call `GET /public/restaurants` with the following queriy parameters:
> 
> - address: Addresse A
> - restaurantName: Restaurant A
> - price: 3
> - type: Categoie A
> 
> this should return:
> 
> ```json
> [
>   {
>     "restaurantId": 1111,
>     "restaurantName": "Restaurant A",
>     "managerName": "Marie Grünenfelder",
>     "address": "Addresse 1",
>     "opens": "8:00",
>     "closes": "22:00",
>     "image": "/url",
>     "type": "Categorie A",
>     "priceLevel": 3
>   }
> ]
```

**Step 3**

Call `GET /public/restaurants` with the following queriy parameters:

- address: Addresse C

this should return an empty array.

**Step 4**

Call `GET /public/restaurants/1111`

this should return:

```json
{
  "restaurantId": 1111,
  "restaurantName": "Restaurant A",
  "managerName": "Marie Grünenfelder",
  "address": "Addresse 1",
  "opens": "8:00",
  "closes": "22:00",
  "image": "/url",
  "type": "Categorie A",
  "priceLevel": 3
}
```

**Step 5**

Call `GET /public/restaurants/1111/menu`

This should return:

```json
[
  {
    "productId": 2222,
    "restaurantId": 1111,
    "name": "Product B",
    "description": "irrelevant",
    "price": 2.5,
    "image": "/irrelevant",
    "category": "cat 2"
  },
  {
    "productId": 1111,
    "restaurantId": 1111,
    "name": "Product A",
    "description": "irrelevant",
    "price": 12.5,
    "image": "/irrelevant",
    "category": "cat 1"
  }
]
```
**Step 6**

Call `POST /public/users` with this body:

```json
{
	"userName":"Oscar Wild",
	"address":"Adress A",
	"manager":false,
	"password":"password"
}
```
This should return a status code 201 and the text CREATED.

