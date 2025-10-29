const express = require("express")
const router = express.Router()
const Product = require("../models/Product")

router.get("/", async (req, res) => {
  try {
    const products = await Product.find().sort({ createdAt: -1 })
    res.status(200).json(products)
  } catch (error) {
    res.status(500).json({
      message: "Error retrieving products",
      error: error.message,
    })
  }
})

router.get("/:id", async (req, res) => {
  try {
    const { id } = req.params

    // Validate MongoDB ObjectId
    if (!id.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({ message: "Invalid product ID format" })
    }

    const product = await Product.findById(id)

    if (!product) {
      return res.status(404).json({ message: "Product not found" })
    }

    res.status(200).json(product)
  } catch (error) {
    res.status(500).json({
      message: "Error retrieving product",
      error: error.message,
    })
  }
})

router.post("/", async (req, res) => {
  try {
    const { name, price, category } = req.body

    // Validate required fields
    if (!name || !price || !category) {
      return res.status(400).json({
        message: "Missing required fields: name, price, category",
      })
    }

    // Create new product
    const newProduct = new Product({
      name,
      price,
      category,
    })

    // Save to database
    const savedProduct = await newProduct.save()

    res.status(201).json({
      message: "Product created successfully",
      product: savedProduct,
    })
  } catch (error) {
    // Handle validation errors
    if (error.name === "ValidationError") {
      const messages = Object.values(error.errors).map((err) => err.message)
      return res.status(400).json({
        message: "Validation error",
        errors: messages,
      })
    }

    res.status(500).json({
      message: "Error creating product",
      error: error.message,
    })
  }
})

router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params
    const { name, price, category } = req.body

    // Validate MongoDB ObjectId
    if (!id.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({ message: "Invalid product ID format" })
    }

    // Validate that at least one field is provided
    if (!name && !price && !category) {
      return res.status(400).json({
        message: "At least one field (name, price, or category) must be provided",
      })
    }

    // Build update object with only provided fields
    const updateData = {}
    if (name !== undefined) updateData.name = name
    if (price !== undefined) updateData.price = price
    if (category !== undefined) updateData.category = category

    // Find and update product
    const updatedProduct = await Product.findByIdAndUpdate(id, updateData, {
      new: true, // Return updated document
      runValidators: true, // Run schema validators
    })

    if (!updatedProduct) {
      return res.status(404).json({ message: "Product not found" })
    }

    res.status(200).json({
      message: "Product updated successfully",
      product: updatedProduct,
    })
  } catch (error) {
    // Handle validation errors
    if (error.name === "ValidationError") {
      const messages = Object.values(error.errors).map((err) => err.message)
      return res.status(400).json({
        message: "Validation error",
        errors: messages,
      })
    }

    res.status(500).json({
      message: "Error updating product",
      error: error.message,
    })
  }
})

router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params

    // Validate MongoDB ObjectId
    if (!id.match(/^[0-9a-fA-F]{24}$/)) {
      return res.status(400).json({ message: "Invalid product ID format" })
    }

    // Find and delete product
    const deletedProduct = await Product.findByIdAndDelete(id)

    if (!deletedProduct) {
      return res.status(404).json({ message: "Product not found" })
    }

    res.status(200).json({
      message: "Product deleted",
      product: deletedProduct,
    })
  } catch (error) {
    res.status(500).json({
      message: "Error deleting product",
      error: error.message,
    })
  }
})

module.exports = router
