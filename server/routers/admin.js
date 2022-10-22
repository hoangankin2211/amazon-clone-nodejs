const express = require('express');
const adminRouter = express.Router();
const admin = require('../middleware/admin');
const Product = require('../models/product');

adminRouter.post("/admin/addProduct", admin, async (req,res) => {
    try {
        const { name, description, quantity, images, category, price } = req.body
        let product = new Product({ name, description, quantity, images, category, price});
        product = await product.save();
        console.log(product.name)
        res.json(product);
    } catch (error) {
        console.log(error.message)
        res.status(500).json({ error: error.message });
    }
});

module.exports = adminRouter;