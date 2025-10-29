# Product CRUD API

A Node.js/Express application that implements Create, Read, Update, and Delete (CRUD) operations for a Product database using MongoDB and Mongoose.

## Features

- **Create**: Add new products with name, price, and category
- **Read**: Retrieve all products or a specific product by ID
- **Update**: Modify product details by ID
- **Delete**: Remove products from the database
- **Validation**: Comprehensive data validation and error handling
- **Error Handling**: Proper HTTP status codes and error messages

## Prerequisites

- Node.js (v14 or higher)
- MongoDB (local or cloud instance)
- npm or yarn

## Installation

1. **Clone or download the project**

2. **Install dependencies**
   \`\`\`bash
   npm install
   \`\`\`

3. **Configure environment variables**
   - Copy `.env.example` to `.env`
   - Update `MONGODB_URI` with your MongoDB connection string
   - Optionally set `PORT` (default: 3000)

   \`\`\`env
   MONGODB_URI=mongodb://localhost:27017/product-db
   PORT=3000
   NODE_ENV=development
   \`\`\`

## Running the Application

### Development Mode (with auto-reload)
\`\`\`bash
npm run dev
\`\`\`

### Production Mode
\`\`\`bash
npm start
\`\`\`

The server will start on `http://localhost:3000`

## API Endpoints

### 1. Get All Products
\`\`\`
GET /products
\`\`\`
**Response (200 OK):**
\`\`\`json
[
  {
    "_id": "686f6c106b7e1b4605d09e60",
    "name": "Laptop",
    "price": 1200,
    "category": "Electronics",
    "createdAt": "2024-01-15T10:30:00.000Z",
    "updatedAt": "2024-01-15T10:30:00.000Z"
  },
  {
    "_id": "686f6c106b7e1b4605d09e61",
    "name": "Wireless Mouse",
    "price": 25,
    "category": "Accessories",
    "createdAt": "2024-01-15T10:31:00.000Z",
    "updatedAt": "2024-01-15T10:31:00.000Z"
  }
]
\`\`\`

### 2. Get Product by ID
\`\`\`
GET /products/:id
\`\`\`
**Example:**
\`\`\`
GET /products/686f6c106b7e1b4605d09e60
\`\`\`

**Response (200 OK):**
\`\`\`json
{
  "_id": "686f6c106b7e1b4605d09e60",
  "name": "Laptop",
  "price": 1200,
  "category": "Electronics",
  "createdAt": "2024-01-15T10:30:00.000Z",
  "updatedAt": "2024-01-15T10:30:00.000Z"
}
\`\`\`

### 3. Create a New Product
\`\`\`
POST /products
Content-Type: application/json

{
  "name": "Laptop",
  "price": 1200,
  "category": "Electronics"
}
\`\`\`

**Response (201 Created):**
\`\`\`json
{
  "message": "Product created successfully",
  "product": {
    "_id": "686f6c106b7e1b4605d09e60",
    "name": "Laptop",
    "price": 1200,
    "category": "Electronics",
    "createdAt": "2024-01-15T10:30:00.000Z",
    "updatedAt": "2024-01-15T10:30:00.000Z"
  }
}
\`\`\`

### 4. Update a Product
\`\`\`
PUT /products/:id
Content-Type: application/json

{
  "name": "Gaming Laptop",
  "price": 1500
}
\`\`\`

**Example:**
\`\`\`
PUT /products/686f6c106b7e1b4605d09e60
\`\`\`

**Response (200 OK):**
\`\`\`json
{
  "message": "Product updated successfully",
  "product": {
    "_id": "686f6c106b7e1b4605d09e60",
    "name": "Gaming Laptop",
    "price": 1500,
    "category": "Electronics",
    "createdAt": "2024-01-15T10:30:00.000Z",
    "updatedAt": "2024-01-15T10:35:00.000Z"
  }
}
\`\`\`

### 5. Delete a Product
\`\`\`
DELETE /products/:id
\`\`\`

**Example:**
\`\`\`
DELETE /products/686f6c106b7e1b4605d09e60
\`\`\`

**Response (200 OK):**
\`\`\`json
{
  "message": "Product deleted",
  "product": {
    "_id": "686f6c106b7e1b4605d09e60",
    "name": "Laptop",
    "price": 1200,
    "category": "Electronics",
    "createdAt": "2024-01-15T10:30:00.000Z",
    "updatedAt": "2024-01-15T10:30:00.000Z"
  }
}
\`\`\`

## Data Validation

### Product Schema Validation Rules

| Field | Type | Requirements |
|-------|------|--------------|
| name | String | Required, 3-100 characters |
| price | Number | Required, must be >= 0 |
| category | String | Required, 2-50 characters |

### Error Responses

**400 Bad Request** - Validation Error:
\`\`\`json
{
  "message": "Validation error",
  "errors": [
    "Product name must be at least 3 characters long"
  ]
}
\`\`\`

**404 Not Found** - Product not found:
\`\`\`json
{
  "message": "Product not found"
}
\`\`\`

**500 Internal Server Error**:
\`\`\`json
{
  "message": "Error creating product",
  "error": "Error details"
}
\`\`\`

## Project Structure

\`\`\`
product-crud-app/
├── server.js              # Main Express server file
├── package.json           # Project dependencies
├── .env.example           # Environment variables template
├── .env                   # Environment variables (create from .env.example)
├── models/
│   └── Product.js         # Mongoose Product schema and model
├── routes/
│   └── productRoutes.js   # API routes for CRUD operations
└── README.md              # This file
\`\`\`

## Testing with cURL

### Create a Product
\`\`\`bash
curl -X POST http://localhost:3000/products \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Laptop",
    "price": 1200,
    "category": "Electronics"
  }'
\`\`\`

### Get All Products
\`\`\`bash
curl http://localhost:3000/products
\`\`\`

### Get Product by ID
\`\`\`bash
curl http://localhost:3000/products/686f6c106b7e1b4605d09e60
\`\`\`

### Update a Product
\`\`\`bash
curl -X PUT http://localhost:3000/products/686f6c106b7e1b4605d09e60 \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Gaming Laptop",
    "price": 1500
  }'
\`\`\`

### Delete a Product
\`\`\`bash
curl -X DELETE http://localhost:3000/products/686f6c106b7e1b4605d09e60
\`\`\`

## Testing with Postman

1. Import the API endpoints into Postman
2. Set the base URL to `http://localhost:3000`
3. Create requests for each endpoint
4. Test CRUD operations with sample data

