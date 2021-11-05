# API

## Without User Login

Return all restaurants

`GET /restaurants`

Return restaurant that matches `id`

`GET /restaurants/{restaurantId}`

Create a new user

`POST /users`

Log in user with `username`

`POST /users/login/{username}`


## User logged in

### Shopping cart

Get shopping cart contents

`GET /cart`

Add item to cart

`POST /cart/add/{itemId}`

Buy cart contents

`POST /cart/buy`

### Orders

- **Confirm delivered order ?**

View all orders by user

`GET /orders

View order status

`GET /orders/{orderId}`
