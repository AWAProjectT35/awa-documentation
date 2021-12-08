
# Testcase


**Feature under test:** Manager routes

**Test designed by:** Lucas Aebi

**Test designed date:** 7.12.2021


| #    | Executed date | Executed by | result          | Github Bug    |
| ---- | ------------- | ----------- | --------------- | ------------- |
|    1 | 8.12.2021     | Lucas Aebi  | success         |               |


## Preconditions / Test setup

Run these statements on empty database or create the entries manually:

```sql

```

## Testing steps

**Step 1**

Call `POST /public/users` with this body:

```json
{
	"userName":"Manager 1",
	"address":"Address A",
	"manager":true,
	"password":"password"
}
```
This should return a status code 201 and the text CREATED.

**Step 2**

Call `POST /login` using HTTP Basic auth and these credentials:

- username: Manager 1
- password: password

This should return a token looking something like this

```json
{
    "access_token":"2qoiwlke.fhüofiqöfnlwehöoiwaefhöoiq"
}
```
**Step 3**


Call `POST /manager/restaurants` 
using Bearer Authentication with the token received in Step 2 
and this body:

```json
{
	"restaurantName":"Restaurant A",
	"address":"Address A",
	"image":"/irrelevant",
	"opens":"8:00",
	"closes":"22:00",
	"type":"typ A",
	"priceLevel": 1
}
```

Call `POST /manager/restaurants` 
using Bearer Authentication with the token received in Step 2 
and this body:

```json
{
	"restaurantName":"Restaurant B",
	"address":"Address B",
	"image":"/irrelevant",
	"opens":"8:00",
	"closes":"22:00",
	"type":"typ B",
	"priceLevel": 2
}
```

Both calls should return status code `201 CREATED`

**Step 4**

Call `GET /manager/restaurants` 
using Bearer Authentication with the token received in Step 2 

This should return status code `200 OK` and this response body:

```json
[
  {
    "restaurantId": 1,
    "restaurantName": "Restaurant A",
    "managerName": "Manager 1",
    "address": "Address A",
    "opens": "8:00",
    "closes": "22:00",
    "image": "/irrelevant",
    "type": "type A",
    "priceLevel": 1
  },
  {
    "restaurantId": 2,
    "restaurantName": "Restaurant B",
    "managerName": "Manager 1",
    "address": "Address B",
    "opens": "8:00",
    "closes": "22:00",
    "image": "/irrelevant",
    "type": "type B",
    "priceLevel": 2
  }
]
```

**Step 5**

Call `POST /manager/restaurants/1/products`
using Bearer Authentication with the token received in Step 2 
and this body:

```json
{
    "name":"Product A",
    "description":"description",
    "price": 2,
    "image":"/irrelevant",
    "category":"cat A"
}
```

this should return status code `201 CREATED`.

**Step 6**

Call `GET /manager/restaurants/1/products`
using Bearer Authentication with the token received in Step 2 
and this body:

```json
{
    "name":"Product A",
    "description":"description",
    "price": 2,
    "image":"/irrelevant",
    "category":"cat A"
}
```

this should return status code `201 CREATED`.


**Step 7**

Run this sql on the database:

```sql
insert into users values (
    'username',
    'Address C',
    false,
    'passwdhash'
);

insert into orders vlaues (
    1111,
    1,
    'username',
    0, 
    current_date,
    4,
    'Address C'
);

insert into orders_products values (
    1111, 1, 2, 2
);

insert into orders vlaues (
    2222,
    1,
    'username',
    1, 
    current_date,
    4,
    'Address C'
);
insert into orders_products values (
    2222, 1, 2, 2
);
```

Call `GET /manager/restaurants/1/orders`
using Bearer Authentication with the token received in Step 2 

This should return:

```json
[
  {
    "orderId": 1111,
    "restaurantId": 1,
    "username": "username",
    "orderStatus": 0,
    "orderDate": "2021-12-08",
    "total": 4.0,
    "deliveryAddress": "Address C",
    "eta": null
  },
  {
    "orderId": 2222,
    "restaurantId": 1,
    "username": "username",
    "orderStatus": 1,
    "orderDate": "2021-12-07",
    "total": 4.0,
    "deliveryAddress": "Address C",
    "eta": null
  },
]
```

**Step 8**

Call `GET /manager/restaurants/1/orders/new`
using Bearer Authentication with the token received in Step 2 

This should return:

```json
[
  {
    "orderId": 1111,
    "restaurantId": 1,
    "username": "username",
    "orderStatus": 0,
    "orderDate": "2021-12-08",
    "total": 4.0,
    "deliveryAddress": "Address C",
    "eta": null
  }
]
```

**Step 9**

Call `GET /manager/restaurants/orders/1111`
using Bearer Authentication with the token received in Step 2 

This should return:

```json
{
  "details": {
    "orderId": 1111,
    "restaurantId": 1,
    "username": "username",
    "orderStatus": 0,
    "orderDate": "2021-12-02",
    "total": 4.0,
    "deliveryAddress": "Address C",
    "eta": "null"
  },
  "products": [
    {
      "orderId": 1111,
      "productId": 1,
      "amount": 2,
      "productPrice": 2.0
    }
  ]
}
```

**Step 10**

Call `PUT /manager/restaurants/orders/1111`
using Bearer Authentication with the token received in Step 2 
and this body:

```json
{
	"status":3,
	"eta":"21:30"
}
```


This should return status code `200 OK`