## MongoDB Connection

### Local MongoDB
If running MongoDB locally:
\`\`\`env
MONGODB_URI=mongodb://localhost:27017/product-db
\`\`\`

### MongoDB Atlas (Cloud)
For MongoDB Atlas:
\`\`\`env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/product-db?retryWrites=true&w=majority
\`\`\`

## Error Handling

The application includes comprehensive error handling:

- **Validation Errors**: Schema validation with detailed error messages
- **Database Errors**: Connection and query error handling
- **HTTP Errors**: Proper status codes (400, 404, 500)
- **Input Validation**: ObjectId format validation
- **Required Fields**: Validation for mandatory fields

## Best Practices Implemented

1. **Schema Validation**: Mongoose schema with built-in validators
2. **Error Handling**: Try-catch blocks and error middleware
3. **HTTP Status Codes**: Appropriate status codes for each operation
4. **Input Sanitization**: Trim and validate all inputs
5. **Timestamps**: Automatic createdAt and updatedAt fields
6. **Modular Structure**: Separated models, routes, and server logic
7. **Environment Variables**: Configuration through .env file
8. **Documentation**: Comprehensive README with examples

## Troubleshooting

### MongoDB Connection Error
- Ensure MongoDB is running
- Check MONGODB_URI in .env file
- Verify network connectivity for cloud databases

### Port Already in Use
- Change PORT in .env file
- Or kill the process using the port

### Validation Errors
- Check field requirements in the schema
- Ensure data types match (price should be a number)
- Verify string length requirements

## License

ISC

## Author

Created as a learning project for CRUD operations with MongoDB and Mongoose.
