# API

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

`POST /customer/cart`

#### Show shopping cart contents

> - Show final costs

`GET /customer/cart`

#### Buy cart contents

- Select Delivery location
- Customer can buy only from one restaurant at time
- Make payment with a fictional payment system
  - **How to make sure customer has payed?**

```
[
    12345,
    23456,
    34567
]
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
    priceLevel: 2
}
```

`POST /manager/restaurants`

### Product

#### Create product

> Create restaurants menu
> Create product to category

```
{
    restaurantId: 12345,
    name: "Garlic Bread",
    description: "Lorem ipsum dolor sit amet",
    price: 4,
    image: ???
    category: ["bread", "garlic"]
}
```

> if category doesn't exist backend creates it

`POST /manager/restaurants/product`

## Orders

#### Receive order

> Shows orders that have `0: Received` status

`GET /manager/restaurants/{restaurantId}/ordres/new`

#### Change order status with Estimated Time of Completion

```
{
    orderId: 12345,
    status: 1
}
```

> - 0: Received
> - 1: Preparing
> - 2: Ready for delivery
> - 3: Delivering
> - 4: Delivered

`POST /manager/restaurants/orders`

#### View order history

`GET /manager/restaurants/{restaurantId}/orders`
