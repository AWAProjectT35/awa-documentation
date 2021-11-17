# API

- GET /public/restaurants
- GET /public/restaurants/
  - ?id={restaurantId}
  - ?name={restaurantName}
  - ?address={address}
  - ?type={type}
  - ?price={price}
- GET /public/restaurants/{restaurantId}/menu
- POST /public/users
- POST /public/users/login
- POST /customer/cart/{productId}
- GET /customer/cart
- POST /customer/cart/buy
- GET /customer/orders
- GET /customer/orders/{orderId}
- POST /customer/orders/confirm
- POST /manager/restaurants
- POST /manager/restaurants/{restaurantId}/menu
- POST /manager/restaurants/{restaurantId}/product
- GET /manager/restaurants/{restaurantId}/ordres/new
- POST /manager/restaurants/{restaurantId}/orders/{orderId}
- GET /manager/restaurants/{restaurantId}/orders

## Public

### Restaurants

#### Browse restaurants

`GET /public/restaurants`

#### Search for restaurants

`GET /public/restaurants/?id={restaurantId}`

`GET /public/restaurants/?name={restaurantName}`

`GET /public/restaurants/?address={address}`

`GET /public/restaurants/?type={type}`

`GET /public/restaurants/?price={price}`

#### Browse restaurant menus

`GET /public/restaurants/{restaurantId}/menu`

### Users

#### Create user account

> - Customer account
> - Manager account

```
{
    userName: "Jaska Jokunen",
    address: "Kuusitie 6",
    manager: False,
    password: "32lökfjaweoi"
}
```

`POST /public/users`

#### Login with user account

> - Customer account
> - Manager account

```
{
    userName: "Jaska Jokunen"
    password: "32lökfjaweoi"
}
```

`POST /public/users/login`


## Customer

### Shopping cart

#### Add products from a restaurant menu to shopping cart

```
{
    productId: 12345
}
```

`POST /customer/cart/{productId}`

#### Show shopping cart contents

> - Show final costs

`GET /customer/cart`

#### Buy cart contents

- Select Delivery location
- Make payment with a fictional payment system
  - **How to make sure customer has payed?**

```
{
    restaurantId: 007,
    products:
        [
            12345,
            23456,
            34567
        ]
}
```

`POST /customer/cart/buy`

### Orders

#### View order history

`GET /customer/orders`

#### View an order

> View order status

`GET /customer/orders/{orderId}`

#### Confirm delivered order

```
{
    orderId: 98765,
    status: 4
}
```

`POST /customer/orders/confirm`


## Manager

### Restaurants

#### Create a restaurant to the system with basic information

```
{
    restaurantName: "Bandidos",
    address: "Puistokatu 31",
    operatingHours: "11:00 - 22:00",
    image: "/path/to/image.png",
    type: "Casual",
    priceLevel: "€€"
}
```

`POST /manager/restaurants`

### Menu

#### Create restaurants menu

```
[
    12345,
    23456,
    34567
]
```

`POST /manager/restaurants/{restaurantId}/menu`

### Product

#### Create product to category

```
{
    name: "Garlic Bread",
    description: "Lorem ipsum dolor sit amet",
    price: 4,
    image: ???
    category: ["bread", "garlic"]
}
```

> if category doesn't exist backend creates it

`POST /manager/restaurants/{restaurantId}/product`

## Orders

#### Receive order

> Shows orders that have `0: Received` status

`GET /manager/restaurants/{restaurantId}/ordres/new`

#### Change order status with Estimated Time of Completion

```
{
    status: 1
}
```

> - 0: Received
> - 1: Preparing
> - 2: Ready for delivery
> - 3: Delivering
> - 4: Delivered

`POST /manager/restaurants/{restaurantId}/orders/{orderId}`

#### View order history

`GET /manager/restaurants/{restaurantId}/orders`
