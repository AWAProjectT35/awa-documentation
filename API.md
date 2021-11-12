# API

- GET /public/restaurants
- GET /public/restaurants/{restaurantName}
- GET /public/restaurants/{restaurantName}/menu
- POST /public/users
- POST /public/users/login
- POST /customer/cart/{productId}
- GET /customer/cart
- POST /customer/cart/buy
- GET /customer/orders
- GET /customer/orders/{orderId}
- POST /customer/orders/confirm
- POST /manager/restaurants
- POST /manager/restaurants/{restaurantName}/menu
- POST /manager/restaurants/{restaurantName}/product
- GET /manager/restaurants/{restaurantName}/ordres/new
- POST /manager/restaurants/{restaurantName}/orders/{orderId}
- GET /manager/restaurants/{restaurantName}/orders

## Public

### Restaurants

#### Browse restaurants

`GET /public/restaurants`

#### Search for restaurants

`GET /public/restaurants/{restaurantName}`

#### Browse restaurant menus

`GET /public/restaurants/{restaurantName}/menu`

### Users

#### Create user account

> - Customer account
> - Manager account

> ```
> {
>     username: "jaska_jokunen",
>     address: "Kuusitie 6",
>     manager: False,
>     passwordHash: "32lökfjaweoi"
> }
> ```

`POST /public/users`

#### Login with user account

> - Customer account
> - Manager account

> ```
> {
>     username: "jaska_jokunen"
>     passwordHash: "32lökfjaweoi"
> }
> ```

`POST /public/users/login`


## Customer

### Shopping cart

#### Add products from a restaurant menu to shopping cart

> ```
> {
>     productId: 12345
> }
> ```

`POST /customer/cart/{productId}`

#### Show shopping cart contents

> - Show final costs

`GET /customer/cart`

#### Buy cart contents

> - Select Delivery location
> - Make payment with a fictional payment system
>   - **How to make sure customer has payed?**

> ```
> {
>     restaurantName: "Bandidos",
>     products:
>         [
>             12345,
>             23456,
>             34567
>         ]
> }
> ```

`POST /customer/cart/buy`

### Orders

#### View order history

`GET /customer/orders`

#### View an order

> View order status

`GET /customer/orders/{orderId}`

#### Confirm delivered order

> ```
> {
>     orderId: 98765,
>     status: "Delivered"
> }
> ```

`POST /customer/orders/confirm`


## Manager

### Restaurants

#### Create a restaurant to the system with basic information

> Restaurant info
>
> ```
> {
>     restaurantName: "Bandidos",
>     address: "Puistokatu 31",
>     operatingHours: "11:00 - 22:00",
>     image: "/path/to/image.png",
>     type: "Casual",
>     priceLevel: "€€"
> }
> ```

`POST /manager/restaurants`

### Menu

#### Create restaurants menu

> List of product ids
>
> ```
> [
>     12345,
>     23456,
>     34567
> ]
> ```

`POST /manager/restaurants/{restaurantName}/menu`

### Product

#### Create product to category

> Product data
>
> ```
> {
>     name: "Garlic Bread",
>     description: "Lorem ipsum dolor sit amet",
>     price: 4,
>     image: ???
>     category: ["bread", "garlic"]
> }
>
> if category doesn't exist backend creates it
> ```

`POST /manager/restaurants/{restaurantName}/product`

## Orders

#### Receive order

> Shows orders that have `Received` status

`GET /manager/restaurants/{restaurantName}/ordres/new`

#### Change order status with Estimated Time of Completion

> ```
> {
>     status: "Preparing"
> }
> ```

> - Received
> - Preparing
> - Ready for delivery
> - Delivering
> - Delivered

`POST /manager/restaurants/{restaurantName}/orders/{orderId}`

#### View order history

`GET /manager/restaurants/{restaurantName}/orders`
