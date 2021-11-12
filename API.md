# API

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

`POST /public/users`

#### Login with user account

> - Customer account
> - Manager account

`POST /public/users/login/{username}`


## Customer

### Shopping cart

#### Add products from a restaurant menu to shopping cart

`POST /customer/cart/{productId}`

#### Show shopping cart contents

> - Show final costs

`GET /customer/cart`

#### Buy cart contents

> - Select Delivery location
> - Make payment with a fictional payment system

`POST /customer/cart/buy`

### Orders

#### View order history

`GET /customer/orders`

#### View an order

> View order status

`GET /customer/orders/{orderId}`

#### Confirm delivered order

> - Order status `Delivered`

`POST /customer/orders/confirm`


## Manager

### Restaurants

#### Create a restaurant to the system with basic information

> - Name
> - Address
> - Operating hours
> - Image
> - Restaurant type
>   - Buffet, Fast food, Fast casual, Casual dining, Fine dining
> - Price level
>   - €, €€, €€€, €€€€

`POST /manager/restaurants`

### Menu

#### Create restaurants menu

> - Sends list of products

`POST /manager/restaurants/{restaurantName}`

#### Create product to category

> - Name
> - Description
> - Price
> - Image
>
> if category doesn't exist backend creates it

`POST /manager/restaurants/{restaurantName}/products`

#### Receive order

> Shows orders that have `Received` status

`GET /manager/restaurants/{restaurantName}/ordres/new`

#### Change order status with Estimated Time of Completion

> - Received
> - Preparing
> - Ready for delivery
> - Delivering
> - Delivered

`POST /manager/restaurants/{restaurantName}/orders/{orderId}`

#### View order history

`GET /manager/restaurants/{restaurantName}/orders`
