const mongoose = require("mongoose")

const productSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "Product name is required"],
      trim: true,
      minlength: [3, "Product name must be at least 3 characters long"],
      maxlength: [100, "Product name cannot exceed 100 characters"],
    },
    price: {
      type: Number,
      required: [true, "Product price is required"],
      min: [0, "Price cannot be negative"],
      validate: {
        validator: (value) => value >= 0,
        message: "Price must be a positive number",
      },
    },
    category: {
      type: String,
      required: [true, "Product category is required"],
      trim: true,
      minlength: [2, "Category must be at least 2 characters long"],
      maxlength: [50, "Category cannot exceed 50 characters"],
    },
  },
  {
    timestamps: true, // Adds createdAt and updatedAt fields
  },
)

// Create and export the Product model
const Product = mongoose.model("Product", productSchema)

module.exports = Product
