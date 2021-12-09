

# Testcase


**Feature under test:** Customer routes

**Test designed by:** Lucas Aebi

**Test designed date:** 7.12.2021


| #    | Executed date | Executed by | Result          | Level  | Github bug    |
| ---- | ------------- | ----------- | --------------- | ------ | ------------- |
|    1 | 8.12.2021     | Lucas Aebi  | success         | local  | -             |

> Report bugs on Github by creating an issue with the label `Bug` and paste 
> a link to the bug report in the table above


## Preconditions / Test setup

Run these statements on empty database or create the entries manually:

```sql
insert into users values('Marie Grünenfelder', 'Oulu', true, 'auewlj');
insert into users values('Test User', 'Oulu', false, 'auewlj');

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

Call `POST /public/users` with this body:

```json
{
	"userName":"Oscar Wild",
	"address":"Address A",
	"manager":false,
	"password":"password"
}
```
This should return a status code 201 and the text CREATED.

**Step 2**

Call `POST /login` using http basic auth with these credentials:
- username: Oscar Wild
- password: password


this should return something like this:

```json
{
    "access_token":"2qoiwlke.fhüofiqöfnlwehöoiwaefhöoiq"
}
```

**Step 3**

Call `POST /customer/buy` with Bearer Authentication with the token received from Step 2 and this body:

```json
{
	"products": {
		"1111":3,
		"2222":1
	},
	"deliveryAddress":"Address B"
}
```

this should return a status code `200` and the text "order placed".

**Step 4**

Call `POST /customer/buy` with Bearer Authentication with the token received from Step 2 and this body:

```json
{
	"products": {
		"1111":3,
		"2222":1
	},
    "deliveryAddress": null
}
```

this should return a status code `200` and the text "order placed".

**Step 5**

Call `GET /customer/orders`

This should return(the order date is allowed to differ from this
response of course):

```json
[
  {
    "orderId": 1,
    "restaurantId": 1111,
    "username": "Oscar Wild",
    "orderStatus": 0,
    "orderDate": "2021-12-08",
    "total": 37.5,
    "deliveryAddress": "Address A",
    "eta": null
  },
  {
    "orderId": 2,
    "restaurantId": 1111,
    "username": "Oscar Wild",
    "orderStatus": 0,
    "orderDate": "2021-12-08",
    "total": 37.5,
    "deliveryAddress": "Address B",
    "eta": null
  },
]
```

**Step 6**

Call `POST /customer/buy` with Bearer Authentication with the token received from Step 2 and this body:

```json
{
	"products": {
		"1111":3,
		"3333":1
	},
    "deliveryAddress": null
}
```
This should return a status code `400` and a message stating that 
only products from the same restaurant can be ordered together.

**Step 7**

Call `GET /customer/orders/1` with Bearer Authentication using the token 
received in Step 2.

This should return the following(ignore date):

```json
{
  "details": {
    "orderId": 1,
    "restaurantId": 1111,
    "username": "Oscar Wild",
    "orderStatus": 0,
    "orderDate": "2021-12-08",
    "total": 37.5,
    "deliveryAddress": "Address B",
    "eta": null
  },
  "products": [
    {
      "orderId": 1,
      "productId": 2222,
      "amount": 1,
      "productPrice": 2.5
    },
    {
      "orderId": 1,
      "productId": 1111,
      "amount": 3,
      "productPrice": 12.5
    }
  ]
}
```

**Step 8**

Call `POST /customer/orders/1/confirm` with Bearer Authentication using the token 
received in Step 2.

This should result in a status code `400 BAD REQUEST`.


**Step 9**

Run this statement on the database:

```sql
update orders set order_status = 3
```

Call `POST /customer/orders/1/confirm` with Bearer Authentication using the token 
received in Step 2 again.

This should result in a status code `200 OK` and the message Delivery Confirmed.


**Step 10**

Insert an order for a different user:

```sql
insert ino orders values (
    4444,
    1111,
    'Test User',
    0,
    current_date,
    0,
    'Address',
    'eta'
);
```

Call `GET /customer/orders/4444` and `POST /customer/orders/4444/confirm`
with Bearer Authentication using the token received in Step 2.

Both should return a status code `403 FORBIDDEN`.

**Step 11**

Call `GET /customer/orders/1234` and `POST /customer/orders/1234/confirm` 
with Bearer Authentication using the token received in Step 2.

Both should return status code `404 NOT FOUND` 